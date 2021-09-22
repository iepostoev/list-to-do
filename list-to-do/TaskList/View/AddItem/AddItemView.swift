//
//  AddItemView.swift
//  list-to-do
//
//  Created by Igor Postoev on 07.09.2021.
//

class AddItemView: UIView {
	
    var delegate: AddItemViewDelegate?
    
    let contentView = UIView()
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
        contentView.backgroundColor = .magenta
        newTaskField.placeholder = TaskListConstants.newTaskPlaceholder
        setupAddTaskButton()
    }
    
    private func setupAddTaskButton() {
        let title = TaskListConstants.addTaskButtonTitle
        addTaskButton.setTitle(title, for: .normal)
        addTaskButton.backgroundColor = .brown
        addTaskButton.addTarget(self,
                                action: #selector(addTaskButtonTapped),
                                for: .touchUpInside)
    }
    
    @objc
    private func addTaskButtonTapped() {
        let taskText = newTaskField.text
        delegate?.itemAdded(text: taskText)
    }
}
