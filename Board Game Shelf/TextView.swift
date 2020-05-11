import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView

        init(_ textView: TextView) {
            self.parent = textView
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

struct TextView_Previews: PreviewProvider {
    @State var text: String = ""

    static var previews: some View {
        TextView(text: .constant("Long text that will span multiple lines."))
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
