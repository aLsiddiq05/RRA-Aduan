import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rra_mobile/page/homepage.dart';
import 'package:rra_mobile/services/loginservice.dart';
import 'forgotPassword.dart';
import 'registerAccount.dart';
// import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Add listeners to clear error messages when the user types
    _idController.addListener(() {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {});
      }
    });
    _passwordController.addListener(() {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {});
      }
    });
  }

//api intergration login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final username = _idController.text;
      final password = _passwordController.text;
      final loginService = LoginService();

      final result = await loginService.login(username, password);

      setState(() {
        _isLoading = false;
      });

      if (result != null) {
        final roleId  = await storage.read(key: 'roleId');
        if (roleId == '3' || roleId == '1') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Log Masuk Berjaya')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  // Custom input decoration for form fields
  InputDecoration customInputDecoration({
    required String label,
    required Icon prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.transparent,
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }

  // Custom box decoration for form field containers
  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 8),
        ),
      ],
    );
  }

//   void _login() {
//   if (_formKey.currentState!.validate()) {
//     setState(() {
//       _isLoading = true;
//       login(_idController.text, _passwordController.text);
//     });

//     // login(_idController.text, _passwordController.text);
//   }
// }

  // Widget for text form field
  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required Icon prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    required String validationMessage,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(15.0),
        dashPattern: const [5, 3],
        color: Colors.grey,
        child: Container(
          width: 350,
          decoration: customBoxDecoration(),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: customInputDecoration(
              label: label,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return validationMessage; // Validate the input
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset('assets/Logo.jpg', width: 250, height: 180),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode
                        .onUserInteraction, // Set autovalidateMode
                    child: Column(
                      children: <Widget>[
                        buildTextFormField(
                          controller: _idController,
                          label: 'Email Pengguna',
                          prefixIcon: const Icon(Icons.person),
                          // keyboardType: TextInputType.number,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          // ],
                          validationMessage:
                              'Sila isi ID anda pada ruang yang disediakan',
                        ),
                        buildTextFormField(
                          controller: _passwordController,
                          label: 'Kata Laluan',
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validationMessage:
                              'Sila isi Password anda pada ruang yang disediakan',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Log Masuk'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'Lupa Kata Laluan?',
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterAccountPage()),
                      );
                    },
                    child: Text(
                      'Daftar Akaun Baru!',
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
