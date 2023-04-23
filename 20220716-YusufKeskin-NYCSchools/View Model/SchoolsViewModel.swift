//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by YUSUF KESKİN on 1.08.2022.
//

protocol SchoolViewModelInterface {
    func getExamData (completion: @escaping (_ schools : [School])-> ())
}

class SchoolViewModel: SchoolViewModelInterface {
    
    let examDataService : ExamDataServiceInterface
    
    init(examDataService : ExamDataServiceInterface) {
        self.examDataService = examDataService
    }

    func getExamData (completion: @escaping (_ schools : [School])-> ()) {
        examDataService.getSchoolList(withUrl: EXAM_URL!) { schoolList in
            completion(schoolList)
        }
    }
    
}

