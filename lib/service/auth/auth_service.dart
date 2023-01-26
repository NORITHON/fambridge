import 'firebase_auth_provider.dart';
import 'auth_provider.dart';
import '../../model/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  factory AuthService.mockTesting(AuthProvider p) => AuthService(p);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn() =>
      provider.logIn();

  @override
  Future<void> logOut() => provider.logOut();

  @override
  String? userDisplayName() => provider.userDisplayName();
  
  @override
  Future<void> initialize() => provider.initialize();
}
