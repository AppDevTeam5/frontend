//
//  ContentView.swift
//  hackchallenge_frontend
//
//  Created by Cory Fan on 11/22/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") { HomeView() }
            Tab("Friends", systemImage: "person.2") {
                FriendsView(friendsModel: NetworkManager.shared.fetchFriends())
            }
            Tab("Celebrate", systemImage: "party.popper") { CelebrateView() }
            Tab("Wishlists", systemImage: "gift") { WishlistsView() }
            Tab("Me", systemImage: "person") { MeView() }
        }
    }
}

#Preview {
    ContentView()
}
