import SwiftUI
import UIKit

struct MainView: View {
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
        TabView {
            MainPageView()  // Main Page content
                .tabItem {
                    Label("Main Page", systemImage: "tennis.racket")
                }


            OpeningHoursView()  // Opening Hours content
                .tabItem {
                    Label("Opening hours", systemImage: "clock")
                }

            LoginPageView()  // Login Page content
                .tabItem {
                    Label("Log In", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainView()
}
