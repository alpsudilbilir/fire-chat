//
//  NewMessageScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 1.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageScreen: View {
    @Environment(\.presentationMode) var dismiss
    @ObservedObject var mainVm = NewMessageScreenViewModel()
    let didSelectNewUser: (User) -> ()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(mainVm.users, id:\.uid) { user  in
                    HStack {
                        WebImage(url: URL(string: user.imageUrl ?? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .cornerRadius(52)
                            .clipped()
                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
                        Button {
                            dismiss.wrappedValue.dismiss()
                            didSelectNewUser(user)
                        } label: {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(user.username)
                                    .font(.title3)
                                    .foregroundColor(Color(.label))
                                HStack {
                                    Circle()
                                        .foregroundColor(Color.statusColor(status: user.status))
                                        .frame(width: 8, height: 8)
                                    Text(user.status)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    Divider()
                }
                .navigationTitle("Users")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.fire)
                        }
                    }
                }
            }
        }
        .accentColor(.fire)
    }
}

struct NewMessageScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageScreen(didSelectNewUser: { _ in
            
        })
    }
}
