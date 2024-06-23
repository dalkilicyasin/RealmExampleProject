//
//  RealmExampleProjectApp.swift
//  RealmExampleProject
//
//  Created by yasin on 22.06.2024.
//

import SwiftUI

@main
struct RealmExampleProjectApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
