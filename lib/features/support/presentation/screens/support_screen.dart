import 'package:flutter/material.dart';
import 'package:bebsata/core/theme/app_theme.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi! I'm Bebsata Bot. How can I help you today?",
      isBot: true,
    ),
  ];
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isBot: false));
    });
    _messageController.clear();
    _scrollToBottom();

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(text: _getBotResponse(text), isBot: true));
        });
        _scrollToBottom();
      }
    });
  }

  String _getBotResponse(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('order') || lower.contains('tracking')) {
      return "You can track your orders in 'My Orders' section. Need help with a specific order?";
    } else if (lower.contains('refund') || lower.contains('return')) {
      return "For refunds, please go to My Orders > Select Order > Request Refund. Refunds are processed within 5-7 business days.";
    } else if (lower.contains('payment')) {
      return "We accept Credit/Debit Cards, PayPal, and Cash on Delivery. Is there a payment issue?";
    } else if (lower.contains('delivery') || lower.contains('shipping')) {
      return "Standard delivery takes 3-5 days. Express delivery is available for select items.";
    } else if (lower.contains('hello') || lower.contains('hi')) {
      return "Hello! How can I assist you today?";
    } else {
      return "I understand. Let me connect you with a human agent. Please wait...";
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions
          Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickAction('📦 Orders'),
                  _buildQuickAction('💳 Payment'),
                  _buildQuickAction('🚚 Delivery'),
                  _buildQuickAction('↩️ Returns'),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          // Input Field
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(text),
        onPressed: () {
          _messageController.text = text.substring(3);
          _sendMessage();
        },
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: message.isBot
              ? Theme.of(context).cardColor
              : AppTheme.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isBot ? 4 : 16),
            bottomRight: Radius.circular(message.isBot ? 16 : 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(color: message.isBot ? null : Colors.white),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isBot;

  ChatMessage({required this.text, required this.isBot});
}
