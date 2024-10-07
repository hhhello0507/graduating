//import Combine
//import Foundation
//import Shared
//
//final class GraduatingViewModel: ObservableObject {
//    private let publisher = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//    var cancellable: Cancellable?
//    
//    deinit {
//        cancellable?.cancel()
//    }
//}
//
//extension GraduatingViewModel {
//    func observe(
//        graduating: Graduating
//    ) {
//        guard cancellable == nil else { return }
////        startAt = .getStartAt(for: grade)
//        
////        guard let startAt,
////              let adjustedEndAt = graduating.graduatingDay.adjustedEndAt(for: grade, limit: limit) else {
////            return
////        }
//        
//        cancellable = publisher.sink { _ in
//            let currentTime = Date.now
//            self.remainTime = currentTime.diff([.year, .month, .day, .hour, .minute, .second, .nanosecond], other: adjustedEndAt)
//            self.remainTimePercent = currentTime.percent(from: startAt, to: adjustedEndAt)
//        }
//    }
//}
