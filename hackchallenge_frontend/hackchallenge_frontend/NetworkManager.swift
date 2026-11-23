import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchFriends() -> FriendsModel {
        func date(in days: Int) -> Date? {
            Calendar.current.date(byAdding: .day, value: days, to: Date())
        }
        return FriendsModel(friends: [
            .init(id: 2, name: "Maya Chen", birthMonth: 11, birthDay: 28, occasionDate: date(in: 6), wishCount: 8),
            .init(id: 3, name: "Sam & Jo", birthMonth: 3, birthDay: 14, occasion: "Anniversary", occasionDate: date(in: 12), wishCount: 3, isGroup: true),
            .init(id: 4, name: "Leo Park", birthMonth: 12, birthDay: 15, occasionDate: date(in: 23), wishCount: 5),
            .init(id: 5, name: "Priya Shah", birthMonth: 7, birthDay: 8, occasion: "Graduation", occasionDate: date(in: 41), wishCount: 12),
            .init(id: 6, name: "Dan Okafor", birthMonth: 1, birthDay: 22, occasionDate: date(in: 60))
        ])
    }

    func fetchWishlist() -> WishlistModel {
        WishlistModel(items: [
            .init(id: 1, name: "Instant camera", url: "https://example.com/camera",
                  price: 79.99, note: "White", claim: nil),
            .init(id: 2, name: "Matcha bowl", url: nil,
                  price: 25, note: nil, claim: nil)
        ])
    }
}
