//
//  CustomTextField.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI

import SwiftUI

struct CustomSecureField: View {
    @State var prompt: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                SecureField(prompt, text: $text)
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1.5)
                .overlay(.red)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(prompt: "Password", text: .constant(""))
    }
}
