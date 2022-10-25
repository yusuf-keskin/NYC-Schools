//
//  SchoolListCell.swift
//  20220716-YusufKeskin-NYCSchools
//
//  Created by YUSUF KESKİN on 16.07.2022.
//

import UIKit

class SchoolListCell: UITableViewCell {
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var dbnCodeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        schoolNameLbl.text?.removeAll()
        dbnCodeLbl.text?.removeAll()
    }

    func setupCell(withSchoolAndExamData  data : School) {
        schoolNameLbl.text = data.school_name
        dbnCodeLbl.text = data.dbn
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
