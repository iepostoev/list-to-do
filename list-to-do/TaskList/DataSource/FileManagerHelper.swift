//
//  FileManagerHelper.swift
//  list-to-do
//
//  Created by Igor Postoev on 28.09.2021.
//

class FileManagerHelper {
    
    static func getDocumetsDirectoryUrl() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths.first
    }
}
