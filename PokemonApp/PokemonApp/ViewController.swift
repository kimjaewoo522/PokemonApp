//
//  ViewController.swift
//  PokemonApp
//
//  Created by 김재우 on 4/21/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //var phoneBook: [PhoneBook] = []
    
    let contacts: [(name: String, phone: String)] = [
            ("김재우", "010-1234-5678"),
            ("김재우", "010-1234-5678"),
            ("김재우", "010-1234-5678"),
            ("김재우", "010-1234-5678"),
            ("김재우", "010-1234-5678"),
            ("김재우", "010-1234-5678")
        ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.sizeToFit()
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        //tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [titleLabel, addButton, tableView].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        print("버튼이 눌림")
    }
}
    
    extension ViewController: UITableViewDataSource {
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else { return UITableViewCell() }
            let contact = contacts[indexPath.row]
            cell.setData(image: nil, names: contact.name, phones: contact.phone)
            return cell
        }
        
    }

    


