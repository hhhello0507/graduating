//
//  GraduatingApp.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import SwiftUI
import MyDesignSystem

@main
struct GraduatingApp: App {
    
    @StateObject private var dialogProvider = DialogProvider()
    @StateObject private var datePickerProvider = DatePickerProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    @StateObject private var router = Router()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MyModalProvider(
                dialogProvider: dialogProvider,
                datePickerProvider: datePickerProvider,
                timePickerProvider: timePickerProvider
            ) {
                NavigationStack(path: $router.path) {
                    if let _ = appState.grade,
                       let _ = appState.school {
                        MainCoordinator()
                    } else {
                        OnboardingCoordinator()
                    }
                }
            }
            .environmentObject(router)
            .environmentObject(appState)
            .registerWanted()
        }
    }
}
