import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'cart_provider.dart';


class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> sampleItems = [
      Item(id: '1', name: 'Pizza Margherita', description: 'Classic cheese pizza', price: 12.99, imagepath: 'assets/images/pizza marg.jpeg',imageheight: 60,imagewidth: 60),
      Item(id: '2', name: 'Burger', description: 'Beef burger with fries', price: 8.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '3', name: 'Sushi Roll', description: 'Fresh salmon roll', price: 15.50, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
      Item(id: '4', name: 'Salad', description: 'Caesar salad bowl', price: 9.99, imagepath: 'https://via.placeholder.com/150',imageheight: 60,imagewidth: 60),
    ];

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(

                itemCount: sampleItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(item: sampleItems[index]);
                },
              ),
            ),
            if (cart.items.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                  child: Text('View Cart (${cart.items.length} items)'),
                ),
              ),
          ],
        );
      },
    );
  }
}