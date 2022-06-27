//
//  CustomNavBar.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI

struct CustomNavBar: View {
    @State var showConfirmationDialog = false
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.fill")
                .resizable()
                .foregroundColor(.fire)
                .padding(8)
                .frame(width: 32, height: 32)
                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
            VStack(alignment: .leading, spacing: 0) {
                Text("User name")
                    .font(.system(size: 24, weight: .semibold))
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 8, height: 8)
                    Text("online")
                        .foregroundColor(Color.gray)
                        .font(.caption)
                    
                }
            }
            Spacer()
            Button {
                showConfirmationDialog.toggle()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.fire)
            }

        }.padding(.horizontal)
        .confirmationDialog(Text("Do you want to sign out?"), isPresented: $showConfirmationDialog, actions: {
                Button("Cancel", role: .cancel) { }
                Button("Sign out", role: .destructive) {
                    //Sign out Action
                }
            })
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar()
    }
}
