import Combine
import SwiftUI
import MyDesignSystem
import Shared

struct HomeGraduatingContainer {
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var remainTime: DateComponents?
    @State private var remainTimePercent: Double?
    private let graduating: Graduating
    
    init(for graduating: Graduating) {
        self.graduating = graduating
    }
}

extension HomeGraduatingContainer: View {
    var body: some View {
        HStack(spacing: 8) {
            if let remainTime = remainTime, let remainTimePercent {
                VStack(alignment: .leading, spacing: 0) {
                    Text(String(format: "%.7f%%", remainTimePercent * 100))
                        .myFont(.headlineM)
                        .foreground(Colors.Label.strong)
                    Text(remainTime.prettyText)
                        .myFont(.labelR)
                        .foreground(Colors.Label.alternative)
                }
                Spacer()
                MyCircularProgressView(progress: remainTimePercent)
            }
        }
        .onReceive(timer) { _ in
            self.remainTime = graduating.remainTime
            self.remainTimePercent = graduating.remainTimePercent
        }
    }
}
