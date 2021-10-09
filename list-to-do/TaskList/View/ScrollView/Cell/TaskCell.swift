//
//  TaskCell.swift
//  list-to-do
//
//  Created by Igor Postoev on 06.09.2021.
//

class TaskCell: UICollectionViewCell {
    
    var delegate: TaskCellDelegate?
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
        label.font = AppScheme.shared.typographyScheme.subtitle1
        label.textColor = AppScheme.shared.colorScheme.primaryColorVariant
		return label
	}()
	
	private let deleteButton: UIButton = {
		let button = UIButton()
        let title = TaskListConstants.deleteTaskButtonTitle
        button.backgroundColor = AppScheme.shared.colorScheme.primaryColor
		button.setTitle(title, for: .normal)
		button.titleLabel?.font = AppScheme.shared.typographyScheme.button
		return button
	}()
    
	override init(frame: CGRect) {
		super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        configureSubviews()
	}
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupLayout()
	}
    
    func update(text: String?) {
        nameLabel.text = text
    }
    
    private func addSubviews() {
        contentView.addSubview(deleteButton)
        contentView.addSubview(nameLabel)
    }
    
    private func configureSubviews() {
        //self is not accessible when setting default values during initialization
        deleteButton.addTarget(self,
                       action: #selector(deleteButtonTapped),
                       for: .touchUpInside)
    }
    
    @objc
    private func deleteButtonTapped() {
        delegate?.deleteTaskButtonTapped(cell: self)
    }
	
	private func setupLayout() {
		contentView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .rowReverse
			layout.padding = 10
		}
		
		deleteButton.configureLayout { (layout) in
			layout.isEnabled = true
			layout.width = 30%
		}
		
		nameLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginLeft = 5%
			layout.marginRight = 5%
			layout.width = 60%
		}
		
		contentView.yoga.applyLayout(preservingOrigin: true)
	}
}
