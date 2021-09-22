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
		label.font = UIFont.systemFont(ofSize: 20)
		label.textColor = .white
		return label
	}()
	
	private let deleteButton: UIButton = {
		let button = UIButton()
        let title = TaskListConstants.deleteTaskButtonTitle
		button.backgroundColor = .blue
		button.setTitle(title, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		return button
	}()
    
	override init(frame: CGRect) {
		super.init(frame: frame)
        backgroundColor = .cyan
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
        deleteButton.addTarget(self,
                       action: #selector(deleteButtonTapped),
                       for: .touchUpInside)
    }
    
    @objc
    private func deleteButtonTapped() {
        delegate?.deleteTask(cell: self)
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
