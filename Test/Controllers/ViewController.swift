//
//  ViewController.swift
//  Test
//
//  Created by Alan Pérez Gómez on 31/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    // UI elements
    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    // Pushing new controller
    @IBAction func sendRequestActionButton(_ sender: UIButton) {
        // Instantiating controller from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let listController = storyboard.instantiateViewController(withIdentifier: "ProductsListViewController")
        // Setting cell selection delegate
        (listController as? ProductsListViewController)?.delegate = self
        navigationController?.pushViewController(listController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide unused elements
        cardStackView.isHidden = true
    }

}

// Implementing cell selection
extension ViewController: ProductCellDelegate {
    
    func setProduct(_ product: ProductoResponseModel) {
        
        cardStackView.isHidden = false
        
        // Setting the response data
        categoryLabel.text = product.categoria
        nameLabel.text = product.nombre
        priceLabel.text = "$\(product.precioFinal)"
        
        // Getting the image
        let imageUrl = URL(string: product.urlImagenes.first ?? "")!
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data {
               let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            }
        }.resume()
    }
    
}
