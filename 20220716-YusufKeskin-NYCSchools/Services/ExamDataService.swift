//
//  ExamDataService.swift
//  20220716-YusufKeskin-NYCSchools
//
//  Created by YUSUF KESKİN on 16.07.2022.
//

import Foundation
protocol SessionProtocol {
    func dataTask(with url : URL, completionHandler : @escaping (Data?, URLResponse?, Error?)->()) -> URLSessionDataTask
}

class ExamDataService {
    static let instance = ExamDataService()
    
    var session : SessionProtocol = URLSession.shared as SessionProtocol 
    
    func getSchoolExamScore(withUrl url : URL, completion :@escaping(_ schoolList : [School])->()) {
        
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!, "Data couldn't be fetched")
            } else {
                guard let data = data else { print("no data") ; return }
                
                let decoder = JSONDecoder()
                do {
                   let SchoolExamList =  try decoder.decode([School].self, from: data)
                    completion(SchoolExamList)
                    
                } catch  {
                    print(error, "Couldn't be parsed correctly")
                }
            }
        }.resume()
    }
}
    
extension URLSession : SessionProtocol {}



