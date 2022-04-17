//
//  ThirdStepView.swift
//  Challonge
//
//  Created by Антон Алексеев on 08.04.2022.
//

import UIKit

protocol SecondStepViewDelegate {
    func closeButtonDidPress()
    func createButtonDidPress()
    var navigationBarItem: UINavigationItem? { get }
}

enum SecondStepField: Int {
    case startDate, holdThirdPlaceMatch, notifyUsersWhenMatchesOpens, notifyUsersWhenMatchesEnds
}

class SecondStepView: ProgrammaticView {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(ContentTableViewCell.self,
                           forCellReuseIdentifier: ContentTableViewCell.identifier)
        return tableView
    }()
    
    private var createButton = CustomButton(withTitle: "Создать")
    
    private var fields: [SecondStepField: UIView] = [
        .startDate: DateFormFieldView(title: "Дата проведения", initialDate: Date()),
        .holdThirdPlaceMatch: RadioButtonSetView(title: "Устраивать турнир за 3 место?", elements: [
            RadioElementView(text: "Нет", value: false, isSelected: true),
            RadioElementView(text: "Да", value: true, isSelected: false)
        ]),
        .notifyUsersWhenMatchesOpens: RadioButtonSetView(title: "Напоминать о старте турнира", elements: [
            RadioElementView(text: "Нет", value: false, isSelected: true),
            RadioElementView(text: "Да", value: true, isSelected: false)
        ]),
        .notifyUsersWhenMatchesEnds: RadioButtonSetView(title: "Напоминать об окончании турнира", elements: [
            RadioElementView(text: "Нет", value: false, isSelected: true),
            RadioElementView(text: "Да", value: true, isSelected: false)
        ])
    ]
    
    // MARK: - Public
    override func setup() {
        super.setup()
        tableView.dataSource = self
        
        addSubviews()
        addConstraints()
        
        createButton.addTarget(self, action: #selector(create), for: .touchUpInside)
    }
    
    var delegate: SecondStepViewDelegate? {
        didSet {
            delegate?.navigationBarItem?.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(close))
        }
    }
    
    var isCreateButtonActive = true {
        willSet {
            createButton.isUserInteractionEnabled = newValue
        }
    }
    
    var startDateString: String {
        (fields[.startDate] as? FormFieldView)?.text ?? ""
    }
    
    var holdThirdPlaceMatch: Bool {
        let radioSetView = (fields[.holdThirdPlaceMatch] as? RadioButtonSetView)
        return (radioSetView?.selectedValue as? Bool) ?? false
    }
    
    var notifyUsersWhenMatchesOpens: Bool {
        let radioSetView = (fields[.notifyUsersWhenMatchesOpens] as? RadioButtonSetView)
        return (radioSetView?.selectedValue as? Bool) ?? false
    }
    
    var notifyUsersWhenMatchesEnds: Bool {
        let radioSetView = (fields[.notifyUsersWhenMatchesEnds] as? RadioButtonSetView)
        return (radioSetView?.selectedValue as? Bool) ?? false
    }
}

// MARK: - Setup
private extension SecondStepView {
    func addSubviews() {
        addSubview(tableView)
        addSubview(createButton)
    }
    
    func addConstraints() {
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        createButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            maker.width.greaterThanOrEqualTo(300)
        }
    }
    
    @objc func close() {
        delegate?.closeButtonDidPress()
    }
    
    @objc func create() {
        delegate?.createButtonDidPress()
    }
}

// MARK: - UITableViewDataSource
extension SecondStepView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fieldType = SecondStepField.init(rawValue: indexPath.row),
              let field = fields[fieldType] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as! ContentTableViewCell
        cell.setContent(field)
        cell.selectionStyle = .none
        return cell
    }
}
