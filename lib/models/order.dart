import 'item.dart';

class Order {
  final String id;
  final List<Item> items;
  final double total;
  final DateTime date;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
  });
}