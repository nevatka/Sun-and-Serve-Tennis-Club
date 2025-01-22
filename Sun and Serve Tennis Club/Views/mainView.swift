import SwiftUI
import UIKit

struct mainView: View {
    init() {
        let appear = UINavigationBarAppearance()
        let atters: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Allura-Regular", size: 30)!,
            .foregroundColor: UIColor.accent
        ]
        appear.largeTitleTextAttributes = atters
        appear.titleTextAttributes = atters
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
     }
    
    
    var body: some View {
        let images = ["book", "account"]
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Image("intro")
                        .resizable()
                        .scaledToFit()
                    
                    
                    Text("At Sun and Serve Tennis Club, we’re all about enjoying tennis and having fun in the heart of beautiful Malibu! Whether you’re a seasoned player or just picking up a racket for the first time, we’ve got something for everyone. With great courts, friendly coaching, and a welcoming community, it’s the perfect place to play, learn, and connect. Come for the game, stay for the good vibes, and let’s serve up some fun together!")
                        .multilineTextAlignment(.center)
                        .padding(.all, 40.0)
                        .font(.custom("PTSerif-Regular", size: 20))
                        .foregroundStyle(Color.accentColor)
                    
                    
                    ForEach(images, id: \.self) {image in
                        VStack {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                            
                            
                        }
                    }
                }
            }
            .navigationTitle("Sun & Serve Tennis Club")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    mainView()
}
