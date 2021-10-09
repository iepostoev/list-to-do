//
//  ViewController.swift
//  list-to-do
//
//  Created by Igor Postoev on 06.09.2021.
//

class TaskListSectionController: ListSectionController {
    
    var cellDelegate: TaskCellDelegate?
    
    private var taskTitle: String?
    
    override init() {
        super.init()
        //make vertical inset between cells
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return CGSize()
        }
        return CGSize(width: context.containerSize.width,
                      height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
              let cell = context.dequeueReusableCell(of: TaskCell.self,
                                                     for: self,
                                                     at: index) as? TaskCell else {
            return UICollectionViewCell()
        }
        cell.delegate = cellDelegate
        cell.update(text: taskTitle)
        
        return cell
    }
    
    override func didUpdate(to text: Any) {
        self.taskTitle = text as? String
    }
}

