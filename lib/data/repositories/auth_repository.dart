import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get usuarioAtual => _firebaseAuth.currentUser;

  Stream<User?> get estadoAutenticacao => _firebaseAuth.authStateChanges();

  Future<void> login({required String email, required String senha}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<void> cadastrar({required String email, required String senha}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<void> recuperarSenha(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
