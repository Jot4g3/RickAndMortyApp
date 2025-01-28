import SwiftUI
import Foundation

struct CharacterView: View {
        
    let character: Character
    
    //ele comeca opcional, porque assim que carregar a tela ainda nao tem carregado a imagem
    @State var image: UIImage?
    
    var body: some View {
            HStack {
                VStack(alignment: .leading){
                    HStack{
                        Text("Name: ")
                        Link(character.name, destination: URL(string: "https://google.com/search?q=\(character.name)")!)
                    }
                    //Deve-se colocar entre aspas porque o texto deve receber, necessariamente uma string
                    
                    Text("Quantidade de episódios em que aparece: \(character.episode.count)")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                Spacer()
                //Text("\(character.image)")
                if image == nil{
                    //printar o loading
                    ProgressView()
                }else{
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue.gradient, lineWidth: 3)
                        }
                }
            }
        //onAppear() -> Mas nao permite fazer operacoes assincronas. Quando quero executar uma tarefa assincrona, uso o .task
        .task{
            do{
                //para fingir a internet fraca, esperar
//                try await Task.sleep(for: .seconds(.random(in: 1...3)))
                let (data, _) = try await URLSession.shared.data(from: character.image)
                image = UIImage(data:data)
            }catch{
                
            }
        }
    }
    
}
