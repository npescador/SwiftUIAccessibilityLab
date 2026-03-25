import Foundation
import Observation

@MainActor
@Observable
/// Manages a simple shopping cart with items and quantities.
final class QuantityControlViewModel {
    struct CartItem: Identifiable, Equatable {
        let id: UUID
        let name: String
        let emoji: String
        var quantity: Int

        init(id: UUID = UUID(), name: String, emoji: String, quantity: Int = 1) {
            self.id = id
            self.name = name
            self.emoji = emoji
            self.quantity = quantity
        }
    }

    private let announcer: any AccessibilityAnnouncing

    var items: [CartItem]

    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    init(announcer: any AccessibilityAnnouncing = SystemAccessibilityAnnouncer()) {
        self.announcer = announcer
        self.items = [
            CartItem(name: "Wireless Headphones", emoji: "🎧"),
            CartItem(name: "Laptop Stand", emoji: "💻"),
            CartItem(name: "Mechanical Keyboard", emoji: "⌨️"),
        ]
    }

    func increment(_ item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }),
              items[index].quantity < 99 else { return }
        items[index].quantity += 1
        announcer.announce("\(items[index].name), \(items[index].quantity)")
    }

    func decrement(_ item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }),
              items[index].quantity > 0 else { return }
        items[index].quantity -= 1
        announcer.announce("\(items[index].name), \(items[index].quantity)")
    }

    func setQuantity(_ quantity: Int, for item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        let clamped = max(0, min(99, quantity))
        items[index].quantity = clamped
        announcer.announce("\(items[index].name), \(clamped)")
    }
}
