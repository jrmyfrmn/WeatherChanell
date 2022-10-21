////
////  PersistenceManager.swift
////  Weather Channel
////
////  Created by jeremy.fermin on 10/18/22.
////
//
//import Foundation
//
//class PersistenceManager {
//    
//    static let shared = PersistenceManager()
//    
//    private init() {}
//    
//    func documentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
//    
//    func save(addlocations: AddLocations) {
//        let path = documentsDirectory().appendingPathComponent("addlocations.plist")
//        let plistEncoder = PropertyListEncoder()
//        plistEncoder.outputFormat = .xml
//        let encoded = try! plistEncoder.encode(addlocations)
//        try! encoded.write(to: path)
//    }
//}
