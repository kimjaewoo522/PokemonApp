//
//  PhoneBookViewController.swift
//  PokemonApp
//
//  Created by 김재우 on 4/22/25.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
        
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.layer.cornerRadius = 75
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderColor = UIColor.gray.cgColor
        profileImage.layer.borderWidth = 1.0
        
        return profileImage
    }()
    
    let randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.setTitle("랜덤 이미지 생성", for: .normal)
        randomButton.setTitleColor(.gray, for: .normal)
        randomButton.titleLabel?.font = .systemFont(ofSize: 15)
        randomButton.sizeToFit()
        
        return randomButton
    }()
    
    let detailName: UITextField = {
        let detailName = UITextField()
        detailName.layer.borderColor = UIColor.gray.cgColor
        detailName.layer.borderWidth = 1.0
        detailName.layer.cornerRadius = 10
        
        return detailName
    }()
    
    let detailNum: UITextField = {
        let detailNum = UITextField()
        detailNum.layer.borderColor = UIColor.gray.cgColor
        detailNum.layer.borderWidth = 1.0
        detailNum.layer.cornerRadius = 10
        
        return detailNum
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)

        [profileImage, randomButton, detailName, detailNum].forEach{
            view.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(150)
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.centerX.equalTo(profileImage)
        }
        
        detailName.snp.makeConstraints {
            $0.top.equalTo(randomButton.snp.bottom).offset(20)
            $0.centerX.equalTo(randomButton)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        detailNum.snp.makeConstraints {
            $0.top.equalTo(detailName.snp.bottom).offset(10)
            $0.centerX.equalTo(detailNum)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
    }
    
    @objc func applyButtonTapped(_ sender: UIBarButtonItem) {
        print("버튼이 눌림")
    }
    
    @objc func randomButtonTapped(_ sender: UIButton) {
        print("버튼이 눌렸음")
        
    }

}
