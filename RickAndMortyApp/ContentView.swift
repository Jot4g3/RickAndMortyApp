import SwiftUI

struct ContentView: View {
    
    @State var characters: [Character] = []
        
    var body: some View {
        Text("Veja os personagens de Rick And Morty!")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.accentColor)
            .padding()
        List {
            ForEach(characters){ character in
                CharacterView(character: character)
            }
        }
        .task {
            do {
                let url = URL(string: "https://rickandmortyapi.com/api/character")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
                self.characters = response.results
            } catch {
                print(error)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
