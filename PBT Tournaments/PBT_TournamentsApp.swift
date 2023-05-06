//
//  PBT_TournamentsApp.swift
//  PBT Tournaments
//
//  Created by Caedmon Myers on 4/28/23.
//

import SwiftUI
import Firebase

@main
struct PBT_TournamentsApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .environmentObject(dataManager)
        }
    }
}
