//
//  AddPlanetView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct AddPlanetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var region: Region?
    @State private var sector: String?
    @State private var system: String?
    @State private var capitalCity: String?
    @State private var destinations: [String] = []
    @State private var firstAppearance: String?
    @State private var comments: String?
    
    var onPlanetCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: savePlanet)
                        .disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new Planet")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func savePlanet() {
        let newPlanet = Planet(name: name, region: region, sector: sector, system: system, capitalCity: capitalCity, destinations: destinations, firstAppearance: firstAppearance, comments: comments)
        newPlanet.save()
        onPlanetCreation(newPlanet)
        dismiss()
    }
}
