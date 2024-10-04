//
//  MainCoordinator.swift
//  Graduating
//
//  Created by hhhello0507 on 8/23/24.
//

import SwiftUI

struct MainCoordinator: View {
    
    var body: some View {
        EmptyView()
            .navigationDestination(for: MainPath.self) { _ in MainView() }
            .navigationDestination(for: EditSchoolPath.self) { EditSchoolView($0) }
            .navigationDestination(for: EditGradePath.self) { EditGradeView($0) }
            .navigationDestination(for: SettingPath.self) { _ in SettingView() }
    }
}
