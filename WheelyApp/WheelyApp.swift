//
//  WheelyApp.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 13/04/23.
//

import SwiftUI

@main
struct WheelyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                OptionsView()
            }
            .tint(.primaryPurple)
        }
    }
}
