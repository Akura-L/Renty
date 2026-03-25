import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String carName;
  final String? bookingRef;
  final String preview;
  final DateTime time;
  final String category; // 'all', 'unread', 'owners', 'support'
  bool isUnread;

  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.carName,
    this.bookingRef,
    required this.preview,
    required this.time,
    required this.category,
    this.isUnread = false,
  });

  bool get isOwners => category == 'owners';
  bool get isSupport => category == 'support';
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
        senderName: 'David M.',
        senderImage: 'https://i.pravatar.cc/150?img=1',
        carName: 'Land Cruiser',
        bookingRef: 'TX001',
        preview: 'Hi, when can I pick up the car?',
        time: DateTime.now().subtract(const Duration(minutes: 2)),
        category: 'owners',
        isUnread: true,
      ),
      Message(
        id: '2',
        senderName: 'Nancy W.',
        senderImage: 'https://i.pravatar.cc/150?img=2',
        carName: 'BMW',
        bookingRef: 'TX002',
        preview: 'Thanks for the smooth handover!',
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: 'owners',
        isUnread: true,
      ),
      Message(
        id: '3',
        senderName: 'Renty Support',
        senderImage: 'https://i.pravatar.cc/150?img=3',
        carName: '',
        bookingRef: null,
        preview: 'How can we help you today?',
        time: DateTime.now().subtract(const Duration(hours: 3)),
        category: 'support',
        isUnread: false,
      ),
      Message(
        id: '4',
        senderName: 'Peter K.',
        senderImage: 'https://i.pravatar.cc/150?img=4',
        carName: 'Corolla',
        bookingRef: 'TX004',
        preview: 'Car ready for pickup tomorrow at 9AM',
        time: DateTime.now().subtract(const Duration(hours: 24)),
        category: 'owners',
        isUnread: false,
      ),
      Message(
        id: '5',
        senderName: 'Michael O.',
        senderImage: 'https://i.pravatar.cc/150?img=5',
        carName: 'Porsche',
        bookingRef: 'TX005',
        preview: 'Thank you for your feedback!',
        time: DateTime.now().subtract(const Duration(days: 3)),
        category: 'owners',
        isUnread: false,
      ),
      Message(
        id: '6',
        senderName: 'David M.',
        senderImage: 'https://i.pravatar.cc/150?img=6',
        carName: 'Land Cruiser',
        bookingRef: 'TX001',
        preview: 'Everything good with the return?',
        time: DateTime.now().subtract(const Duration(days: 4)),
        category: 'owners',
        isUnread: false,
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
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=68'),
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
                    constraints:
                        const BoxConstraints(minWidth: 12, minHeight: 12),
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
      body: Column(
        children: [
          // Active Booking Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.local_activity, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIVE BOOKING',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Land Cruiser TX001 • Nairobi\nOct 15-17 • KSh 12,500',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),
          // Filter Tabs
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.grey,
                  indicatorColor: AppTheme.primary,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Unread'),
                    Tab(text: 'Owners'),
                    Tab(text: 'Support'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildTabView([]), // All
                      _buildTabView(
                          messages.where((m) => m.isUnread).toList()), // Unread
                      _buildTabView(
                          messages.where((m) => m.isOwners).toList()), // Owners
                      _buildTabView(messages
                          .where((m) => m.isSupport)
                          .toList()), // Support
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  String _formatRelativeTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) {
      return 'now';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 2) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return weekdays[time.weekday % 7];
    }
    return '${diff.inDays}d ago';
  }

  Widget _buildTabView(List<Message> filteredMessages) {
    if (filteredMessages.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: AppTheme.grey),
            SizedBox(height: 16),
            Text('No messages', style: TextStyle(fontSize: 18)),
            Text('Check back later', style: TextStyle(color: AppTheme.grey)),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: filteredMessages.length,
      itemBuilder: (context, index) =>
          _buildMessageTileForTab(filteredMessages[index], index),
    );
  }

  Widget _buildMessageTileForTab(Message message, int index) {
    return _buildMessageTile(messages.indexOf(message));
  }

  Widget _buildMessageTile(int index) {
    final message = messages[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(message.senderImage),
            ),
            if (message.isUnread)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          message.senderName,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${message.carName}${message.bookingRef != null ? ' (${message.bookingRef})' : ''}',
              style: TextStyle(
                color: AppTheme.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.preview,
              style: TextStyle(
                color: AppTheme.grey,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatRelativeTime(message.time),
              style: const TextStyle(fontSize: 12, color: AppTheme.grey),
            ),
            if (message.isUnread) ...[
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          if (message.isUnread) {
            setState(() {
              messages[index].isUnread = false;
            });
          }
          // TODO: Navigate to chat screen
        },
      ),
    );
  }
}
