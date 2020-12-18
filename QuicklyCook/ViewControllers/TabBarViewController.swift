//
//  TabBarViewController.swift
//  QuicklyCook
//
//  Created by Renzo Alessandro on 11/5/19.
//  Copyright © 2019 Renzo Alessandro. All rights reserved.
//

import UIKit
import Foundation

struct WebsiteDescription:Decodable{
    let q: String
    let from: Int
    let to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

struct Hit: Decodable{
    let recipe: Recipe
    
}

struct Recipe: Decodable{
    let uri: String?
    let label:String
    let image:String
    let source: String?
    let url: String?
    let yield: Int?
    let calories: Float?
    let totalWeight: Float?
    let totalTime: Int?
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable{
    let text: String
    let weight: Float

}


class TabBarViewController: UIViewController, UITextFieldDelegate ,UITableViewDataSource{

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var BuscarTextField: UITextField!
    
    var recipes = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonUrlString = "https://api.edamam.com/search?q=chicken&app_id=e533a2a7&app_key=49c51fa4ab6791c69b44ef037b33ddce"

        guard let url = URL(string: jsonUrlString) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            print("do spuff here")
            
            guard let data = data else {return}
            //let dataAsString = String(data: data,encoding: .utf8)
            //print(dataAsString)
            
            do{
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                //let recetas = try JSONDecoder().decode([Course].self, from: data)
                
                //print( websiteDescription.hits[0].recipe.count)
                //print("recipe", websiteDescription.hits[0].recipe[0])
                //print(websiteDescription.hits[0].recipe[0].ingredients[0].food.label)
                //let result = websiteDescription
                for hit in websiteDescription.hits {
                    //print(hit.recipe)
                    //print(employee.name, employee.id)
                }
                self.recipes = websiteDescription.hits
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }catch let jsonErr {
                print("error serializing json", jsonErr)
                
            }
        }.resume()
      }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        self.view.endEditing(true)
         
        return true
     
    }
    
    @IBAction func BuscarApi(_ sender: Any) {
        
        let buscar = BuscarTextField.text!
        let jsonUrlString = "https://api.edamam.com/search?q="+buscar+"&app_id=e533a2a7&app_key=49c51fa4ab6791c69b44ef037b33ddce"

        guard let url = URL(string: jsonUrlString) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            print("do spuff here")
            
            guard let data = data else {return}
            //let dataAsString = String(data: data,encoding: .utf8)
            //print(dataAsString)
            
            do{
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                //let recetas = try JSONDecoder().decode([Course].self, from: data)
                
                //print( websiteDescription.hits[0].recipe.count)
                //print("recipe", websiteDescription.hits[0].recipe[0])
                //print(websiteDescription.hits[0].recipe[0].ingredients[0].food.label)
                //let result = websiteDescription
                for hit in websiteDescription.hits {
                    //print(hit.recipe)
                    //print(employee.name, employee.id)
                }
                self.recipes = websiteDescription.hits
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }catch let jsonErr {
                print("error serializing json", jsonErr)
                
            }
        }.resume()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as? ActorCell else { return UITableViewCell() }

        cell.TituloReceta.text = recipes[indexPath.row].recipe.label
        //cell.IngredientesReceta = recipes[indexPath.row].recipe.calories
        cell.CaloriasReceta.text = "Calorias: " + "\(recipes[indexPath.row].recipe.calories ?? 0)"
        cell.PorcionesReceta.text = "Porciones: " + "\(recipes[indexPath.row].recipe.yield ?? 0)"
        cell.TiempoReceta.text = "Tiempo: " + "\(recipes[indexPath.row].recipe.totalTime ?? 0)"
        cell.UrlReceta.text = recipes[indexPath.row].recipe.url

        if let imageURL = URL(string: recipes[indexPath.row].recipe.image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.ImagenReceta.image = image
                    }
                }
            }
        }
        return cell
    }
}
