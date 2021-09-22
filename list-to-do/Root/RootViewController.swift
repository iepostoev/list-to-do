//
//  RootViewController.swift
//  list-to-do
//
//  Created by Igor Postoev on 06.09.2021.
//

class RootViewController: UIViewController {
	override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: nil)
		let tasksViewController = TaskListViewController()
		tasksViewController.view.configureLayout { (layout) in
			layout.isEnabled = true
			layout.width = YGValue(self.view.bounds.size.width)
			layout.height = YGValue(self.view.bounds.size.height)
		}
		tasksViewController.view.yoga.applyLayout(preservingOrigin: true)
        let navigation = UINavigationController(rootViewController: tasksViewController)
        addChild(navigation)
        view.addSubview(navigation.view)
	}
}
