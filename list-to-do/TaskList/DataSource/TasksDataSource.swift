//
//  TasksDataSource.swift
//  list-to-do
//
//  Created by Igor Postoev on 28.09.2021.
//

class TasksDataSource {
    
    private var tasks = [String]()
    let fileName = "tasks.txt"
    
    func addTask(taskText: String) {
        tasks.append(taskText)
        saveTasks()
    }
    
    func removeTask(index: Int) {
        guard tasks.indices.contains(index) else {
            return
        }
        tasks.remove(at: index)
        saveTasks()
    }
    
    func getTasks() -> [String] {
        return tasks
    }
    
    func prefillTasks(with taskList: [String]) {
        tasks = taskList
    }
    
    func loadTasks() {
        guard let documentsUrl = FileManagerHelper.getDocumetsDirectoryUrl() else {
            return
        }
        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileUrl)
            if let taskList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                tasks = taskList
            }
        } catch {
            let tasks = TaskListConstants.initialTaskListItems
            prefillTasks(with: tasks)
            saveTasks()
            print(error)
        }
    }
    
    func saveTasks() {
        guard let documentsUrl = FileManagerHelper.getDocumetsDirectoryUrl() else {
            return
        }
        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: tasks,
                                                        requiringSecureCoding: false)
            try data.write(to: fileUrl)
        } catch {
            print(error)
        }
    }
}
