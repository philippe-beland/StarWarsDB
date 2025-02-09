//
//  EditOrganizationView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditOrganizationView: View {
    @Bindable var organization: Organization
    @Environment(\.dismiss) var dismiss: DismissAction
    
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
        sourceOrganizations = await loadOrganizationSources(organizationID: organization.id)
    }
}

#Preview {
    EditOrganizationView(organization: .example)
}
