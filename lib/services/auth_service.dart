import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream para escuchar cambios en el estado de autenticación (Login/Logout)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuario actual
  User? get currentUser => _auth.currentUser;

  // Registrar nuevo usuario con Email, Contraseña y Nombre de Panadero/Aventurero
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Actualizar el displayName en Firebase Auth
        try {
          await user.updateDisplayName(username.trim());
        } catch (e) {
          developer.log('Error actualizando displayName: $e');
        }

        // Guardar documento del usuario en Firestore (users collection) de forma no bloqueante
        try {
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'username': username.trim(),
            'email': email.trim(),
            'createdAt': FieldValue.serverTimestamp(),
            'favorites': <String>[],
            'role': 'player',
          });
        } catch (e) {
          developer.log('Error guardando en Firestore: $e');
        }
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      developer.log('FirebaseAuthException: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      developer.log('Error general en signUp: $e');
      throw 'Error al registrarte: $e';
    }
  }

  // Iniciar sesión con Email y Contraseña
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      developer.log('FirebaseAuthException en signIn: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      developer.log('Error general en signIn: $e');
      throw 'Error al iniciar sesión: $e';
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Enviar correo de restablecimiento de contraseña (Recuperación)
  Future<void> sendPasswordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      developer.log('FirebaseAuthException en resetPassword: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      developer.log('Error general en resetPassword: $e');
      throw 'Error al enviar el correo de recuperación: $e';
    }
  }

  // Mensajes de error amigables en español
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No existe una cuenta registrada con este correo.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Contraseña o correo incorrectos.';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con este correo electrónico.';
      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres.';
      case 'invalid-email':
        return 'El correo electrónico no tiene un formato válido.';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada temporalmente.';
      case 'too-many-requests':
        return 'Demasiados intentos fallidos. Intenta más tarde.';
      case 'operation-not-allowed':
        return 'El registro con correo y contraseña no está habilitado en Firebase Console.';
      case 'network-request-failed':
        return 'Error de conexión. Revisa el internet de tu teléfono.';
      default:
        return e.message ?? 'Error de autenticación: ${e.code}';
    }
  }
}
