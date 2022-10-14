//
//  ViewController.swift
//  eCommerceAapp
//
//  Created by mehmet duran on 14.10.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var foods:[Food] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchdata()
    }
    
    func fetchdata() {
        
        let request = AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get)
        
        request.response { response in
            
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                print(json)
            }catch{
                print("-------" + error.localizedDescription + "-------")
            }
        }
    }
}

