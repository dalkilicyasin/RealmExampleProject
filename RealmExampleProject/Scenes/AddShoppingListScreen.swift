//
//  AddShoppingListScreen.swift
//  RealmExampleProject
//
//  Created by yasin on 22.06.2024.
//

import SwiftUI
import RealmSwift
import PhotosUI

struct AddShoppingListScreen: View {
    @State private var title: String = ""
    @State private var address: String = ""
    
    @ObservedResults(ShoppingList.self) var shoppingList
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    @State var imageHeight: CGFloat = 100.0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            VStack {
                
                    Form {
                        TextField("Enter Title", text: $title)
                        TextField("Enter Address", text: $address)
                    
                    }.frame(height: 200)
                    
                    Form {
                        if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        }
                        
                        PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                            Label("Add Image", systemImage: "photo")
                        }
                        
                        if selectedPhotoData != nil {
                            Button(role: .destructive, action: {
                                withAnimation {
                                    selectedPhoto = nil
                                    selectedPhotoData = nil
                                }
                            }, label: {
                                Label("Remove Image", systemImage: "xmark")
                                    .foregroundStyle(.red)
                            })
                        }
                        
                        
                        
                    }
                    .frame(height: imageHeight)
             
                Button(action: {
                    
                    let shoppingList = ShoppingList()
                    shoppingList.title = title
                    shoppingList.address = address
                    if let selectedPhotoData {
                        shoppingList.imageData = selectedPhotoData
                    }
                   
                    $shoppingList.append(shoppingList)
                    
                    dismiss()
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }).buttonStyle(.bordered)
                    .padding()
        
                Spacer()
            }.task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                    imageHeight = 400
                }else {
                    imageHeight = 100
                }
                
            }
            .background(Color(uiColor: .systemGray6))
       
        }
    }
}

#Preview {
    AddShoppingListScreen()
}
