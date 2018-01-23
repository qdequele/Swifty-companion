//
//  UserCell.swift
//  Swift-companion
//
//  Created by Quentin DEQUELEN on 1/22/18.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class UserCell: UITableViewCell {

    var userLogin: String? {
        didSet {
            userLoginLabel.text = userLogin!
            userImageView.sd_setImage(with: URL(string: "https://cdn.intra.42.fr/users/\(userLogin!).jpg"), placeholderImage: #imageLiteral(resourceName: "default_avatar") , completed: nil)
        }
    }

    var userImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "default_avatar")
        image.clipsToBounds = true
        return image
    }()

    var userLoginLabel: UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(userImageView)
        self.addSubview(userLoginLabel)

        userImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.leading.equalTo(20)
        }

        userLoginLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(userImageView)
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
            make.trailing.equalTo(40)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
