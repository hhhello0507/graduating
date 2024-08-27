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

struct GraduatingProvider: TimelineProvider {
    func placeholder(in context: Context) -> GraduatingEntry {
        GraduatingEntry(
            date: .now,
            remainTime: .init(),
            remainTimePercent: 40
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
//        let entry = GraduatingEntry(date: Date(), emoji: "😀")
//        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentTime = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentTime)!
        
        guard let grade = UserDefaultsType.grade.value as? Int,
              let graduatingJson = UserDefaultsType.graduating.value as? String,
              let graduating = Graduating.decode(graduatingJson) else {
            return
        }
        guard let schoolJson = UserDefaultsType.school.value as? String,
              let school = School.decode(schoolJson) else {
            return
        }
        
        let limit = school.type?.limit ?? 3
        
        guard let startAt = Date.getStartAt(for: grade),
              let adjustedEndAt = graduating.graduatingDay.adjustedEndAt(for: grade, limit: limit) else {
            return
        }
        
        let remainTime = currentTime.diff([.year, .month, .day, .hour, .minute, .second, .nanosecond], other: adjustedEndAt)
        let remainTimePercent = currentTime.percent(from: startAt, to: adjustedEndAt)
        
        let entry = GraduatingEntry(
            date: entryDate,
            remainTime: remainTime,
            remainTimePercent: remainTimePercent
        )
        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
}
