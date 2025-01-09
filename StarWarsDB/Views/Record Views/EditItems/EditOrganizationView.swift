//
//  EditOrganizationView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditOrganizationView: View {
    @Bindable var organization: Organization
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceOrganizations = [SourceOrganization]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: organization, sourceItems: sourceOrganizations, InfosSection: OrganizationInfoSection(organization: organization))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: organization.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceOrganizations = await loadSourceOrganizations(recordField: "organization", recordID: organization.id.uuidString)
    }
}

#Preview {
    EditOrganizationView(organization: .example)
}
