import Foundation

struct WishlistModel: Decodable {
    var items: [Item] = []

    struct Item: Decodable, Identifiable {
        let id: Int
        let name: String
        let url: String?
        let price: Decimal?
        let note: String?
        let claim: String?
    }
}
