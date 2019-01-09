//
//  EditarViewController.swift
//  CrudCoreData
//
//  Created by Jorge Maldonado Borbón on 20/08/17.
//  Copyright © 2017 Jorge Maldonado Borbón. All rights reserved.
//

import UIKit
import CoreData
class EditarViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var activo: UISwitch!
    var personaEditar : Personas!
    
    func conexion () -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        nombre.text = personaEditar.nombre
        edad.text = "\(personaEditar.edad)"
        
        if personaEditar.activo {
            activo.isOn = true
        }else{
            activo.isOn = false
        }
        
    }

    @IBAction func editar(_ sender: UIButton) {
        let contexto = conexion()

        let edadPersona = Int16(edad.text!)
        personaEditar.setValue(nombre.text, forKey: "nombre")
        personaEditar.setValue(edadPersona, forKey: "edad")
        personaEditar.setValue(activo.isOn, forKey: "activo")
        
        do {
            try contexto.save()
            performSegue(withIdentifier: "enviarTabla", sender: self)
        } catch let error as NSError {
            print("no guardo", error)
        }
    }
    
}
