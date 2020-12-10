//
//  RecetaCellViewController.swift
//  QuicklyCook
//
//  Created by Renzo Alessandro on 11/26/19.
//  Copyright © 2019 Renzo Alessandro. All rights reserved.
//

import UIKit

class RecetaCellViewController: UITableViewCell {

    
    @IBOutlet weak var imagenReceta: UIImageView!
    
    @IBOutlet weak var TituloReceta: UILabel!
    
    @IBOutlet weak var IngredientesReceta: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
