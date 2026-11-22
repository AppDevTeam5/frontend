import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchFriends() -> FriendsModel {
        FriendsModel(friends: [
            .init(id: 2, name: "Mia", birthMonth: 3, birthDay: 14),
            .init(id: 3, name: "Leo", birthMonth: 7, birthDay: 8)
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
