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
    @ObservedObject var viewModel = NewMessageScreenViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.users, id:\.uid) { user  in
                    HStack {
                        WebImage(url: URL(string: user.imageUrl ?? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .cornerRadius(52)
                            .clipped()
                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
                        NavigationLink {
                            Text("Destination")
                        } label: {
                            Text(user.email)
                                .font(.title3)
                                .foregroundColor(Color(.label))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
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
    }
}

struct NewMessageScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageScreen()
    }
}
