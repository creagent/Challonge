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

class FormFieldView: UIView {
    private let titleStackView = CustomStackView(vertical: true)
    private let titleLabel = UILabel()
    
    private(set) var textfield = CustomTextField(placeholder: "")
    
    convenience init(title: String? = nil, placeholder: String) {
        self.init(frame: .zero)
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.isHidden = title == nil
        textfield = CustomTextField(placeholder: placeholder)
        setup()
    }
    
    var text: String {
        textfield.text ?? ""
    }
    
    private func setup() {
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(16)
            maker.width.equalTo(300)
        }
        
        addSubview(textfield)
        textfield.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleStackView.snp.bottom).offset(16)
            maker.bottom.equalToSuperview().inset(16)
            maker.width.equalTo(300)
        }
    }
}



class ContentTableViewCell: UITableViewCell {
    static var identifier = "ContentTableViewCell"
    
    func setContent(_ view: UIView) {
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        content = view
        setup()
    }
    
    private var content: UIView?
    
    private func setup() {
        guard let content = content else { return }
        contentView.addSubview(content)
        content.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

class RadioButton: UIButton {
    convenience init(isSelected: Bool = false) {
        self.init()
        self.isSelected = isSelected
        setup()
    }
    
    override var isSelected: Bool {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        let image: UIImage = isSelected ? UIImage(named: "radioSelected")! : UIImage(named: "radioUnselected")!
        setImage(image, for: .normal)
    }
}

class RadioElementView: UIView {
    convenience init(text: String, value: Any? = nil, isSelected: Bool = false) {
        self.init(frame: .zero)
        elementTextLabel.text = text
        self.value = value
        radioButton.isSelected = isSelected
        setup()
    }
    
    private let container = UIView()
    
    private let elementTextLabel = UILabel()
    
    let radioButton = RadioButton()
    
    private(set) var value: Any?
    
    var text: String {
        elementTextLabel.text ?? ""
    }
    
    @objc private func tap() {
        radioButton.sendActions(for: .touchUpInside)
    }
}

private extension RadioElementView {
    func setup() {
        setupContainer()
        setupRadioButton()
        setupElementTextLabel()
    }
    
    func setupContainer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        container.addGestureRecognizer(tap)
        addSubview(container)
        container.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
        }
    }
    
    func setupRadioButton() {
        container.addSubview(radioButton)
        radioButton.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
            maker.width.height.equalTo(22.0)
        }
    }
    
    func setupElementTextLabel() {
        elementTextLabel.sizeToFit()
        container.addSubview(elementTextLabel)
        elementTextLabel.snp.makeConstraints { maker in
            maker.centerY.trailing.equalToSuperview()
            maker.leading.equalTo(radioButton.snp.trailing).offset(12)
            maker.trailing.equalToSuperview()
        }
    }
}

private extension RadioButtonSetView {
    struct Appearance {
        static let spacing: CGFloat = 16.0
        
        static let topOffset: CGFloat = 12.0
        
        static let errorContainerTopOffset: CGFloat = 8.0
        static let errorContainerHeight: CGFloat = 18.0
    }
}

class RadioButtonSetView: UIView {
    // MARK: - Views
    private let titleLabel = UILabel()
    
    private let stackView = CustomStackView(vertical: true, withSpacing: Appearance.spacing)
        
    // MARK: - Public
    convenience init(title: String, elements: [RadioElementView]) {
        self.init(frame: .zero)
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        self.elements = elements
        for i in 0..<elements.count {
            let button = elements[i].radioButton
            button.addTarget(self, action: #selector(setSelected(sender:)), for: .touchUpInside)
            if button.isSelected {
                selectedIndex = i
            }
        }
        addSubviews()
        layoutConstraints()
    }
    
    private(set) var selectedIndex: Int?
    
    var selectedValue: Any? {
        elements[selectedIndex ?? 0].value
    }
    
    // MARK: - Private
    private var elements: [RadioElementView] = []
}

// MARK: - Setup
private extension RadioButtonSetView {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(stackView)
        elements.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func layoutConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Appearance.topOffset)
            maker.width.equalTo(300)
            maker.centerX.equalToSuperview()
        }
        stackView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(300)
            maker.bottom.equalToSuperview().inset(Appearance.topOffset)
            maker.top.equalTo(titleLabel.snp.bottom).offset(Appearance.topOffset)
        }
    }
    
    // MARK: - Actions
    @objc func setSelected(sender: RadioButton) {
        sender.isSelected = true
        for i in 0..<elements.count {
            let button = elements[i].radioButton
            if button != sender {
                button.isSelected = false
            } else {
                selectedIndex = i
            }
        }
    }
}

class CustomStackView: UIStackView {
    // MARK: Init
    convenience init(vertical: Bool,
                     withSpacing spacing: CGFloat = 0.0,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill) {
        self.init()
        axis =  vertical ? .vertical : .horizontal
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
