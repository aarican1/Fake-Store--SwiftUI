//
//  TextFieldView.swift
//  Fake Store
//
//  Created by Abdurrahman Arıcan on 6.05.2025.
//
import SwiftUI

struct TextFieldView: View {
    let titleKey : String
    @Binding var text : String
    let  fieldType : FieldType
    
    
    var body: some View {
    Group{
            if fieldType == .password{
                    SecureField(titleKey, text:$text )
            }
            else{
                TextField(titleKey, text: $text)
                    .keyboardType( fieldType == .email ? .emailAddress: .default)
                
            }
         
        }
        .padding()
        .frame(height:56)
        .lineLimit(1)
        .autocapitalization(.none)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            
    }
}

#Preview {
    TextFieldView(
        titleKey: "Test",
        text: .constant(""),
        fieldType: .email
    )
}

extension TextFieldView {
    enum FieldType: Hashable {
        case text
        case email
        case password
    }
}

