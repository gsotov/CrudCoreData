//
//  EditarViewController.swift
//  CrudCoreData
//
//  Created by Tecnova on 1/9/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import UIKit
import CoreData

class EditarViewController: UIViewController {

    var personaEditar : Personas!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("nombre \(String(describing: personaEditar.nombre))")
        // Do any additional setup after loading the view.
    }
    
}
