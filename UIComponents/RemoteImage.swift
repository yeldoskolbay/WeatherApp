
import SwiftUI

struct RemoteImage: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .scaledToFit()
            case .failure:
            Image(systemName: "cloud")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
            @unknown default:
            EmptyView()
            }
        }
    }
}
