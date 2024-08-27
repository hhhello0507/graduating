//
//  GraduatingViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/24/24.
//

import Foundation
import Combine
import Model
import Shared

final class GraduatingViewModel: ObservableObject {
    
    @Published var remainTimePercent: Double = 0.0
    @Published var remainTime: DateComponents?
    @Published private var cancellable: AnyCancellable? = nil
    @Published private var startAt: Date?
    
    private let publisher = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    func observe(
        grade: Int,
        graduating: Graduating,
        limit: Int
    ) {
        cancellable?.cancel()
        startAt = .getStartAt(for: grade)
        
        guard let startAt,
              let adjustedEndAt = graduating.graduatingDay.adjustedEndAt(for: grade, limit: limit) else {
            return
        }
        
        cancellable = publisher.sink { _ in
            let currentTime = Date.now
            self.remainTime = currentTime.diff([.year, .month, .day, .hour, .minute, .second, .nanosecond], other: adjustedEndAt)
            self.remainTimePercent = currentTime.percent(from: startAt, to: adjustedEndAt)
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
