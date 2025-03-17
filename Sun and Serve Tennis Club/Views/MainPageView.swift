import SwiftUI

struct MainPageView: View {
    @State private var showSheet: Bool = false
//    @State private var isLoggedIn: Bool = false
    @EnvironmentObject var viewModel: LoginViewViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ImageView(imageName: "intro")
                    Text("At Sun and Serve Tennis Club, we’re all about enjoying tennis and having fun in the heart of beautiful Malibu! Whether you’re a seasoned player or just picking up a racket for the first time, we’ve got something for everyone. With great courts, friendly coaching, and a welcoming community, it’s the perfect place to play, learn, and connect. Come for the game, stay for the good vibes, and let’s serve up some fun together!")
                        .multilineTextAlignment(.center)
                        .padding(.all, 40.0)
                        .font(.custom("PTSerif-Regular", size: 20))
                        .foregroundStyle(Color.accentColor)
                    
                    if viewModel.isLoggedIn {
                        
                        // Show Reservation Button if Logged In
                        Button {
                            showSheet = true
                        } label: {
                            ImageView(imageName: "reservation")
                        }
                        .sheet(isPresented: $showSheet) {
                            ReservationView(isPresented: $showSheet)
                                .presentationDetents([.large, .medium, .fraction(0.5)])
                        }
                    } else {
                        // Show Account Navigation if NOT Logged In
                        NavigationLink(destination: RegisterView()) {
                            ImageView(imageName: "account")
                        }
                    }
                
                }
            }
            .navigationTitle("Sun & Serve Tennis Club")
            .navigationBarTitleDisplayMode(.inline)
        }
//        .onAppear {
//            viewModel.checkLoginStatus()
//        }
    }
    
}
