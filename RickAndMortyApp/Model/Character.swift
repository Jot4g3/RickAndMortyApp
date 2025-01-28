import Foundation

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let image: URL
    let episode: [URL]
    let url: String
}
