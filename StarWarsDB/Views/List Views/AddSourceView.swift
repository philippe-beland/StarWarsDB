//
//  AddSourceView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/19/24.
//

import SwiftUI

struct AddSourceView: View {
    @Environment(\.dismiss) var dismiss
    
    var onSourceCreation: (Source) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Form {
                    Section("Details") {
                        
                    }
                    Section("Commentary") {
                        
                    }
//                    Section {
//                        Button("Save", action saveSource)
//                            .disabled(name.isEmpty)
//                    }
                }
                .navigationTitle("Add New Source")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        //.task {
        //    series = await loadSeries()
        //}
    }
    
//    private func saveSource() {
//        let newSource = Source()
//        
//        newSource.save()
//        onSourceCreation(newSource)
//        dismiss()
//    }
}

//#Preview {
//    AddSourceView()
//}
