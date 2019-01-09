//
//  TablaViewController.swift
//  CrudCoreData
//
//  Created by Tecnova on 1/9/19.
//  Copyright © 2019 Gabriel Soto valenzuela. All rights reserved.
//

import UIKit
import CoreData

class TablaViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    var personas : [Personas] = []
    @IBOutlet weak var tabla: UITableView!
    
    func conexion() -> NSManagedObjectContext
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        
        mostrarDatos()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    //es la cantidad de filas de la cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return personas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let persona = personas[indexPath.row]
        
        
        
        if persona.activo
        {
            //Se comienza a enlazar la data
            cell.textLabel?.text = "😎 \(persona.nombre!)"
            cell.detailTextLabel?.text = "\(persona.edad)"
        }
        else
        {
            //Se comienza a enlazar la data
            cell.textLabel?.text = "😢 \(persona.nombre!)"
            cell.detailTextLabel?.text = "\(persona.edad)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "enviarEditar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviarEditar"
        {
            if let id = tabla.indexPathForSelectedRow
            {
                let fila = personas[id.row]
                let destino = segue.destination as! EditarViewController
                destino.personaEditar = fila
            }
        }
    }
    
    
    //Funciones
    func mostrarDatos()
    {
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Personas> = Personas.fetchRequest()
        
        do {
            personas = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("no mostro nada \(error)")
        }
    }

}
