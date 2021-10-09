//
//  TaskListPresenter.swift
//  list-to-do
//
//  Created by Igor Postoev on 29.09.2021.
//

class TaskListPresenter: TaskListPresenterProtocol {

    var dataSource: TasksDataSource!
    var view: TaskListViewProtocol!
    
    func getTasks() -> [String] {
        return dataSource.getTasks()
    }
    
    func addTask(_ text: String?) {
        guard let tasktext = text, !tasktext.isEmpty else {
            return
        }
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self, weak view] in
            self?.dataSource.addTask(taskText: tasktext)
            DispatchQueue.main.async {
                view?.removeAddItemView()
                view?.reload()
            }
        }
    }
    
    func removeTask(_ indexPath: IndexPath) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async { [weak self, weak view] in
            self?.dataSource.removeTask(index: indexPath.section)
            DispatchQueue.main.async {
                view?.reload()
            }
        }
    }
}
