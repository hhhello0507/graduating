//  Author: hhhello0507
//  Created: 10/12/24

import SwiftUI
import Shared
import MyDesignSystem
import Flow
import ScopeKit

struct ScholarshipDetailView {
    struct Path: Hashable {
        let scholarship: Scholarship
    }
    
    @Environment(\.openURL) private var openURL
    
    private let scholarship: Scholarship
    
    init(path: Path) {
        self.scholarship = path.scholarship
    }
}

extension ScholarshipDetailView: View {
    var body: some View {
        MyTopAppBar.small(
            title: "",
            background: Colors.Background.alternative
        ) { insets in
            ScrollView {
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
                    Spacer().frame(height: 4)
                    MarqueeText(
                        text: scholarship.supportDetails ?? "",
                        font: .headling1R,
                        leftFade: 28,
                        rightFade: 28,
                        alignment: .leading
                    )
                    .frame(maxWidth: 240)
                    MyDivider()
                        .padding(.horizontal, 4)
                        .padding(.vertical, 12)
                    VStack(alignment: .leading, spacing: 16) {
                        makeCell(title: "운영기관명", content: scholarship.operatingInstitutionName)
                        makeCell(title: "홈페이지주소", content: scholarship.homepageUrl)
                        makeCell(
                            title: "모집 기간",
                            content: run {
                                if scholarship.recruitmentStartDate == nil && scholarship.recruitmentEndDate == nil {
                                    "기한 없음"
                                } else {
                                    (scholarship.recruitmentStartDate?.parseString(format: "yyyy-MM-dd") ?? "기한 없음")
                                    + " - "
                                    + (scholarship.recruitmentEndDate?.parseString(format: "yyyy-MM-dd") ?? "기한 없음")
                                }
                            }
                        )
                        if scholarship.schoolCategory.isEmpty {
                            makeCell(title: "학교 구분", content: "해당없음")
                        } else {
                            makeCell(title: "학교 구분") {
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
                            }
                        }
                        if scholarship.gradeLevel.isEmpty {
                            makeCell(title: "학년 구분", content: "해당없음")
                        } else {
                            makeCell(title: "학년 구분") {
                                HFlow(spacing: 4) {
                                    let gradeLevel = scholarship.gradeLevel
                                    ForEach(gradeLevel.indices, id: \.self) { index in
                                        Text(gradeLevel[index])
                                            .myFont(.labelR)
                                            .foreground(Colors.Label.assistive)
                                            .padding(.vertical, 3)
                                            .padding(.horizontal, 6)
                                            .background(Colors.Fill.normal)
                                            .cornerRadius(8, corners: .allCorners)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    Spacer().frame(height: 16)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("상세 내용")
                            .myFont(.headling2B)
                            .foreground(Colors.Label.normal)
                        makeCell(title: "지원내역", content: scholarship.supportDetails ?? "해당없음")
                        makeCell(title: "선발방법", content: scholarship.selectionMethodDetails ?? "해당없음")
                        makeCell(title: "선발인원", content: scholarship.selectionNumberDetails ?? "해당없음")
                        makeCell(title: "성적기준", content: scholarship.gradeCriteriaDetails ?? "해당없음")
                        makeCell(title: "제출서류", content: scholarship.requiredDocumentsDetails ?? "해당없음")
                        makeCell(title: "자격제한", content: scholarship.qualificationRestrictionsDetails ?? "해당없음")
                        makeCell(title: "소득기준", content: scholarship.incomeCriteriaDetails ?? "해당없음")
                        makeCell(title: "추천필요여부", content: scholarship.recommendationRequiredDetails ?? "해당없음")
                        makeCell(title: "특정자격", content: scholarship.specificQualificationDetails ?? "해당없음")
                        makeCell(title: "지역거주여부", content: scholarship.residencyDetails ?? "해당없음")
                    }
                    .padding(18)
                    .background(Colors.Background.normal)
                    .cornerRadius(12, corners: .allCorners)
                    .shadow(.evBlack3)
                    Text("장학금 자료 출처 - 한국장학재단")
                        .foreground(Colors.Label.assistive)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .myFont(.captionR)
                        .onTapGesture {
                            openURL.callAsFunction(
                                URL(string: "https://www.kosaf.go.kr/ko/main.do")!
                            )
                        }
                        .padding(.vertical, 32)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(insets)
            }
        }
    }
    
    @ViewBuilder
    private func makeCell(
        title: String,
        content: String
    ) -> some View {
        self.makeCell(title: title) {
            Text(LocalizedStringKey(content))
                .applyOpenURL()
                .myFont(.labelR)
                .foreground(Colors.Label.assistive)
                .lineSpacing(2)
        }
    }
    
    @ViewBuilder
    private func makeCell<C: View>(
        title: String,
        content: () -> C
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .myFont(.bodyB)
                .foreground(Colors.Label.normal)
            content()
        }
    }
}
