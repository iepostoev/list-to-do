//
//  TaskListViewController.swift
//  list-to-do
//
//  Created by Igor Postoev on 06.09.2021.
//

class TaskListViewController: UIViewController,
                              ListAdapterDataSource,
                              AddItemViewDelegate,
                              TaskCellDelegate {
    
    private var items = TaskListConstants.initialTaskListItems
    
    private let addItemView = AddItemView()

	private var taskListView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .white
		return collectionView
	}()
	
	private lazy var adapter: ListAdapter = {
		return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
	}()
	
	override func viewDidLoad() {
		setupNavigation()
		view.addSubview(taskListView)
        addItemView.delegate = self
		adapter.collectionView = taskListView
		adapter.dataSource = self
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
        taskListView.frame = view.safeAreaLayoutGuide.layoutFrame
        addItemView.frame = view.safeAreaLayoutGuide.layoutFrame
	}
	
	private func setupNavigation() {
        title = "Tasks"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTask))
	}
	
	@objc
	private func addTask(sender: UIBarButtonItem) {
        view.addSubview(addItemView)
	}
	
	//MARK: -ListAdapterDataSource
	
	func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
		return items as [ListDiffable]
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
	
    //MARK: -AddItemViewDelegate
	func itemAdded(text: String?) {
        items.append(text ?? "")
        addItemView.reset()
        addItemView.removeFromSuperview()
        adapter.reloadData(completion: nil)
	}
    
    //MARK: -TaskCellDelegate
    func deleteTask(cell: UICollectionViewCell) {
        if let indexPath = taskListView.indexPath(for: cell) {
            items.remove(at: indexPath.row)
        }
        adapter.reloadData(completion: nil)
    }
}
