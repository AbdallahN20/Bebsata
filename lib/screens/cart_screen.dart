import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/Glassmorphism.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
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
                  'Your Cart',
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
            child: cart.items.isEmpty

                ? const Center(child: Text('Your cart is empty'))
                : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.network(item.imagepath, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(item.name),
                        subtitle: Text('\$${item.price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => cart.removeItem(item.id),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Total: \$${cart.totalAmount.toStringAsFixed(2)}'),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order placed!')),
                          );
                          cart.clear();
                        },
                        child: const Text('Place Order'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}