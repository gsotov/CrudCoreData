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

    }
    
    @IBAction func guardar(_ sender: UIButton)
    {
        let contexto = conexion()
        let entidadPersonas = NSEntityDescription.entity(forEntityName: "Personas", in: contexto)
        let newPersona = NSManagedObject(entity: entidadPersonas!, insertInto: contexto)
        let edadPersona = Int16(edad.text!)
        //set key to value
        newPersona.setValue(nombre.text, forKey:"nombre")
        newPersona.setValue(edadPersona, forKey: "edad")
        newPersona.setValue(activo.isOn, forKey: "activo")
        
        do{
            
            try contexto.save()
            nombre.text = ""
            edad.text = ""
            activo.isOn = false
            print("guardado")
        }
        catch let error as NSError
        {
            print("no guardo", error)
            
        }
        
    }
    

}

