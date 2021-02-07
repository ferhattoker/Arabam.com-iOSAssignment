//
//  Service.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 27.01.2021.
//

import Foundation



struct Service {
    
    static let shared = Service()
    
    func fetchVehicleList(filter: Filter?, sort: Sort, skip: Int, take: Int, completion: @escaping ([VehiclesList]?, Error?) -> ()) {

        var url: String = "http://sandbox.arabamd.com/api/v1/listing?sort=\(sort.kind)&sortDirection=\(sort.direction)&skip=\(skip)&take=\(take)"

        
        if let filter = filter {
            if let categoryId = filter.categoryId {
                url += "&categoryId=\(categoryId)"
            }
            
            if let minDate = filter.minDate {
                url += "&minDate=\(minDate)"
            }
            
            if let maxDate = filter.maxDate {
                url += "&maxDate=\(maxDate)"
            }
            
            if let minYear = filter.minYear {
                url += "&minYear=\(minYear)"
            }
            
            if let maxYear = filter.maxYear {
                url += "&maxYear=\(maxYear)"
            }
        }
                
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchVehicleDetail(of id: Int, completion: @escaping (VehicleDetail?, Error?) -> ()) {

        let url = "http://sandbox.arabamd.com/api/v1/detail?id=\(id)"
        
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    private func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
               
       guard let url = URL(string: urlString) else { return }
       
       URLSession.shared.dataTask(with: url) { (data, response, error) in

           if let error = error {
               completion(nil, error)
               return
           }
 
           if let data = data {
               do {
                   let objects = try JSONDecoder().decode(T.self, from: data)
                   
                   completion(objects, nil)
                   
               } catch let jsonError {
                   completion(nil, jsonError)
               }
           }
       }.resume()
   }
}

