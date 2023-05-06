//
//  Saver Variables.swift
//  PBT Tournaments
//
//  Created by Caedmon Myers on 5/5/23.
//

import SwiftUI

let defaults = UserDefaults.standard

class AppDefaultsStorage: ObservableObject {
    
    @Published var myTournamentsM = [""] {
        didSet {
            defaults.set(myTournamentsM, forKey: "myTournamentsM")
        }
    }
    
    @Published var myTournamentsP = [""] {
        didSet {
            defaults.set(myTournamentsP, forKey: "myTournamentsP")
        }
    }
}
