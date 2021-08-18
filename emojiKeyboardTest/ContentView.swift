//
//  ContentView.swift
//  emojiKeyboardTest
//
//  Created by Achintha Kahawalage on 2021-05-17.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var text: String = ""
        @State private var isEmoji: Bool = false
    @State var emojiText = ""
    var body: some View {
            
            HStack{
                EmojiTextField(text: $text, placeholder: "Enter emoji", isEmoji: $isEmoji)
                Button("EMOJI") {
                    isEmoji.toggle()
                }.background(Color.yellow)
            }
        }
    
}


struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    @Binding var isEmoji: Bool
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        emojiTextField.isEmoji = self.isEmoji
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
        uiView.isEmoji = isEmoji
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}



class UIEmojiTextField: UITextField {
    
    var isEmoji = false {
        didSet {
            setEmoji()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setEmoji() {
        self.reloadInputViews()
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" && self.isEmoji{
                self.keyboardType = .default
                return mode
                
            } else if !self.isEmoji {
                return mode
            }
        }
        return nil
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
