import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
} 

class _LoginViewState extends State<LoginView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool showPass = true;

  final Color primaryColor = Color(0xFF9C27B0);
  final Color secondaryColor = Color(0xFF673AB7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// BACKGROUND GRADIENT
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(0.9),
              secondaryColor.withOpacity(0.6),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    /// ICON
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: primaryColor.withOpacity(0.15),
                      child: Icon(
                        Icons.storefront,
                        size: 45,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// TITLE
                    Text(
                      "Login Toko Online",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          /// EMAIL
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon:
                                  Icon(Icons.email, color: primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email harus diisi';
                              } else {
                                return null;
                              }
                            },
                          ),

                          const SizedBox(height: 16),

                          /// PASSWORD
                          TextFormField(
                            controller: password,
                            obscureText: showPass,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon:
                                  Icon(Icons.lock, color: primaryColor),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                                icon: Icon(
                                  showPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password harus diisi';
                              } else {
                                return null;
                              }
                            },
                          ),

                          const SizedBox(height: 25),

                          /// BUTTON LOGIN (GRADIENT)
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var data = {
                                    "email": email.text,
                                    "password": password.text,
                                  };
                                  var result =
                                      await user.loginUser(data);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (result.status == true) {
                                    AlertMessage().showAlert(
                                      context,
                                      result.message,
                                      true,
                                    );
                                    Future.delayed(
                                        const Duration(seconds: 2), () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/dashboard',
                                      );
                                    });
                                  } else {
                                    AlertMessage().showAlert(
                                      context,
                                      result.message,
                                      false,
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor,
                                      secondaryColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: isLoading == false
                                      ? const Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
