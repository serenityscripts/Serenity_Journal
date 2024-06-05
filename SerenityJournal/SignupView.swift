import SwiftUI
import FirebaseAuth
import FirebaseAnalytics

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Sign Up")
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

            SecureField("Confirm Password", text: $confirmPassword)
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
                signUp()
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
        .onAppear {
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "SignupView",
                                            AnalyticsParameterScreenClass: "SignupView"])
        }
    }

    func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            Analytics.logEvent("signup_failed", parameters: [
                "email": email,
                "error": "Passwords do not match."
            ])
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                Analytics.logEvent("signup_failed", parameters: [
                    "email": email,
                    "error": error.localizedDescription
                ])
                return
            }
            // Handle successful sign up
            Analytics.logEvent("signup_success", parameters: [
                "email": email
            ])
        }
    }
}

