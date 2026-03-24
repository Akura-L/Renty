import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final DateTime time;
  bool isUnread;  // Make mutable

  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.time,
    this.isUnread = false,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late List<Message> messages;

  @override
  void initState() {
    super.initState();
    messages = [
      Message(
        id: '1',
        senderName: 'Toyota Rentals',
        senderImage: 'https://i.pravatar.cc/150?img=1',
        lastMessage: 'Your booking TX123 has been confirmed!',
        time: DateTime(2024, 10, 10, 12, 0),  // Fixed time
        isUnread: true,
      ),
      Message(
        id: '2',
        senderName: 'Range Rover Team',
        senderImage: 'https://i.pravatar.cc/150?img=2',
        lastMessage: 'Payment received. Enjoy your drive!',
        time: DateTime(2024, 10, 10, 9, 0),
      ),
      Message(
        id: '3',
        senderName: 'Customer Support',
        senderImage: 'https://i.pravatar.cc/150?img=3',
        lastMessage: "How can we help you today?",
        time: DateTime(2024, 10, 9, 14, 0),
        isUnread: true,
      ),
      Message(
        id: '4',
        senderName: 'Mercedes-Benz',
        senderImage: 'https://i.pravatar.cc/150?img=4',
        lastMessage: 'Car ready for pickup tomorrow at 9AM',
        time: DateTime(2024, 10, 8, 16, 0),
      ),
      Message(
        id: '5',
        senderName: 'Audi Service',
        senderImage: 'https://i.pravatar.cc/150?img=5',
        lastMessage: 'Thank you for your feedback!',
        time: DateTime(2024, 10, 7, 11, 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = messages.where((m) => m.isUnread).length;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=68'),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: messages.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        size: 80, color: AppTheme.grey),
                    SizedBox(height: 16),
                    Text('No messages yet', style: TextStyle(fontSize: 18)),
                    Text('Messages appear here',
                        style: TextStyle(color: AppTheme.grey)),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => _buildMessageTile(index),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildMessageTile(int index) {
    final message = messages[index];
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(message.senderImage),
          ),
          if (message.isUnread)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        message.senderName,
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(message.lastMessage),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 12, color: AppTheme.grey),
          ),
          if (message.isUnread) const SizedBox(height: 4),
          if (message.isUnread)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        // Open chat and mark as read
        if (message.isUnread) {
          setState(() {
            messages[index].isUnread = false;
          });
        }
      },
    );
  }
}
