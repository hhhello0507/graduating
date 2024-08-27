import SwiftUI
import MyDesignSystem

struct EditGradePath: Hashable {}

struct EditGradeView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var dialogProvider: DialogProvider
    @EnvironmentObject private var appState: AppState
    @FocusState private var field
    @State private var grade = 1
    
    public init(_ path: EditGradePath) {}
    
    private var limit: Int {
        appState.school?.type?.limit ?? 3
    }
    
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            VStack(spacing: 4) {
                Text("학년을 알려주세요")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("Grade", selection: $grade) {
                    ForEach(1...limit, id: \.self) { number in
                        Text("\(number)")
                            .myFont(.headling2M)
                    }
                }
                .pickerStyle(.wheel)
                Spacer()
                MyButton("다음") {
                    dialogProvider.present(
                        .init(title: "\(grade)학년이 맞으신가요?")
                        .primaryButton("네, 맞아요") {
                            appState.grade = grade
                            router.toRoot()
                        }
                        .secondaryButton("닫기")
                    )
                }
                .padding(.bottom, 10)
            }
            .padding(insets)
        }
        .onAppear {
            if let grade = appState.grade {
                self.grade = grade
            }
        }
    }
}

#Preview {
    EditGradeView(.init())
}
