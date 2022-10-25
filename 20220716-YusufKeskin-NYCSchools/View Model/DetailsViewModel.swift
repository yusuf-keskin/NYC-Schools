//
//  DetailsViewModel.swift
//  NYCSchools
//
//  Created by YUSUF KESKİN on 1.08.2022.
//

class DetailsViewModel {
    var dbn : Observable<String> = Observable("")
        
    func getSchoolDetails (completion : @escaping (_ schoolDetail: SchoolDetail)-> ()) {

        SchoolDetailsService.instance.getSchoolExamScore(withUrl: DETAILS_URL!) { detailsList in
            for schoolDetail in detailsList {
                if schoolDetail.dbn == self.dbn.value {
                    completion(schoolDetail)
                }
            }
        }
        
    }
}
