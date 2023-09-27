//
//  X32_Master_VolumeApp.swift
//  X32 Master Volume
//
//  Created by Adam Ware on 25/9/2023.
//

import SwiftUI

@main
struct X32_Master_VolumeApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        Settings {
            EmptyView().frame(width:.zero)
        }
    }
}
