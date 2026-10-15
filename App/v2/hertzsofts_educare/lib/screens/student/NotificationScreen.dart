import 'package:flutter/material.dart';
import 'package:hertzsofts_educare/core/theme.dart';

// Notification Model
class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color iconBackgroundColor;
  bool isRead;
  bool isSelected;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.icon = Icons.person_outline,
    this.iconBackgroundColor = const Color(0xFFA0B7FD),
    this.isRead = false,
    this.isSelected = false, // Default should always be false
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NotificationItem> _notifications = [];
  List<NotificationItem> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _filteredNotifications = List.from(_notifications);
    _searchController.addListener(_filterNotifications);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterNotifications);
    _searchController.dispose();
    super.dispose();
  }

  // Initialize sample notifications - BUG FIXED HERE
  void _initializeNotifications() {
    _notifications = [
      NotificationItem(
        id: '1',
        title: 'Module 1: Advanced Gen AI is now available!!',
        subtitle: 'Start the new module today',
        timeAgo: '5 min ago',
        icon: Icons.person_outline,
        iconBackgroundColor: const Color(0xFFA0B7FD),
        // isSelected: false is default, no need to specify
      ),
      NotificationItem(
        id: '2',
        title: 'Module 2: Advanced Gen AI is now available!!',
        subtitle: 'Start the new module today',
        timeAgo: '5 min ago',
        icon: Icons.person_outline,
        iconBackgroundColor: const Color(0xFFA0B7FD),
      ),
      NotificationItem(
        id: '3',
        title: 'Module 3: Advanced Gen AI is now available!!',
        subtitle: 'Start the new module today',
        timeAgo: '5 min ago',
        icon: Icons.person_outline,
        iconBackgroundColor: const Color(0xFFA0B7FD),
      ),
      NotificationItem(
        id: '4',
        title: 'Module 4: Advanced Gen AI is now available!!',
        subtitle: 'Start the new module today',
        timeAgo: '5 min ago',
        icon: Icons.person_outline,
        iconBackgroundColor: const Color(0xFFA0B7FD),
      ),
      NotificationItem(
        id: '5',
        title: 'Module 5: Advanced Gen AI is now available!!',
        subtitle: 'Start the new module today',
        timeAgo: '5 min ago',
        icon: Icons.person_outline,
        iconBackgroundColor: const Color(0xFFA0B7FD),
      ),
    ];
  }

  // Filter notifications based on search query
  void _filterNotifications() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredNotifications = List.from(_notifications);
      } else {
        _filteredNotifications = _notifications.where((notification) {
          return notification.title.toLowerCase().contains(query) ||
              notification.subtitle.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // Toggle notification selection
  void _toggleNotificationSelection(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isSelected = !_notifications[index].isSelected;
      }
      _filterNotifications();
    });
  }

  // Mark notification as read
  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isRead = true;
      }
      _filterNotifications();
    });
  }

  // Clear all notifications
  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Notifications'),
          content: const Text('Are you sure you want to clear all notifications?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _notifications.clear();
                  _filteredNotifications.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Clear All',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Delete selected notifications
  void _deleteSelectedNotifications() {
    setState(() {
      _notifications.removeWhere((notification) => notification.isSelected);
      _filterNotifications();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Selected notifications deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Get count of selected notifications
  int _getSelectedCount() {
    return _notifications.where((n) => n.isSelected).length;
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _getSelectedCount();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Custom AppBar with gradient
          _buildAppBar(context),

          // Search Bar
          _buildSearchBar(),

          // Notification List
          Expanded(
            child: _filteredNotifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredNotifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(
                  _filteredNotifications[index],
                );
              },
            ),
          ),

          // Clear All Button
          if (_filteredNotifications.isNotEmpty) _buildClearAllButton(),

          // Delete Selected Button (shown when items are selected)
          if (selectedCount > 0) _buildDeleteSelectedButton(selectedCount),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // App Bar Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.topNavGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Back Button
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Title
              const Text(
                'Notification',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 22,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey.shade600,
                size: 20,
              ),
              onPressed: () {
                _searchController.clear();
              },
            )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
          onChanged: (value) {
            setState(() {}); // Rebuild to show/hide clear button
          },
        ),
      ),
    );
  }

  // Notification Card Widget
  Widget _buildNotificationCard(NotificationItem notification) {
    return GestureDetector(
      onTap: () {
        _markAsRead(notification.id);
        _toggleNotificationSelection(notification.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: notification.isSelected
                ? const Color(0xFF0088FF)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: notification.iconBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                notification.icon,
                color: Colors.white,
                size: 26,
              ),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Time
            Text(
              notification.timeAgo,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty
                ? 'No notifications yet'
                : 'No notifications found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isEmpty
                ? 'We\'ll notify you when something arrives'
                : 'Try a different search term',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // Clear All Button Widget
  Widget _buildClearAllButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: _clearAllNotifications,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA0B7FD),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Clear All',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Delete Selected Button Widget
  Widget _buildDeleteSelectedButton(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: _deleteSelectedNotifications,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
        ),
        child: Text(
          'Delete Selected ($count)',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}