//
//  TaskListPresenterProtocol.swift
//  list-to-do
//
//  Created by Igor Postoev on 29.09.2021.
//

protocol TaskListPresenterProtocol {
    func addTask(_ text: String?)
    func removeTask(_ indexPath: IndexPath)
    func getTasks() -> [String]
}
