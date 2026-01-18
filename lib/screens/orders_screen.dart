import 'package:flutter/material.dart';
import '../models/order.dart';
import '../widgets/Glassmorphism.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Order> sampleOrders = [
      Order(id: '1', items: [], total: 25.48, date: DateTime.now().subtract(const Duration(hours: 2))),
      Order(id: '2', items: [], total: 18.99, date: DateTime.now().subtract(const Duration(days: 1))),
    ];

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
              'Your Orders',
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
        padding: EdgeInsets.only(top: 172),

        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: sampleOrders.length,
          itemBuilder: (context, index) {
            final order = sampleOrders[index];
            return Card(
              child: ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Text('Total: \$${order.total} | ${order.date.toString().split(' ')[0]}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Order details for #${order.id}')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}