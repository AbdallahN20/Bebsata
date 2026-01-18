import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/home_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/Glassmorphism.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      extendBody: true,

      bottomNavigationBar: GlassContainer(
        width: double.infinity,
        height: 85,
        borderRadius: 0,
        blur: 10,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}