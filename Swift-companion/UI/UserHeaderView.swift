//
//  UserHeaderView.swift
//  Swift-companion
//
//  Created by Quentin de Quelen on 23/01/2018.
//  Copyright © 2018 Quentin de Quelen. All rights reserved.
//

import UIKit

class UserHeaderView: UIView {

    var user: UserModel? {
        didSet {
            userImageView.sd_setImage(with: URL(string: user!.imageUrl!), placeholderImage: #imageLiteral(resourceName: "default_avatar") , completed: nil)
            userNameLabel.attributedText = NSMutableAttributedString(string: user!.displayName!, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
            userEmailLabel.text = user!.email
            userPhoneLabel.text = user!.phone
            walletLabel.text = "Wallet: " + String(user!.wallet)
            correctionLabel.text = "Corrections: " + String(user!.correctionPoint)

            if let level = user?.cursusUsers?[0].level {
                let percent = (level - Float(Int(level))) * 100
                userLevelLabel.text = "Level: " + String(Int(level)) + " - " + String(percent) + "%"
                userProgress.progress = level - Float(Int(level))
            }
        }
    }

    var userImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.layer.cornerRadius = image.frame.width / 2
        image.contentMode = .scaleAspectFill
        image.image = #imageLiteral(resourceName: "default_avatar")
        image.clipsToBounds = true
        return image
    }()

    var userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var userEmailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    var userLevelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var walletLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var correctionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    var userProgress: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(hex: "#1991EB")
        progressView.backgroundColor = .white
        progressView.progress = 0.54
        return progressView
    }()

    var informationView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "default_background"))

        self.addSubview(userImageView)
        self.addSubview(informationView)
        informationView.addSubview(userNameLabel)
        informationView.addSubview(userEmailLabel)
        informationView.addSubview(userPhoneLabel)
        informationView.addSubview(walletLabel)
        informationView.addSubview(correctionLabel)
        self.addSubview(userLevelLabel)
        self.addSubview(userProgress)

        informationView.backgroundColor = .black

        userImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }

        informationView.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }

        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        userEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        userPhoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userEmailLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }

        walletLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userPhoneLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }

        correctionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(walletLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }

        userLevelLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(informationView.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        userProgress.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(userLevelLabel.snp.bottom)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(-40)
        }
//        self.updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
