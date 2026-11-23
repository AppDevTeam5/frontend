import Foundation

struct FriendsModel: Decodable {
    var friends: [Friend] = []
    var friendIDs: [Int] { friends.map(\.id) }

    struct Friend: Decodable, Identifiable {
        let id: Int
        let name: String
        let birthMonth: Int
        let birthDay: Int
        // Optional display details supplied by the mock feed.
        var occasion = "Birthday"
        var occasionDate: Date?
        var wishCount: Int?
        var isGroup = false

        var daysUntilOccasion: Int {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let birthday = DateComponents(month: birthMonth, day: birthDay)
            let nextDate = occasionDate ?? calendar.nextDate(
                after: today.addingTimeInterval(-1), matching: birthday, matchingPolicy: .nextTime
            ) ?? today
            return calendar.dateComponents([.day], from: today, to: calendar.startOfDay(for: nextDate)).day ?? 0
        }

        enum CodingKeys: String, CodingKey {
            case id, name
            case birthMonth = "birth_month"
            case birthDay = "birth_day"
        }
    }
}
