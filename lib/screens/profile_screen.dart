import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/Glassmorphism.dart';
import 'splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(

            backgroundColor: Colors.transparent,
            elevation: 0,

            toolbarHeight: 160,

            flexibleSpace: GlassContainer(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
              blur: 10,
              child: Container(),
            ),

            centerTitle: true,

            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text(
                  'Your Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'times new roman',
                  ),
                ),
              ],
            ),
          ),

          body:

          Container(
            color: const Color(0xFF673DA0),
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(user.name[0], style: const TextStyle(fontSize: 40)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                      fontFamily: 'times new roman',),
                    decoration: const InputDecoration(labelText: 'Name'),
                    controller: TextEditingController(text: user.name),
                    onChanged: (value) => user.updateProfile(value, user.email, user.phone),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                      fontFamily: 'times new roman',),
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) => user.updateProfile(user.name, value, user.phone),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                      fontFamily: 'times new roman',),
                    decoration: const InputDecoration(labelText: 'Phone'),
                    controller: TextEditingController(text: user.phone),
                    onChanged: (value) => user.updateProfile(user.name, user.email, value),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      onTap : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SplashScreen()),
                        );
                      };
                      // Simulate logout (integrate with auth)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')),
                      );
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}