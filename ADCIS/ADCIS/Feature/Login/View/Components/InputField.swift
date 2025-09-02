//
//  InputField.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import SwiftUI

struct InputField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
                    .frame(width: 20, height: 20)

                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            Divider()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InputField(
        icon: "envelope",
        placeholder: "Enter your email",
        text: .constant("")
    ).padding()
}
