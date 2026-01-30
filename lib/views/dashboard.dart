import 'package:flutter/material.dart';
import 'package:toko_online/models/userlogin.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;

  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// BACKGROUND GRADIENT
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEDE7F6),
              Color(0xFFF3E5F5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          /// APPBAR GRADIENT
          appBar: AppBar(
            title: const Text("Dashboard"),
            centerTitle: true,
            foregroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF9C27B0),
                    Color(0xFF673AB7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),

          /// BODY
          body: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Colors.white,
                    Color(0xFFF3E5F5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// AVATAR
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFBA68C8),
                          Color(0xFF7E57C2),
                        ],
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// JUDUL
                  const Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF673AB7),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// NAMA USER
                  Text(
                    nama ?? "-",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// ROLE USER (CHIP GRADIENT)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFCE93D8),
                          Color(0xFFB39DDB),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      role ?? "-",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DESKRIPSI
                  Text(
                    "Selamat Datang $nama\nRole Anda: $role",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BOTTOM NAV
          bottomNavigationBar: BottomNav(0),
        ),
      ),
    );
  }
}
