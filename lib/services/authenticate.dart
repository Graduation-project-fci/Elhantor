import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedart/auth/client.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  //register with email and password
  Future<void> register(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

//register with google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  late final FirebaseAuth mAuth = FirebaseAuth.instance;
  //login with email and password
  Future<void> LoginWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  FirebaseAuth? _auth;
  //return current User
  List getCurrentUser()  {
    final User? user = mAuth.currentUser;

    final x = (user!.providerData.toList());
    return x;
  }
  //send verfication email
  Future<void> verifyEmail()async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance.setLanguageCode("en");
    await user?.sendEmailVerification();
  }
  //reset password 
  Future<void>resetPassword(String email)async{
    await FirebaseAuth.instance
    .sendPasswordResetEmail(email: email);

  }
  //sign out 
  Future<void>signout()async{
    await FirebaseAuth.instance.signOut();
  }

}
