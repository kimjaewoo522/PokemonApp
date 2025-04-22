//
//  ViewController.swift
//  PokemonApp
//
//  Created by 김재우 on 4/21/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let contacts: [(name: String, phone: String)] = [
        ("김재우", "010-1234-5678"),
        ("김재우", "010-1234-5678"),
        ("김재우", "010-1234-5678"),
        ("김재우", "010-1234-5678"),
        ("김재우", "010-1234-5678"),
        ("김재우", "010-1234-5678")
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tableView
    }()
    
    // MARK: - 생명 주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
    }
    
    // MARK: - 네비게이션 바 설정
    
    private func setupNavigationBar() {
        self.title = "친구 목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    // MARK: - UI 설정
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - 버튼 동작
    
    @objc func addButtonTapped(_ sender: UIBarButtonItem) {
        let phoneBookVC = PhoneBookViewController()
        self.navigationController?.pushViewController(phoneBookVC, animated: true)
    }
}

// MARK: - 테이블 뷰 데이터 소스

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let contact = contacts[indexPath.row]
        cell.setData(image: nil, names: contact.name, phones: contact.phone)
        return cell
    }
}
