import SwiftUI

struct DataChartExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .dataChart,
            metadata: DataChartExampleMetadata.value,
            accessibleView: { DataChartView_Accessible() },
            inaccessibleView: { DataChartView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        DataChartExampleContainer()
    }
}
