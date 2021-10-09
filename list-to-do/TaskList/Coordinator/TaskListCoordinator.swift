//
//  TaskListCoordinator.swift
//  list-to-do
//
//  Created by Igor Postoev on 29.09.2021.
//

class TaskListCoordinator {
    
    static func createController() -> UIViewController {
        
        // dataSource
        let dataSource = TasksDataSource()
        dataSource.loadTasks()
        
        // presenter
        let presenter = TaskListPresenter()
        presenter.dataSource = dataSource
        
        //controller
        let controller = TaskListViewController()
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}
