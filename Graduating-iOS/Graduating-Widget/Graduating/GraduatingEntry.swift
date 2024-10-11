import WidgetKit
import Shared

struct GraduatingEntry: TimelineEntry {
    let date: Date
    let graduating: Graduating
}

extension GraduatingEntry {
    static var empty: GraduatingEntry {
        var components = DateComponents()
        if let year = components.year {
            components.setValue(year - 1, for: .year)
        }
        return GraduatingEntry(
            date: .now,
            graduating: .init(
                graduatingYear: 2026,
                schoolType: .high
            )
        )
    }
}
