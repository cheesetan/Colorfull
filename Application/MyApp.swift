import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(red: 18/255, green: 18/255, blue: 18/255).ignoresSafeArea()
                ContentView()
            }
        }
    }
}
