//
//  GraduatingProvider.swift
//  Graduating-WidgetExtension
//
//  Created by hhhello0507 on 8/24/24.
//

import WidgetKit
import Shared
import Data
import Model
import MyFoundationUtil

struct GraduatingProvider: TimelineProvider {
    
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
        
        // TODO: Fix
//        guard let grade = UserDefaultsType.grade.value as? Int,
//              let graduatingJson = UserDefaultsType.graduating.value as? String,
//              let graduating = Graduating.decode(graduatingJson) else {
//            print("invalid grade")
//            return
//        }
//        guard let schoolJson = UserDefaultsType.school.value as? String,
//              let school = School.decode(schoolJson) else {
//            print("invalid school")
//            return
//        }
//        
//        let limit = school.type?.limit ?? 3
//        
//        guard let startAt = Date.getStartAt(for: grade),
//              let adjustedEndAt = graduating.graduatingDay.adjustedEndAt(for: grade, limit: limit) else {
//            print("invalid time")
//            return
//        }
//        
//        let remainTime: DateComponents = currentTime.diff([.year, .month, .day, .hour, .minute, .second, .nanosecond], other: adjustedEndAt)
//        let remainTimePercent = currentTime.percent(from: startAt, to: adjustedEndAt)
//        
//        let entry = GraduatingEntry(
//            date: currentTime,
//            remainTime: remainTime,
//            remainTimePercent: remainTimePercent
//        )
//        let timeline = Timeline(entries: [entry], policy: .after(afterDate))
//        completion(timeline)
    }
}
