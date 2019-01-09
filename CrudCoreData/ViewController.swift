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
    

    @IBAction func mostrar(_ sender: UIButton)
    {
        let contexto = conexion()
        let fetRequest : NSFetchRequest<Personas> = Personas.fetchRequest()
        
        do {
            
            let resultado = try contexto.fetch(fetRequest)
            print("numero de registros \(resultado.count)" )
            
            for res in resultado as [NSManagedObject]
            {
                let nombrePersona = res.value(forKey: "nombre")
                let edadPersona = res.value(forKey: "edad")
                let activoPersona = res.value(forKey: "activo")
                
                print("nombre: \(nombrePersona!) - edad: \(String(describing: edadPersona)) - activo: \(activoPersona!)" )
            }
            
        }
        catch let error as NSError
        {
             print("no mostro", error)
        }
    }
    
    @IBAction func borrar(_ sender: UIButton)
    {
        let contexto = conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Personas")
        let borrar = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        
        do {
            try contexto.execute(borrar)
            print("borro los datos")
        } catch let error as NSError {
            print("no borro", error)
        }
    }
    
    
    
}

