import Combine
import WidgetKit
import Shared
import Data

class GraduatingProvider: TimelineProvider {
    private var subscriptions = Set<AnyCancellable>()
    
    typealias Entry = GraduatingEntry
    
    func placeholder(in context: Context) -> Entry {
        .empty
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(.empty)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let currentTime = Date.now
        let afterDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentTime)!
        
        UserService.shared.getMe()
            .ignoreError()
            .sink { user in
                guard let graduating = user.graduating,
                      let remainTime = graduating.remainTime,
                      let remainTimePercent = graduating.remainTimePercent else { return }
                let entry = GraduatingEntry(
                    date: currentTime,
                    remainTime: remainTime,
                    remainTimePercent: remainTimePercent
                )
                let timeline = Timeline(entries: [entry], policy: .after(afterDate))
                completion(timeline)
            }
            .store(in: &self.subscriptions)
    }
}
