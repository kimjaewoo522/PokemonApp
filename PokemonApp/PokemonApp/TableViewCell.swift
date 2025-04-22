//
//  TableViewCell.swift
//  PokemonApp
//
//  Created by 김재우 on 4/21/25.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    
    let profile = UIImageView()
    let name =  UILabel()
    let phoneNumber = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        profile.layer.cornerRadius = 25
        profile.clipsToBounds = true
        profile.contentMode = .scaleAspectFill
        profile.layer.borderColor = UIColor.gray.cgColor
        profile.layer.borderWidth = 1.0
        
        name.font = .systemFont(ofSize: 16, weight: .bold)
        
        phoneNumber.font = .systemFont(ofSize: 14)
        phoneNumber.textColor = .gray
        
        [profile, name, phoneNumber].forEach{ contentView.addSubview($0) }
        
        profile.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(profile.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        
        phoneNumber.snp.makeConstraints {
            $0.leading.equalTo(name.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func setData(image: UIImage?, names: String, phones: String) {
        name.text = names
        phoneNumber.text = phones
    }
    
}
