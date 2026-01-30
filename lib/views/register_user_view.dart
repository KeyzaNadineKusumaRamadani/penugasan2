import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List roleChoice = ["admin", "kasir"];
  String? role;

   final Color primaryColor = Color(0xFF9C27B0);
  final Color secondaryColor = Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /// BACKGROUND GRADIENT
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
            child: Column(
              children: [
                /// HEADER GRADIENT
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.storefront,
                          color: Colors.white, size: 60),
                      SizedBox(height: 10),
                      Text(
                        "Toko Online",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Buat akun baru untuk mulai belanja",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),

                            /// NAME
                            TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: "Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama harus diisi';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 14),

                            /// EMAIL
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email harus diisi';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 14),

                            /// ROLE
                            DropdownButtonFormField(
                              value: role,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: "Role",
                                prefixIcon: Icon(
                                  Icons.security,
                                  color: primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              items: roleChoice.map((r) {
                                return DropdownMenuItem(
                                  value: r,
                                  child: Text(r),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  role = value.toString();
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Role harus dipilih';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 14),

                            /// PASSWORD
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password harus diisi';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            /// BUTTON GRADIENT
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    var data = {
                                      "name": name.text,
                                      "email": email.text,
                                      "role": role,
                                      "password": password.text,
                                    };

                                    var result =
                                        await user.registerUser(data);

                                    if (result.status == true) {
                                      name.clear();
                                      email.clear();
                                      password.clear();
                                      setState(() {
                                        role = null;
                                      });

                                      AlertMessage().showAlert(
                                        context,
                                        result.message,
                                        true,
                                      );
                                    } else {
                                      AlertMessage().showAlert(
                                        context,
                                        result.message,
                                        false,
                                      );
                                    }

                                    Future.delayed(
                                        const Duration(seconds: 2), () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/login',
                                      );
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Daftar Sekarang",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
