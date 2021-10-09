//
//  AddItemView.swift
//  list-to-do
//
//  Created by Igor Postoev on 07.09.2021.
//

import MaterialComponents

class AddTaskView: UIView {
	
    var delegate: AddTaskViewDelegate?
    
    let contentView = MDCShapedView(frame: .zero)
	let newTaskField = UITextField()
    let addTaskButton = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect())
        addSubview(contentView)
        contentView.addSubview(newTaskField)
        contentView.addSubview(addTaskButton)
        contentView.backgroundColor = AppScheme.shared.colorScheme.secondaryColor
        let shapeGenerator = MDCRectangleShapeGenerator()
        shapeGenerator.topLeftCorner = AppScheme.shared.shapeScheme.largeComponentShape.topLeftCorner
        contentView.shapeGenerator = shapeGenerator
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
    }
    
    override func layoutSubviews() {
        configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignItems = .center
            layout.justifyContent = .center
        }
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = YGValue(self.bounds.width - 100)
            layout.height = 150
            layout.justifyContent = .center
        }
        addTaskButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginLeft = 20
            layout.marginRight = 20
        }
        newTaskField.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 50
            layout.marginLeft = 20
            layout.marginRight = 20
        }
        yoga.applyLayout(preservingOrigin: true)
    }
    
    func reset() {
        newTaskField.text = ""
    }
    
    private func setupSubviews() {
        newTaskField.placeholder = TaskListConstants.newTaskPlaceholder
        newTaskField.font = AppScheme.shared.typographyScheme.subtitle1
        setupAddTaskButton()
    }
    
    private func setupAddTaskButton() {
        let title = TaskListConstants.addTaskButtonTitle
        addTaskButton.setTitle(title, for: .normal)
        addTaskButton.titleLabel?.font = AppScheme.shared.typographyScheme.button
        addTaskButton.backgroundColor = AppScheme.shared.colorScheme.primaryColor
        addTaskButton.addTarget(self,
                                action: #selector(addTaskButtonTapped),
                                for: .touchUpInside)
    }
    
    @objc
    private func addTaskButtonTapped() {
        let taskText = newTaskField.text
        delegate?.taskAdded(text: taskText)
    }
}
