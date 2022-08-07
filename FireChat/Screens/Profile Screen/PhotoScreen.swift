//
//  PhotoScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 17.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct PhotoScreen: View {
    @EnvironmentObject var mainVm: MainMessagesViewModel
    
    let imageURL: String
    
    @State var isConfirmationDialogActive = false
    @State var showPicker = false
    @State var image: UIImage?
    @State var isEditButtonAvailable = false
    
    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                    .scaledToFit()
                    .clipped()
            }
            .overlay(content: {
                if mainVm.isPhotoLoading {
                    ProgressView()
                        .tint(.fire)
                        .scaleEffect(x: 3, y: 3, anchor: .center)
                        .offset(y: -50)
                }
            })
        }
        .sheet(isPresented: $showPicker, content: {
            ImagePicker(image: $image)
                .onDisappear {
                    if let image = image {
                        mainVm.saveImageToStorage(email: mainVm.currentUser?.email ?? "", password: mainVm.currentUser?.password ?? "", image: image)
                    }
                }
        })
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Edit", isPresented: $isConfirmationDialogActive, actions: {
            Button {
                showPicker = true
            } label: {
                Text("Select a photo")
            }
            Button {
                //TODO: Get image from camera.
            } label: {
                Text("Take a photo")
            }
            Button("Cancel", role: .cancel, action: {})
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditButtonAvailable {
                    Button {
                        isConfirmationDialogActive.toggle()
                    } label: {
                        Text("Edit")
                            .foregroundColor(.fire)
                    }
                }
            }
        }
    }
}

struct PhotoScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotoScreen(imageURL: "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png")
            .environmentObject(MainMessagesViewModel())
    }
}
