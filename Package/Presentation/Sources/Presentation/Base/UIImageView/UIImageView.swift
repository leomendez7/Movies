//
//  UIImageView.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        // Comienza una tarea de URLSession para descargar la imagen
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Verifica si hay errores o si no se ha recibido data
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            // Crea una imagen desde los datos recibidos
            if let image = UIImage(data: data) {
                // Actualiza la imagen en el main thread
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
