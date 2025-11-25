import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widget/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.favorite_border_outlined)),
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.more_vert)),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ------------------ User Image ------------------
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),

            const SizedBox(height: 15),

            // ------------------ Display Name ------------------
            Text(
              user?.displayName ?? "No Name",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // ------------------ Email ------------------
            Text(
              user?.email ?? "No Email",
              style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,),
            ),

            const SizedBox(height: 10),

            const Text(
              "Flutter Developer",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // ------------------ Poke Button ------------------
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6A77),
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {},
              child: const Text("POKE ME"),
            ),

            const SizedBox(height: 80),

            // ------------------ Social Buttons ------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                socialButton(
                  icon: Icons.access_alarm,
                  label: "Todo Cubit",
                  onTap: () => Navigator.pushNamed(context, '/todo'),
                ),
                socialButton(
                  icon: Icons.adb,
                  label: "Todo Provider",
                  onTap: () => Navigator.pushNamed(context, '/todoprovider'),
                ),
                socialButton(
                  icon: Icons.sports_basketball,
                  label: "Todo Getx",
                  onTap: () => Navigator.pushNamed(context, '/todogetx'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ---------- Reusable Social Button ----------
  Widget socialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFAF6929B),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        // const Text(
        //   "Followers",
        //   style: TextStyle(fontSize: 12, color: Colors.grey),
        // )
      ],
    );
  }
}
