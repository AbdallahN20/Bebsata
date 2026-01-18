import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container( width: item.imagewidth, height: item.imageheight,
        child: Image.asset(
          item.imagepath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          }
        ),
        ),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$${item.price}'),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () => context.read<CartProvider>().addItem(item),
            ),
          ],
        ),
      ),
    );
  }
}