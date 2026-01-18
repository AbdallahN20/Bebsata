import 'package:flutter/material.dart';
import '../providers/home_content.dart';
import '../widgets/Glassmorphism.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
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
              'Bebsata',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'times new roman',
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food...',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        color: const Color(0xFF673DA0),

        child: const HomeContent(),
      ),

     );
   }
}