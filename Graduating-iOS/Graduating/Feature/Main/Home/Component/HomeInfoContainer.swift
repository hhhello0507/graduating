import SwiftUI
import Model
import MyDesignSystem

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
                Text("학년")
                    .myFont(.bodyB)
                    .foreground(Colors.Label.assistive)
//                Text("\(grade)학년")
//                    .myFont(.bodyM)
//                    .foreground(Colors.Label.alternative)
                Spacer()
            }
        }
    }
}
