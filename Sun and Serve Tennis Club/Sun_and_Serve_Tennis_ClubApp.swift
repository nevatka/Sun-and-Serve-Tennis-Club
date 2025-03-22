import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore


@main
struct Sun_and_Serve_Tennis_ClubApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_application: UIApplication, didFinishLaunchingWithOption launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
        
            return true
    }
}

