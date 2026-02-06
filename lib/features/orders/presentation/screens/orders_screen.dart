import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock orders data
    final orders = [
      Order(
        id: 'ORD-001',
        date: 'Feb 5, 2026',
        status: OrderStatus.delivered,
        total: 299.99,
        items: 3,
      ),
      Order(
        id: 'ORD-002',
        date: 'Feb 3, 2026',
        status: OrderStatus.shipping,
        total: 149.50,
        items: 2,
      ),
      Order(
        id: 'ORD-003',
        date: 'Jan 28, 2026',
        status: OrderStatus.processing,
        total: 89.00,
        items: 1,
      ),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: TabBar(
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.primaryColor,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Active Orders
            _buildOrderList(
              context,
              orders
                  .where(
                    (o) =>
                        o.status != OrderStatus.delivered &&
                        o.status != OrderStatus.cancelled,
                  )
                  .toList(),
            ),
            // Completed Orders
            _buildOrderList(
              context,
              orders.where((o) => o.status == OrderStatus.delivered).toList(),
            ),
            // Cancelled Orders
            _buildOrderList(
              context,
              orders.where((o) => o.status == OrderStatus.cancelled).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: AppTheme.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No orders here',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(context, order);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(order.date, style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Text(
                  '${order.items} items',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Details'),
                  ),
                ),
                const SizedBox(width: 12),
                if (order.status == OrderStatus.shipping)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Track'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;

    switch (status) {
      case OrderStatus.processing:
        color = AppTheme.warningColor;
        text = 'Processing';
        break;
      case OrderStatus.shipping:
        color = AppTheme.accentColor;
        text = 'Shipping';
        break;
      case OrderStatus.delivered:
        color = AppTheme.successColor;
        text = 'Delivered';
        break;
      case OrderStatus.cancelled:
        color = AppTheme.errorColor;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum OrderStatus { processing, shipping, delivered, cancelled }

class Order {
  final String id;
  final String date;
  final OrderStatus status;
  final double total;
  final int items;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });
}
