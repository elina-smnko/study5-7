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
        return NotesViewModel.shownElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.width = tableView.frame.width
        cell.element = NotesViewModel.shownElements[indexPath.row]
        return cell
    }
    
    @objc
    func submitForm() {
//        viewModel.elements.forEach({ element in
//            for b in (element.attributes?.buttons ?? [Button]()){
//                print(b.title!+" "+String(describing: b.isSelected))
//            }
//        })
        formTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


