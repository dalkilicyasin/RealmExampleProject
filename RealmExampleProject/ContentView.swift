//
//  ContentView.swift
//  RealmExampleProject
//
//  Created by yasin on 22.06.2024.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(ShoppingList.self) var shoppingList
    @State private var isPresented: Bool = false
    @State private var imageData: Data = Data()
    
    var body: some View {
        NavigationStack {
            VStack {
                if shoppingList.isEmpty {
                    Text("No Shopping List")
                }
                
                List {
                    ForEach(shoppingList, id: \.id){ shoppingList in
                        
                        
                        VStack(alignment: .leading){
                             let imageData = shoppingList.imageData
                             let image = UIImage(data: imageData)
                                Image(uiImage: image ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            
                            
                            Text(shoppingList.title)
                            Text(shoppingList.address)
                                .opacity(0.4)
                        
                            
                        }
                    }.onDelete(perform: $shoppingList.remove)
                }
                    .navigationTitle("Grocery Main Page")
            }
            .sheet(isPresented: $isPresented, content: {
                AddShoppingListScreen()
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
