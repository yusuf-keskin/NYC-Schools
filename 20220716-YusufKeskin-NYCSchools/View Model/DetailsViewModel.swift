//
//  DetailsViewModel.swift
//  NYCSchools
//
//  Created by YUSUF KESKİN on 1.08.2022.
//

protocol DetailsViewModelInterface {
    func getSchoolDetails (completion : @escaping (_ schoolDetail: SchoolDetail)-> ())
}

class DetailsViewModel : DetailsViewModelInterface {
    
    let schoolDetailService : SchoolDetailsServiceInterface
    var dbnCode : String? = nil
    
    init(schoolDetailService: SchoolDetailsServiceInterface) {
        self.schoolDetailService = schoolDetailService
    }
    
    func getSchoolDetails (completion : @escaping (_ schoolDetail: SchoolDetail)-> ()) {
        schoolDetailService.getSchoolExamScore(withUrl: DETAILS_URL!) { [weak self] detailsList in
            guard let selectedSchool = detailsList.filter({ $0.dbn == self?.dbnCode }).first else { return }
            completion(selectedSchool)
        }
    }

}
