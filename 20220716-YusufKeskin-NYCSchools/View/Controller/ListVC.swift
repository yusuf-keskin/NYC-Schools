//
//  ListVC.swift
//  20220716-YusufKeskin-NYCSchools
//
//  Created by YUSUF KESKİN on 16.07.2022.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var schoolViewModel : SchoolViewModelInterface?
    var selectedSchool : School?
    var paginatedSchoolsList = [School]()
    var allSchoolsList = [School]()
    var limit = 40
    
    init(schoolViewModel: SchoolViewModelInterface) {
        self.schoolViewModel = schoolViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView(frame: .zero)
        
        getSchoolList()
    }
    
    func getSchoolList() {
        schoolViewModel?.getExamData { [weak self] schools in
            guard !schools.isEmpty else { return }
            if schools.count >= 40 {
                self?.paginatedSchoolsList = Array(schools[0...40])
            } else {
                self?.paginatedSchoolsList = schools
            }

            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedSchoolsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "shoolScoreDetailsCell", for: indexPath) as? SchoolListCell else {return UITableViewCell()}
        let school = paginatedSchoolsList[indexPath.row]
        self.selectedSchool = school
        cell.setupCell(withSchoolAndExamData: school)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.1982406178, green: 0.2780974939, blue: 0.4466399376, alpha: 1)
        cell.selectedBackgroundView = backgroundView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as? SchoolListCell
        
        let board = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = board.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        
        let schoolDetailService = SchoolDetailsService()
        let schoolDetailsViewModel = DetailsViewModel(schoolDetailService: schoolDetailService)
        
        guard let dbn = selectedCell!.dbnCodeLbl.text else { return }
        
        schoolDetailsViewModel.dbnCode = dbn
        detailsVC.detailsModel = schoolDetailsViewModel
        
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

