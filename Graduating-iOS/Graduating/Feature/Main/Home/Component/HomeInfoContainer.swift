import SwiftUI
import MyDesignSystem
import Shared

public struct HomeInfoContainer {
    private let user: User
    
    init(for user: User) {
        self.user = user
    }
}

extension HomeInfoContainer: View {
    public var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Text("학교")
                    .myFont(.bodyB)
                    .foreground(Colors.Label.assistive)
                Text(user.school.name)
                    .myFont(.bodyM)
                    .foreground(Colors.Label.alternative)
                Spacer()
            }
            HStack(spacing: 8) {
                Text("졸업년도")
                    .myFont(.bodyB)
                    .foreground(Colors.Label.assistive)
                Text(String(user.graduatingYear) + "년")
                    .myFont(.bodyM)
                    .foreground(Colors.Label.alternative)
                Spacer()
            }
        }
    }
}
