import Foundation

struct FriendsModel: Decodable {
    var friends: [Friend] = []
    var friendIDs: [Int] { friends.map(\.id) }

    struct Friend: Decodable, Identifiable {
        let id: Int
        let name: String
        let birthMonth: Int
        let birthDay: Int

        enum CodingKeys: String, CodingKey {
            case id, name
            case birthMonth = "birth_month"
            case birthDay = "birth_day"
        }
    }
}
