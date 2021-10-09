//
//  TaskListViewController.swift
//  list-to-do
//
//  Created by Igor Postoev on 06.09.2021.
//

class TaskListViewController: UIViewController,
                              ListAdapterDataSource,
                              AddTaskViewDelegate,
                              TaskCellDelegate,
                              TaskListViewProtocol{
    
    var presenter: TaskListPresenterProtocol!
    
    private let addTaskView = AddTaskView()

	private var taskListView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppScheme.shared.colorScheme.surfaceColor
		return collectionView
	}()
	
	private lazy var adapter: ListAdapter = {
		return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
	}()
	
	override func viewDidLoad() {
		setupNavigation()
		view.addSubview(taskListView)
        addTaskView.delegate = self
		adapter.collectionView = taskListView
		adapter.dataSource = self
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
        taskListView.frame = view.safeAreaLayoutGuide.layoutFrame
        addTaskView.frame = view.safeAreaLayoutGuide.layoutFrame
	}
	
	private func setupNavigation() {
        title = "Tasks"
        let barButton = UIBarButtonItem(title: "ADD",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addTask))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: AppScheme.shared.typographyScheme.button,
            .foregroundColor: AppScheme.shared.colorScheme.primaryColor
        ]
        barButton.setTitleTextAttributes(attributes, for: .normal)
		navigationItem.rightBarButtonItem = barButton
	}
	
	@objc
	private func addTask(sender: UIBarButtonItem) {
        view.addSubview(addTaskView)
	}
	
	//MARK: -ListAdapterDataSource
	
	func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return presenter.getTasks() as [ListDiffable]
	}
	
	func listAdapter(_ listAdapter: ListAdapter,
					 sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = TaskListSectionController()
        sectionController.cellDelegate = self
		return sectionController
	}
	
	func emptyView(for listAdapter: ListAdapter) -> UIView? {
		nil
	}
	
    //MARK: -AddTaskViewDelegate
	func taskAdded(text: String?) {
        presenter.addTask(text)
	}
    
    //MARK: -TaskCellDelegate
    func deleteTaskButtonTapped(cell: UICollectionViewCell) {
        guard let indexPath = taskListView.indexPath(for: cell) else {
            return
        }
        presenter.removeTask(indexPath)
    }
    
    // MARK: -TaskListViewProtocol
    func reload() {
        adapter.reloadData(completion: nil)
    }
    
    func removeAddItemView() {
        addTaskView.reset()
        addTaskView.removeFromSuperview()
    }
}
