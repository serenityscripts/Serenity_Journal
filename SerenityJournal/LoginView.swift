import SwiftUI
import FirebaseAuth
import FirebaseAnalytics

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var showingSignup = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("camera_image") // Replace with the name of your image asset
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .clipped()
                    .padding(.top, 50)

                VStack(spacing: 20) {
                    Text("Log in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: {
                        signIn()
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)

                    Button(action: {
                        // Handle forgot password
                    }) {
                        Text("Forget Password?")
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }

                    Button(action: {
                        showingSignup = true
                    }) {
                        Text("Signup")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    .padding(.top, 10)
                    .navigationDestination(isPresented: $showingSignup) {
                        SignupView()
                    }
                }
                .padding()
                Spacer()
            }
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
        }
        .onAppear {
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "LoginView",
                                            AnalyticsParameterScreenClass: "LoginView"])
        }
    }

    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                Analytics.logEvent("login_failed", parameters: [
                    "email": email,
                    "error": error.localizedDescription
                ])
                return
            }
            // Handle successful sign in
            Analytics.logEvent("login_success", parameters: [
                "email": email
            ])
        }
    }
}

