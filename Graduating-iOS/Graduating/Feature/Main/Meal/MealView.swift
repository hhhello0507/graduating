import SwiftUI
import Shared
import SwiftUIIntrospect
import MyDesignSystem
import ScopeKit

struct MealView: View {
    @StateObject private var viewModel = MealViewModel()
    @State private var posY: CGFloat = .zero {
        didSet {
            if posY > 0 {
                posY = 0
            } else if posY < -calendarSize.height {
                posY = -calendarSize.height
            }
        }
    }
    private var adjustedPosY: CGFloat {
        posY + calendarSize.height
    }
    @State private var calendarRowSize: CGSize?
    @State private var calendarSize: CGSize = .zero
    @State private var headerSize: CGSize = .zero
    @State private var openCalendar = false
    
    private var adjustedCalendarHeight: CGFloat? {
        guard let minHeight = calendarRowSize?.height else { return nil }
        let maxHeight = max(minHeight, calendarSize.height)
        return (adjustedPosY - minHeight * scrollRate + minHeight).clamped(to: minHeight...maxHeight)
    }
    private var weeks: [[Date?]] {
        viewModel.selectedCalendar.weeks
    }
    // 선택된 날짜가 몇 주 인지
    private var selectedDateWeekCount: Int {
        for (idx, week) in Array(weeks.enumerated()) {
            for date in week {
                guard let date else { continue }
                if date.equals(viewModel.selectedDate, components: [.year, .month, .day]) {
                    return idx
                }
            }
        }
        return 0
    }
    private var scrollRate: CGFloat {
        adjustedPosY / calendarSize.height
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: headerSize.height + abs(posY))
                    viewModel.meals.makeView {
                        ProgressView()
                            .padding(.top, 32)
                    } success: { meals in
                        LazyVStack(spacing: 12) {
                            ForEach(Array(meals.enumerated()), id: \.offset) { idx, meal in
                                MealCell(meal: meal)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 54)
                    } failure: { _ in
                        Text("급식을 불러올 수 없어요")
                            .myFont(.labelM)
                            .foreground(Colors.Label.alternative)
                            .padding(.top, 32)
                    }
                    .padding(.bottom, calendarSize.height)
                }
                .background(
                    GeometryReader { inner in
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: inner.frame(in: .named("scrollView")).origin.y
                        )
                    }
                )
            }
            .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { view in
                view.bounces = false
            }
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.posY = value
                openCalendar = value > -calendarSize.height / 2
            }
            .overlay {
                if case .success(let meals) = viewModel.meals,
                   meals.isEmpty {
                    Text("급식이 없어요")
                        .myFont(.labelM)
                        .foreground(Colors.Label.alternative)
                        .padding(.top, headerSize.height)
                }
            }
            makeCalendar()
        }
        .padding(.top, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.Background.neutral)
        .onAppear {
            viewModel.onAppear()
        }
        .googleBannderAd(
            inset: .top,
            adUnitId: "ca-app-pub-2589637472995872/3554240467"
        )
    }
    
    @ViewBuilder
    private func makeCalendar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { date in
                    Text(date)
                        .myFont(.labelR)
                        .foreground(Colors.Label.alternative)
                        .frame(maxWidth: .infinity)
                }
            }
            VStack(spacing: 0) {
                ForEach(weeks, id: \.hashValue) { week in
                    HStack(spacing: 0) {
                        ForEach(Array(week.enumerated()), id: \.offset) { _, date in
                            let selected = date?.let {
                                $0.equals(viewModel.selectedDate, components: [.year, .month, .day])
                            } ?? false
                            Button {
                                if !selected, let date {
                                    viewModel.selectedDate = date
                                    viewModel.selectedCalendar = date
                                }
                            } label: {
                                CalendarDateCell(date: date, selected: selected)
                            }
                            .scaledButton()
                            .disabled(
                                !openCalendar &&
                                (date == nil || !viewModel.selectedDate.equals(date!, components: [.weekOfYear]))
                            )
                        }
                    }
                    .onReadSize { size in
                        self.calendarRowSize = size
                    }
                }
            }
            .offset(
                y: (scrollRate - 1)
                * (calendarRowSize?.height ?? 36)
                * CGFloat(selectedDateWeekCount)
            )
            .onReadSize {
                self.calendarSize = $0
            }
            .frame(height: adjustedCalendarHeight, alignment: .top)
            .padding(.bottom, 8)
            .clipped()
            MyDivider()
                .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .background(Colors.Background.neutral)
        .onReadSize { size in
            self.headerSize = size
        }
    }
}

#Preview {
    MealView()
}

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

extension Date {
    var range: Range<Int>? {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: self)
    }
    
    // self의 month를 기준으로 calendar 생성
    // nil: 이전 month 혹은 다음 month
    var weeks: [[Date?]] {
        let calendar = Calendar.current
        // 해당 월의 첫째 날
        var components = calendar.dateComponents([.year, .month], from: self)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)!
        
        // 첫째 날의 요일 (일요일 = 1, 월요일 = 2, ..., 토요일 = 7)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 날짜 배열 생성
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        days += Array(1...(range?.count ?? 0)).compactMap {
            components.day = $0
            return calendar.date(from: components)
        }
        days += Array(repeating: nil, count: (7 - days.count % 7) % 7)
        
        // 주 단위로 배열을 나눔
        return stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0..<$0 + 7])
        }
    }
}
