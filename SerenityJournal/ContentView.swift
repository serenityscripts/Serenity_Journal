import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseAnalytics

struct ContentView: View {
    @State private var email: String = ""
    @State private var dateOfBirth: String = ""
    @State private var astrologySign: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Date of Birth", text: $dateOfBirth)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Astrology Sign", text: $astrologySign)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                signUp()
                Analytics.logEvent("sign_up", parameters: [
                    "email": email,
                    "date_of_birth": dateOfBirth,
                    "astrology_sign": astrologySign
                ])
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "SignUpScreen",
                                            AnalyticsParameterScreenClass: "ContentView"])
        }
    }

    func signUp() {
        guard !email.isEmpty, !dateOfBirth.isEmpty, !astrologySign.isEmpty else {
            // Show an alert that all fields are required
            return
        }

        Auth.auth().createUser(withEmail: email, password: "defaultPassword") { authResult, error in
            if let error = error {
                // Handle error
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            
            // User created successfully, now save additional info
            saveUserInfo(email: email, dob: dateOfBirth, astrologySign: astrologySign)
        }
    }

    func saveUserInfo(email: String, dob: String, astrologySign: String) {
        let db = Firestore.firestore()
        db.collection("users").document(email).setData([
            "date_of_birth": dob,
            "astrology_sign": astrologySign
        ]) { error in
            if let error = error {
                // Handle error
                print("Error saving user info: \(error.localizedDescription)")
            } else {
                // Show success message
                print("User info saved successfully")
            }
        }
    }
}

