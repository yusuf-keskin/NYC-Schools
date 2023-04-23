//
//  MainVC.swift
//  20220716-YusufKeskin-NYCSchools
//
//  Created by YUSUF KESKİN on 16.07.2022.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var splashLabel: UILabel!
    
    var schoolList =  [School]()
    var schoolDetailsList = [SchoolDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fadeViewInThenOut(view: splashLabel, delay: 0)
    }
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 2.80
        UIView.animate(withDuration: animationDuration, delay: delay, options: []) {
            view.alpha = 1
        } completion: { success in
            let board = UIStoryboard(name: "Main", bundle: nil)
            let listVC = board.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            
            let examDataService = ExamDataService()
            let schoolViewModel = SchoolViewModel(examDataService: examDataService)
            listVC.schoolViewModel = schoolViewModel
            
            listVC.modalPresentationStyle = .fullScreen
            self.present(listVC, animated: true)
        }
    }

}
