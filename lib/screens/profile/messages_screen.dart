import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final DateTime time;
  final bool isUnread;

  const Message({
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
  final List<Message> messages = [
    const Message(
      id: '1',
      senderName: 'Toyota Rentals',
      senderImage: 'https://i.pravatar.cc/150?img=1',
      lastMessage: 'Your booking TX123 has been confirmed!',
      time: DateTime.now().subtract(Duration(hours: 2)),
      isUnread: true,
    ),
    const Message(
      id: '2',
      senderName: 'Range Rover Team',
      senderImage: 'https://i.pravatar.cc/150?img=2',
      lastMessage: 'Payment received. Enjoy your drive!',
      time: DateTime.now().subtract(Duration(hours: 5)),
    ),
    const Message(
      id: '3',
      senderName: 'Customer Support',
      senderImage: 'https://i.pravatar.cc/150?img=3',
      lastMessage: "How can we help you today?",
      time: DateTime.now().subtract(Duration(days: 1)),
      isUnread: true,
    ),
    const Message(
      id: '4',
      senderName: 'Mercedes-Benz',
      senderImage: 'https://i.pravatar.cc/150?img=4',
      lastMessage: 'Car ready for pickup tomorrow at 9AM',
      time: DateTime.now().subtract(Duration(days: 2)),
    ),
    const Message(
      id: '5',
      senderName: 'Audi Service',
      senderImage: 'https://i.pravatar.cc/150?img=5',
      lastMessage: 'Thank you for your feedback!',
      time: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=68'),
              ),
              if (messages.where((m) => m.isUnread).isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    constraints:
                        const BoxConstraints(minWidth: 12, minHeight: 12),
                    child: Text(
                      '${messages.where((m) => m.isUnread).length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
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
                itemBuilder: (context, i) => _buildMessageTile(messages[i]),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildMessageTile(Message message) {
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
                    color: Colors.green, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
      title: Text(message.senderName,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
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
                  color: Colors.blue, shape: BoxShape.circle),
            ),
        ],
      ),
      onTap: () {
        // Open chat
        if (message.isUnread) {
          setState(() => messages[i] = Message(
                id: message.id,
                senderName: message.senderName,
                senderImage: message.senderImage,
                lastMessage: message.lastMessage,
                time: message.time,
                isUnread: false,
              ));
        }
      },
    );
  }
}
