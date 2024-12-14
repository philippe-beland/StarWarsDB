//
//  CommentsView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct CommentsView: View {
    let comments: String?
    
    var body: some View {
        Section("Comments") {
            Text(comments ?? "")
        }
    }
}

#Preview {
    CommentsView(comments: "Hello World!")
}
