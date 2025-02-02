import SwiftUI
import Firebase

@main
struct Sun_and_Serve_Tennis_ClubApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
        print("FirebaseApp configured()")
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

