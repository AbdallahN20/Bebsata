import 'package:flutter/material.dart';
import '../models/item.dart';

class CartProvider extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}