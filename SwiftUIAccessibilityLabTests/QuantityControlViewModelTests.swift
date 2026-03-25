import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("QuantityControlViewModel")
struct QuantityControlViewModelTests {

    @Test("Increment increases quantity and announces")
    func increment() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = QuantityControlViewModel(announcer: announcer)
        let item = viewModel.items[0]

        viewModel.increment(item)

        #expect(viewModel.items[0].quantity == 2)
        #expect(announcer.messages == ["\(item.name), 2"])
    }

    @Test("Decrement decreases quantity and announces")
    func decrement() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = QuantityControlViewModel(announcer: announcer)
        let item = viewModel.items[0]

        viewModel.decrement(item)

        #expect(viewModel.items[0].quantity == 0)
        #expect(announcer.messages == ["\(item.name), 0"])
    }

    @Test("Quantity floor is 0 — no announcement when already at 0")
    func decrementFloor() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = QuantityControlViewModel(announcer: announcer)
        viewModel.items[0].quantity = 0
        let item = viewModel.items[0]

        viewModel.decrement(item)

        #expect(viewModel.items[0].quantity == 0)
        #expect(announcer.messages.isEmpty)
    }

    @Test("Quantity ceiling is 99 — no announcement when already at 99")
    func incrementCeiling() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = QuantityControlViewModel(announcer: announcer)
        viewModel.items[0].quantity = 99
        let item = viewModel.items[0]

        viewModel.increment(item)

        #expect(viewModel.items[0].quantity == 99)
        #expect(announcer.messages.isEmpty)
    }

    @Test("setQuantity clamps value above 99 to 99")
    func setQuantityClampHigh() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = QuantityControlViewModel(announcer: announcer)
        let item = viewModel.items[0]

        viewModel.setQuantity(200, for: item)

        #expect(viewModel.items[0].quantity == 99)
        #expect(announcer.messages == ["\(item.name), 99"])
    }

    @Test("setQuantity clamps value below 0 to 0")
    func setQuantityClampLow() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = QuantityControlViewModel(announcer: announcer)
        let item = viewModel.items[0]

        viewModel.setQuantity(-5, for: item)

        #expect(viewModel.items[0].quantity == 0)
        #expect(announcer.messages == ["\(item.name), 0"])
    }

    @Test("totalItems sums all quantities")
    func totalItems() {
        let viewModel = QuantityControlViewModel(announcer: TestAccessibilityAnnouncer())

        // Default: 3 items each with quantity 1
        #expect(viewModel.totalItems == 3)

        let item = viewModel.items[0]
        viewModel.increment(item)

        #expect(viewModel.totalItems == 4)
    }

    @Test("Default cart has 3 items")
    func defaultItems() {
        let viewModel = QuantityControlViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.items.count == 3)
        #expect(viewModel.items.allSatisfy { $0.quantity == 1 })
    }
}
