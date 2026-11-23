import SwiftUI

struct FriendsView: View {
    let friendsModel: FriendsModel

    @State private var selectedFilter = "By next occasion"
    @State private var searchText = ""

    private var rows: [FriendsModel.Friend] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let matches = friendsModel.friends.filter { friend in
            query.isEmpty || friend.name.localizedCaseInsensitiveContains(query)
                || friend.occasion.localizedCaseInsensitiveContains(query)
        }
        switch selectedFilter {
        case "A–Z":
            return matches.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        case "Groups":
            return matches.filter(\.isGroup)
        default:
            return matches.sorted { $0.daysUntilOccasion < $1.daysUntilOccasion }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Friends").font(.title.bold())
                Spacer()
                Text("+ Invite").fontWeight(.semibold).padding(12)
                    .overlay { RoundedRectangle(cornerRadius: 10).strokeBorder() }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Search friends").font(.subheadline).foregroundStyle(.secondary)
                TextField("Name or occasion", text: $searchText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .overlay { RoundedRectangle(cornerRadius: 10).strokeBorder().allowsHitTesting(false) }
            }

            HStack(spacing: 8) {
                ForEach(["By next occasion", "A–Z", "Groups"], id: \.self) { option in
                    Button {
                        selectedFilter = option
                    } label: {
                        Text(option)
                            .font(.caption.weight(.medium))
                            .padding(.horizontal, 10).padding(.vertical, 4)
                            .foregroundStyle(option == selectedFilter ? Color(.systemBackground) : .primary)
                            .background { if option == selectedFilter { Capsule().fill(.primary) } }
                            .overlay { Capsule().strokeBorder(.secondary, lineWidth: 0.6) }
                    }
                    .buttonStyle(.plain)
                }
            }

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(rows) { friend in
                        friendRow(friend)
                    }
                }
            }
        }
        .padding(20)
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Label("Get ideas", systemImage: "sparkles")
                .font(.subheadline.bold()).padding()
                .foregroundStyle(Color(.systemBackground))
                .background(Color.primary, in: Capsule())
                .padding(.trailing, 16).padding(.bottom, 8)
        }
    }

    private func friendRow(_ friend: FriendsModel.Friend) -> some View {
        let days = friend.daysUntilOccasion
        let when = days == 0 ? "today" : days == 1 ? "tomorrow" : days >= 60 ? "in \(days / 30) months" : "in \(days) days"
        return HStack(spacing: 12) {
            Circle().fill(Color(.systemGray5))
                .overlay { Circle().strokeBorder() }
                .frame(width: 46, height: 46)
            VStack(alignment: .leading, spacing: 2) {
                Text(friend.name).font(.headline)
                Text("\(friend.occasion) · \(when)").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer(minLength: 4)
            Text(friend.wishCount.map { "\($0) " + ($0 == 1 ? "wish" : "wishes") } ?? "No list yet")
                .font(.caption)
                .padding(.horizontal, 10).padding(.vertical, 4)
                .overlay {
                    Capsule().strokeBorder(.secondary, style: StrokeStyle(lineWidth: 0.6, dash: friend.wishCount == nil ? [2] : []))
                }
        }
        .padding(14)
        .overlay { RoundedRectangle(cornerRadius: 12).strokeBorder() }
    }
}
