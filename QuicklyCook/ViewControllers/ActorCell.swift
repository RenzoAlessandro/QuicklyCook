//
//  Actor.swift
//  QuicklyCook
//
//  Created by Renzo Alessandro on 11/26/19.
//  Copyright © 2019 Renzo Alessandro. All rights reserved.
//

import UIKit

class ActorCell: UITableViewCell {
    
    @IBOutlet weak var ImagenReceta: UIImageView!
    @IBOutlet weak var TituloReceta: UILabel!
    @IBOutlet weak var IngredientesReceta: UILabel!
    @IBOutlet weak var CaloriasReceta: UILabel!
    @IBOutlet weak var PorcionesReceta: UILabel!
    @IBOutlet weak var TiempoReceta: UILabel!
    @IBOutlet weak var UrlReceta: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
