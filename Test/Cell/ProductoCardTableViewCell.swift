//
//  ProductoCardTableViewCell.swift
//  Test
//
//  Created by Alan Pérez Gómez on 31/03/22.
//

import UIKit

class ProductoCardTableViewCell: UITableViewCell {
    
    //UI elements
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //UI data filling
    func fillData(with product: ProductoResponseModel) {
        // Setting the response data
        categoryLabel.text = product.categoria
        nameLabel.text = product.nombre
        priceLabel.text = "$\(product.precioFinal)"
        
        // Getting the image
        if let imageUrl = URL(string: product.urlImagenes.first ?? "") {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data {
                   let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.productImageView.image = image
                    }
                }
            }.resume()
        }
        
    }
    
}
