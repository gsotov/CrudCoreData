//
//  ViewController.swift
//  CrudCoreData
//
//  Created by Jorge Maldonado Borbón on 19/08/17.
//  Copyright © 2017 Jorge Maldonado Borbón. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var edad: UITextField!
    
    @IBOutlet weak var activo: UISwitch!
    
    
    func conexion () -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
    @IBAction func guardar(_ sender: UIButton) {
        
       let contexto = conexion()
        let entidadPersonas = NSEntityDescription.entity(forEntityName: "Personas", in: contexto)
        let newPersona = NSManagedObject(entity: entidadPersonas!, insertInto: contexto)
        let edadPersona = Int16(edad.text!)
        newPersona.setValue(nombre.text, forKey: "nombre")
        newPersona.setValue(edadPersona, forKey: "edad")
        newPersona.setValue(activo.isOn, forKey: "activo")
        
        do {
            try contexto.save()
            print("guardo")
            nombre.text = ""
            edad.text = ""
            activo.isOn = false
        } catch let error as NSError {
            print("no guardo", error)
        }
        
    }
    
    @IBAction func mostrar(_ sender: UIButton) {
        
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Personas> = Personas.fetchRequest()
        
        do {
           
           let resultados = try contexto.fetch(fetchRequest)
            
            print("numero de registros= \(resultados.count)")
            
            for res in resultados as [NSManagedObject] {
                let nombrePersona = res.value(forKey: "nombre")
                let edadPersona = res.value(forKey: "edad")
                let activoPersona = res.value(forKey: "activo")
                print("nombre: \(nombrePersona!) - edad: \(edadPersona!) - activo: \(activoPersona!)")
            }
            
        } catch let error as NSError  {
            print("no mostro nada", error)
        }
        
    }
    
    
    
    @IBAction func borrar(_ sender: UIButton) {
        
        let contexto = conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Personas")
        let borrar = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try contexto.execute(borrar)
            print("borro los datos")
            
        } catch let error as NSError  {
            print(" no mostro nada", error)
        }
        
    }
    
    
    
}














