//
//  ProductsListViewController.swift
//  Test
//
//  Created by Alan Pérez Gómez on 31/03/22.
//

import UIKit

// Communication with the first screen
protocol ProductCellDelegate: AnyObject { // Any object to avoid retain cycles
    func setProduct(_ product: ProductoResponseModel)
}

class ProductsListViewController: UIViewController {

    // UI Elements
    @IBOutlet weak var productdTableView: UITableView!
    
    // Properties
    private var products: Array<ProductoResponseModel> = Array()
    weak var delegate: ProductCellDelegate?
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell(.xib) in table
        let cellNib = UINib(nibName: "ProductoCardTableViewCell", bundle: Bundle.main)
        productdTableView.register(cellNib, forCellReuseIdentifier: "ProductoCardTableViewCell")
        
        // Delegation
        productdTableView.delegate =  self
        productdTableView.dataSource = self
        
        // Calling api
        makeRequest()
    }
    
    // Api
    private func makeRequest() {
        let urlString = "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) {
            [weak self] // capture list to avoid retain cycle
            data, response, error in
            if let data = data {
                let response = try? JSONDecoder().decode(ResponseModel.self, from: data)
                let category = response?.resultado.categoria
                response?.resultado.productos.forEach({ productoTemporal in
                    var producto = productoTemporal
                    producto.categoria = category
                    self?.products.append(producto)
                })
                
                DispatchQueue.main.async {
                    self?.productdTableView.reloadData()
                }
            }
        }.resume()
    }

}

// Table delegation
extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductoCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductoCardTableViewCell", for: indexPath) as! ProductoCardTableViewCell
        cell.fillData(with: products[indexPath.row])
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        delegate?.setProduct(product)
        navigationController?.popViewController(animated: true)
    }
    
}
