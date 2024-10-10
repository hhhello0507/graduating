import WidgetKit
import Shared

struct MealProvider: TimelineProvider {
    typealias Entry = MealEntry
    func placeholder(in context: Context) -> Entry {
        return .empty
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(.empty)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? .init()
//        Task {
//            var currentDate = Date()
//            // 오후 8시가 지나면 다음날로
//            if currentDate[.hour] >= 20 {
//                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
//            }
//            
//            do {
//                let meal = try await mealRepository.fetchMeal(
//                    .init(
//                        year: currentDate[.year],
//                        month: currentDate[.month],
//                        day: currentDate[.day]
//                    )
//                )
//                let entry = MealEntry(
//                    date: currentDate,
//                    meal: meal
//                )
//                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
//                completion(timeline)
//            } catch {
//                let entry = MealEntry.empty
//                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
//                completion(timeline)
//            }
//        }
    }
}
