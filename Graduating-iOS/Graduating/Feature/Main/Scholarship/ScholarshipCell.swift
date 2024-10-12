//  Author: hhhello0507
//  Created: 10/11/24

import SwiftUI
import Shared
import Flow
import MyDesignSystem
import ScopeKit

struct ScholarshipCell: View {
    private let scholarship: Scholarship
    private let action: () -> Void
    
    init(
        for scholarship: Scholarship,
        action: @escaping () -> Void
    ) {
        self.scholarship = scholarship
        self.action = action
    }
    
    func daysBetween(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    Text(scholarship.productName)
                        .foreground(Colors.Label.normal)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .myFont(.bodyR)
                    Spacer()
                    Text(
                        scholarship.recruitmentEndDate?.let {
                            "D-\(Date.now.dayDiff(endAt: $0))"
                        } ?? "기한 없음"
                    )
                    .myFont(.labelB)
                    .foreground(Colors.Static.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Colors.Primary.normal)
                    .cornerRadius(12, corners: .allCorners)
                    // TODO: Add 조회수
                }
                MarqueeText(
                    text: scholarship.supportDetails ?? "",
                    font: .headling1R,
                    leftFade: 28,
                    rightFade: 28,
                    alignment: .leading
                )
                .frame(maxWidth: 240)
                .padding(.top, 4)
                if !scholarship.schoolCategory.isEmpty {
                    HFlow(spacing: 4) {
                        let schoolCategory = scholarship.schoolCategory
                        ForEach(schoolCategory.indices, id: \.self) { index in
                            Text(schoolCategory[index])
                                .myFont(.labelR)
                                .foreground(Colors.Label.assistive)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 6)
                                .background(Colors.Fill.normal)
                                .cornerRadius(8, corners: .allCorners)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                }
            }
            .background(Colors.Background.neutral)
            .padding(.vertical, 24)
        }
        .scaledButton()
    }
}
