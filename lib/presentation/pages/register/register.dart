import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/utilities/show_error_dialog.dart';
import 'package:fambridge/service/auth/auth_exceptions.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late bool _obscureText;

  @override
  void initState() {
    //automatically called when homepage is created
    _email = TextEditingController();
    _password = TextEditingController();
    _obscureText = true;
    super.initState();
  }

  @override
  void dispose() {
    //automatically called when homepage is disposed
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: 'Email', hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: _obscureText,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
              onPressed: _toggle, child: Text(_obscureText ? "Show" : "Hide")),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase()
                    .createUser(email: email, password: password);
                await AuthService.firebase().sendEmailVerification();
                await Get.toNamed(Routes.verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email is already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid email entered');
              } on GenericAuthException {
                await showErrorDialog(context, "Failed to register");
              } catch (e) {
                await showErrorDialog(
                    context, "unknown error occured \nerror message: $e");
              }
            },
            child: const Text('register'),
          ),
          TextButton(
              onPressed: () async {
                await Get.offNamedUntil(Routes.loginRoute, (route) => false);
              },
              child: const Text('Already registered? Click here to login!'))
        ],
      ),
    );
  }
}
