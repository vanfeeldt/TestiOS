//
//  ResponseModels.swift
//  Test
//
//  Created by Alan Pérez Gómez on 31/03/22.
//

import Foundation

// First level response
struct ResponseModel: Decodable {
    let resultado: ResultadoResponseModel
}

// Second level response
struct ResultadoResponseModel: Decodable {
    let categoria: String
    let productos: Array<ProductoResponseModel>
}

// Third level response
struct ProductoResponseModel: Decodable {
    var categoria: String?
    let id: String
    let nombre: String
    let urlImagenes: Array<String>
    let precioFinal: Double
}
