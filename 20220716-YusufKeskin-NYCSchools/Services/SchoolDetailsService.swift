//
//  SchoolDetailsService.swift
//  20220716-YusufKeskin-NYCSchools
//
//  Created by YUSUF KESKİN on 16.07.2022.
//

import Foundation

protocol SchoolDetailsServiceInterface {
    func getSchoolExamScore(withUrl url : URL, completion :@escaping(_ detailsList : [SchoolDetail])->())
}

class SchoolDetailsService : SchoolDetailsServiceInterface {
    
    var session : SessionProtocol = URLSession.shared
    
    func getSchoolExamScore(withUrl url : URL, completion :@escaping(_ detailsList : [SchoolDetail])->()) {
        
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!, "Data couldn't be fetched")
            } else {
                guard let data = data else { print("no data") ; return }
                
                let decoder = JSONDecoder()
                do {
                   let schoolDetails =  try decoder.decode([SchoolDetail].self, from: data)
                    completion(schoolDetails)
                } catch  {
                    print(error, "Couldn't be parsed correctly")
                }
            }
        }.resume()
    }
}
