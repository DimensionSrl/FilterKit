//
//  ViewController.swift
//  FilterKit Example
//
//  Created by Matteo Gavagnin on 05/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

import UIKit
import FilterKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        filter()
    }
    
    func filter() {
        let name = "filter"
        guard let parsed = parseFixture(name) else {
            print("Not a valid fixture")
            return
        }
        do {
            let shouldPass = try Filter(properties: ["foo": "bar", "bit": "span"]).compile(parsed)
            print("Element is valid? \(shouldPass)")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func parseFixture(_ named: String) -> [Any]? {
        guard let jsonFileUrl = Bundle.main.url(forResource: named, withExtension: "json") else {
            print("Cannot open fixture file named \(named)")
            return nil
        }
        
        do {
            let jsonData = try Data.init(contentsOf: jsonFileUrl)
            let deserializedObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard let dictionary = deserializedObject as? [String: Any?] else {
                print("Cannot parse json in fixture file named \(named)")
                return nil
            }
            
            guard let filterArray = dictionary["filter"] as? [Any] else {
                print("Cannot find proper filter element in fixture file named \(named)")
                return nil
            }
            
            return filterArray
        } catch let error {
            print(error)
        }
        return nil
    }
}

