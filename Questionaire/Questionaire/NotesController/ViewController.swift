//
//  ViewController.swift
//  Questionaire
//
//  Created by Elina Semenko on 01.02.2022.
//

import UIKit

class ViewController: UIViewController {
    let viewModel: NotesViewModel
    private let formTableView = UITableView()
    private let submitButton = UIButton()
    private let stopLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
    private var disabled: Bool = false
    
    init(viewModel: NotesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        DispatchQueue.main.async { [weak self] in
            self?.showAlert()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Hello!", message: "Enter your age", preferredStyle: .alert)
        alert.addTextField()

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
            let textField = alert.textFields?[0]
            if let age = Int(textField?.text ?? ""), age < 18 {
                self?.disabled = true
                self?.disableForm()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func disableForm() {
        formTableView.isHidden = true
        stopLabel.text = "You should be 18 to enter"
        view.addSubview(stopLabel)
        stopLabel.font = .systemFont(ofSize: 20)
        stopLabel.textColor = .black
        stopLabel.numberOfLines = 0
        stopLabel.center = view.center
        stopLabel.textAlignment = .center
    }
    
    private func enableForm() {
        formTableView.isHidden = false
        stopLabel.removeFromSuperview()
    }
    
    
    private func setupTableView() {
        view.addSubview(formTableView)
        formTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            formTableView.topAnchor.constraint(equalTo: view.topAnchor),
            formTableView.bottomAnchor.constraint(equalTo: submitButton.topAnchor)
        ])
        formTableView.register(ElementTableViewCell.self, forCellReuseIdentifier: "ElementCell")
        formTableView.dataSource = self
        formTableView.delegate = self
    }
    
    private func setupUI() {
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .red.withAlphaComponent(0.5)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        view.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.width = tableView.frame.width
        cell.element = viewModel.elements[indexPath.row]
        return cell
    }
    
    @objc
    func submitForm() {
        if disabled {
            disabled.toggle()
            enableForm()
        }
        viewModel.elements.forEach({ element in
            for b in (element.attributes?.buttons ?? [Button]()){
                print(b.title!+" "+String(describing: b.isSelected))
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


