//
//  FirstStepView.swift
//  Challonge
//
//  Created by Антон Алексеев on 22.03.2022.
//

import UIKit

protocol FirstStepViewDelegate {
    func closeButtonDidPress()
    func nextButtonDidPress()
    var navigationBarItem: UINavigationItem? { get }
}

enum FirstStepField: Int {
    case name, type, tournamentDescription, isPrivate
}

class FirstStepView: ProgrammaticView {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(ContentTableViewCell.self,
                           forCellReuseIdentifier: ContentTableViewCell.identifier)
        return tableView
    }()
    
    private var nextButton = CustomButton(withTitle: "Далее")
    
    private let fields: [FirstStepField: UIView] = [
        .name: FormFieldView(title: "Название", placeholder: "Название"),
        .type: RadioButtonSetView(title: "Тип турнира", elements: [
            RadioElementView(text: "Single elimination", value: "single elimination", isSelected: true),
            RadioElementView(text: "Double elimination", value: "double elimination"),
            RadioElementView(text: "Round robin", value: "round robin")
        ]),
        .tournamentDescription: FormFieldView(title: "Описание", placeholder: "Описание"),
        .isPrivate: RadioButtonSetView(title: "Доступ", elements: [
            RadioElementView(text: "Приватный", value: true, isSelected: true),
            RadioElementView(text: "Публичный", value: false)
        ])
    ]
    
    // MARK: - Public
    override func setup() {
        super.setup()
        tableView.dataSource = self
        addSubviews()
        addConstraints()
        
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
    }
    
    var delegate: FirstStepViewDelegate? {
        didSet {
            delegate?.navigationBarItem?.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(close))
        }
    }
    
    var tournamentName: String {
        (fields[.name] as? FormFieldView)?.text ?? ""
    }
    
    var tournamentDescription: String {
        (fields[.tournamentDescription] as? FormFieldView)?.text ?? ""
    }
    
    var tournamentType: String {
        let radioSetView = (fields[.type] as? RadioButtonSetView)
        return (radioSetView?.selectedValue as? String) ?? ""
    }
    
    var isTournamentPrivate: Bool {
        let radioSetView = (fields[.isPrivate] as? RadioButtonSetView)
        return (radioSetView?.selectedValue as? Bool) ?? false
    }
}

// MARK: - Private Methods
private extension FirstStepView {
    func addSubviews() {
        addSubview(tableView)
        addSubview(nextButton)
    }
    
    func addConstraints() {
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        nextButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            maker.width.greaterThanOrEqualTo(300)
        }
    }
    
    @objc func close() {
        delegate?.closeButtonDidPress()
    }
    
    @objc func nextStep() {
        delegate?.nextButtonDidPress()
    }
}

// MARK: - UITableViewDataSource
extension FirstStepView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fieldType = FirstStepField.init(rawValue: indexPath.row),
              let field = fields[fieldType] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as! ContentTableViewCell
        cell.setContent(field)
        cell.selectionStyle = .none
        return cell
    }
}
