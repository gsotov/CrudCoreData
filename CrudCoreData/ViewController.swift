//
//  ViewController.swift
//  CrudCoreData
//
//  Created by Gabriel Soto valenzuela on 1/8/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var activo: UISwitch!
    
    func conexion() -> NSManagedObjectContext
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func guardar(_ sender: UIButton)
    {
        
    }
    

}

