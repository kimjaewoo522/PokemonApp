import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    // MARK: - UI 요소 정의
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    private let detailName: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.placeholder = "이름 입력"
        textField.textAlignment = .center
        return textField
    }()
    
    private let detailNum: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.placeholder = "전화번호 입력"
        textField.textAlignment = .center
        return textField
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
    }
    
    
    // MARK: - UI 구성
    
    private func configureUI() {
        view.backgroundColor = .white
        
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        
        [profileImage, randomButton, detailName, detailNum].forEach {
            view.addSubview($0)
        }
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(150)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        detailName.snp.makeConstraints {
            $0.top.equalTo(randomButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        detailNum.snp.makeConstraints {
            $0.top.equalTo(detailName.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(detailName)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - Navigation Bar
    
    private func setupNavigationBar() {
        self.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
    }
    
    // MARK: - 버튼 액션
    
    @objc private func applyButtonTapped(_ sender: UIBarButtonItem) {
        print("적용 버튼이 눌렸습니다")
    }
    
    @objc private func randomButtonTapped(_ sender: UIButton) {
        fetchData()
    }
    
    // MARK: - 네트워크 요청
    
    // 받아오는 역할
    private func fetchData() {
        let randomID = Int.random(in: 1...1000)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        
        guard let url = URL(string: urlString) else {
            print("URL 생성 실패")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard
                let self = self,
                let data = data,
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode)
            else {
                print("데이터 요청 실패")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(PokemonImageURL.self, from: data)
                let imageURL = decoded.sprites.frontDefault
                
                self.loadImage(from: imageURL)
            } catch {
                print("디코딩 실패: \(error)")
            }
        }.resume()
    }
    // 받아온 이미지를 넣어주는 역할(책임분리)
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("이미지 로드 실패")
                return
            }
            DispatchQueue.main.async {
                self?.profileImage.image = UIImage(data: data)
            }
        }.resume()
    }
}
