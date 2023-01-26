import '../presentation/login/login.dart';
import '../presentation/todo/todo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());

    ever(user, _setInitialScreen);
  }

  //초기 페이지 라우팅
  _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => LoginView());
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      print(e.message);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
