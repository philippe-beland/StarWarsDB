import SwiftUI

struct OrganizationInfoSection: View {
    @State var organization: Organization
    
    var body: some View {
        Section("Organization Infos") {
            EditableTextField(fieldName: "First Appearance", info: $organization.firstAppearance)
        }
    }
}

struct OrganizationDetailView: View {
    @Bindable var organization: Organization
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceOrganizations = [SourceEntity<Organization>]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $organization.name,
                    url: organization.url
                ),
                sidePanel: SidePanelView(
                    id: organization.id,
                    comments: Binding(
                        get: { organization.comments ?? "" },
                        set: { organization.comments = $0 }
                    ),
                    InfosSection: OrganizationInfoSection(organization: organization)
                ),
                sourceEntities: sourceOrganizations)
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
    OrganizationDetailView(organization: .example)
}
