import SwiftUI

struct OrganizationInfoSection: View {
    @State var organization: Organization
    
    var body: some View {
        Section("Organization Infos") {
            FieldView(fieldName: "First Appearance", info: $organization.firstAppearance)
        }
    }
}

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
