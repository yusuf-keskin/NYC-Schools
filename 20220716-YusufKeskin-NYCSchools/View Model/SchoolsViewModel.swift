//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by YUSUF KESKİN on 1.08.2022.
//

class SchoolViewModel {

    var schoolModel = [School]()
    
    func getExamData (completion: @escaping (_ success : Bool)-> ()) {
        ExamDataService.instance.getSchoolExamScore(withUrl: EXAM_URL!) { schoolList in
            self.schoolModel = schoolList
            completion(true)
        }
    }
    
}