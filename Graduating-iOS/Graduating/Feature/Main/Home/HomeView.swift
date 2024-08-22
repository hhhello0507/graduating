import SwiftUI
import MyDesignSystem
import Combine

struct HomeView: View {
    
    @EnvironmentObject private var appState: AppState
    @State private var remainTimePercent: Double = 0.0
    @State private var remainTime: DateComponents?
    @State private var cancellable: AnyCancellable? = nil
    @State private var startAt: Date?
    
    private let publisher = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        MyTopAppBar.default(title: "홈") { _ in
            ScrollView {
                VStack(spacing: 10) {
                    MyCardView(title: "내 정보") {
                        VStack(spacing: 4) {
                            HStack(spacing: 8) {
                                Text("학교")
                                    .myFont(.bodyB)
                                    .foreground(Colors.Label.assistive)
                                if let school = appState.school {
                                    Text(school.name)
                                        .myFont(.bodyM)
                                        .foreground(Colors.Label.alternative)
                                }
                                Spacer()
                            }
                            HStack(spacing: 8) {
                                Text("학년")
                                    .myFont(.bodyB)
                                    .foreground(Colors.Label.assistive)
                                if let grade = appState.grade {
                                    Text("\(grade)학년")
                                        .myFont(.bodyM)
                                        .foreground(Colors.Label.alternative)
                                }
                                Spacer()
                            }
                        }
                        .padding(6)
                    }
                    MyCardView(title: "졸업까지") {
                        HStack {
                            if let remainTime {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(String(format: "%.7f%%", remainTimePercent * 100))
                                        .myFont(.headlineM)
                                        .foreground(Colors.Label.strong)
                                    Text({
                                        var text = ""
                                        if let year = remainTime.year, year > 0 { let _ = text += "\(year)년 " }
                                        if let month = remainTime.month, month > 0 { let _ = text += "\(month)개월 " }
                                        if let day = remainTime.day, day > 0 { let _ = text += "\(day)일 " }
                                        if let hour = remainTime.hour, hour > 0 { let _ = text += "\(hour)시간 " }
                                        if let minute = remainTime.minute, minute > 0 { let _ = text += "\(minute)분 " }
                                        if let second = remainTime.second, second > 0 {
                                            let _ = text += "\(second)"
                                            if let nanosecond = remainTime.nanosecond, nanosecond > 0 {
                                                let _ = text += ".\(nanosecond / 1_000_000_00)"
                                            }
                                            text += "초"
                                        }
                                        return text
                                    }())
                                    .myFont(.labelR)
                                    .foreground(Colors.Label.alternative)
                                }
                            }
                            Spacer()
                            MyCircularProgressView(progress: remainTimePercent)
                        }
                        .padding(6)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 10)
            }
        }
        .onAppear {
            guard let grade = appState.grade else {
                return
            }
            startAt = .getStartAt(for: grade)
            
            guard let startAt,
                  let endAt = appState.graduating?.graduatingDay,
                  let adjustedEndAt = endAt.adjustedEndAt(for: grade) else {
                return
            }
            
            cancellable = publisher.sink { _ in
                let currentTime = Date.now
                let dateDiff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: currentTime, to: adjustedEndAt)
                self.remainTime = dateDiff
                
                let remainPercent = (currentTime.timeIntervalSince1970 - startAt.timeIntervalSince1970) / (adjustedEndAt.timeIntervalSince1970 - startAt.timeIntervalSince1970)
                self.remainTimePercent = remainPercent
            }
        }
    }
}

#Preview {
    HomeView()
        .registerWanted()
}
