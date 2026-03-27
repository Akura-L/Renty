import 'package:flutter/material.dart';

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
        senderImage: 'assets/images/image.png',
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
        senderImage: 'assets/images/image.png',
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
        senderImage: 'assets/images/image.png',
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
        senderImage: 'assets/images/image.png',
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
        senderImage: 'assets/images/image.png',
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
        senderImage: 'assets/images/image.png',
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
        title: const Text('Messages'),
        actions: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/image.png'),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: RentyColors.error,
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
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: RentyColors.primary,
              borderRadius: BorderRadius.circular(RentyRadius.lg),
            ),
            child: const Row(
              children: [
                Icon(Icons.local_activity, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIVE BOOKING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        'Land Cruiser TX001 • Nairobi\nOct 15-17 • KSh 12,500',
                        style: TextStyle(
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
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Unread'),
                      Tab(text: 'Owners'),
                      Tab(text: 'Support'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTabView(messages), // All
                        _buildTabView(messages
                            .where((m) => m.isUnread)
                            .toList()), // Unread
                        _buildTabView(messages
                            .where((m) => m.isOwners)
                            .toList()), // Owners
                        _buildTabView(messages
                            .where((m) => m.isSupport)
                            .toList()), // Support
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
            Icon(Icons.inbox_outlined,
                size: 80, color: RentyColors.textDisabled),
            SizedBox(height: 16),
            Text('No messages', style: TextStyle(fontSize: 18)),
            Text('Check back later',
                style: TextStyle(color: RentyColors.textDisabled)),
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
              backgroundImage: const AssetImage('assets/images/image.png'),
            ),
            if (message.isUnread)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: RentyColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          message.senderName,
          style: RentyTextStyles.headingS,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${message.carName}${message.bookingRef != null ? ' (${message.bookingRef})' : ''}',
              style: RentyTextStyles.bodyS
                  .copyWith(color: RentyColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              message.preview,
              style: RentyTextStyles.bodyS
                  .copyWith(color: RentyColors.textSecondary),
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
              style: RentyTextStyles.caption,
            ),
            if (message.isUnread) ...[
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: RentyColors.primary,
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
