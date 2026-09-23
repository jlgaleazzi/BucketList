//
//  EditView.swift
//  BucketList
//
//  Created by Juan Galeazzi on 9/23/26.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location:Location
    
    @State private var name:String
    @State private var description:String
   
    
    init(location:Location) {
        self.location = location
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                    
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditView(location: .example)
}
