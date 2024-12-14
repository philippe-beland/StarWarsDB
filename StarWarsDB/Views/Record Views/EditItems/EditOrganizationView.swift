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
    
    @State private var sourceOrganizations: [SourceOrganization] = [.example, .example, .example]
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: organization, sourceItems: sourceOrganizations, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "First Appearance", info: organization.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditOrganizationView(organization: .example)
}
