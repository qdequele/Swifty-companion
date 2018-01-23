//
//  ProjectCell.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit
import SnapKit

class ProjectCell: UITableViewCell {

    var project: ProjectModel? {
        didSet {
            nameLabel.text = project!.projectSlug
            if project!.validated == true {
                gradeLabel.attributedText = NSAttributedString(string: String(project!.finalMark),
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor(hex: "#0BC639")])
            } else {
                gradeLabel.attributedText = NSAttributedString(string: String(project!.finalMark),
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor(hex: "#DD3C1F")])
            }
        }
    }

    var nameLabel: UILabel = UILabel()
    var gradeLabel: UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(nameLabel)
        self.addSubview(gradeLabel)

        nameLabel.textAlignment = .left
        gradeLabel.textAlignment = .right
        nameLabel.lineBreakMode = .byTruncatingTail

        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-80)
            make.leading.equalToSuperview().offset(30)
        }
        gradeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

