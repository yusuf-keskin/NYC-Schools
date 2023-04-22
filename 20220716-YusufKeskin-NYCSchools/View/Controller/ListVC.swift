//
//  ListVC.swift
//  20220716-YusufKeskin-NYCSchools
//
//  Created by YUSUF KESKİN on 16.07.2022.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var schoolViewModel =  SchoolViewModel()
    var selectedSchool : School?
    var paginatedSchoolsList = [School]()
    var allSchoolsList = [School]()
    var limit = 40

    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        schoolViewModel.getExamData { [self] schools in
//            self.schoolsList = schools ?? [School]()
            self.allSchoolsList = schools ?? [School]()
            
            var index = 0
            while index < limit {
                paginatedSchoolsList.append((schools?[index])!)
                index = index + 1            }
            
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
        }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView(frame: .zero) //------------------
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedSchoolsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "shoolScoreDetailsCell", for: indexPath) as? SchoolListCell else {return UITableViewCell()}
        let school = paginatedSchoolsList[indexPath.row]
        self.selectedSchool = school
        cell.setupCell(withSchoolAndExamData: school)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as? SchoolListCell
        
        let board = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = board.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        detailsVC.dbn =  selectedCell?.dbnCodeLbl.text

        DispatchQueue.main.async {
            detailsVC.mathScoreLbl.text = self.selectedSchool?.sat_math_avg_score ?? ""
            detailsVC.readingScoreLbl.text = self.selectedSchool?.sat_critical_reading_avg_score ?? ""
            detailsVC.writingScoreLbl.text = self.selectedSchool?.sat_writing_avg_score ?? ""
            detailsVC.examTakersNumLbl.text = self.selectedSchool?.num_of_sat_test_takers ?? ""
        }
        
        detailsVC.modalPresentationStyle = .fullScreen
        present(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == paginatedSchoolsList.count - 1 {
            if paginatedSchoolsList.count < allSchoolsList.count {
                
                var index = paginatedSchoolsList.count
                
                limit = index + 20
                
                while index < limit {
                    paginatedSchoolsList.append((allSchoolsList[index]))
                    index = index + 1
                    
                    self.perform(#selector(reloadTable), with: nil, afterDelay: 1.0)
                }
                
            }
            
        }
    }

    @objc func reloadTable() {
        tableview.reloadData()
    }
    
}

