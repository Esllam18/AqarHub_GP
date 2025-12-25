import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../../models/chat_model.dart';
import '../widgets/chat_list_item.dart';
import '../widgets/chat_empty_state.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  // ✅ Sample chats for demonstration
  final List<ChatModel> _chats = [
    ChatModel(
      id: '1',
      userName: 'أحمد محمد',
      userImage: 'https://i.pravatar.cc/150?img=33',
      lastMessage: 'مرحباً، هل الشقة متاحة للمعاينة اليوم؟',
      time: '10:30 ص',
      unreadCount: 2,
      isOnline: true,
    ),
    ChatModel(
      id: '2',
      userName: 'سارة علي',
      userImage: 'https://i.pravatar.cc/150?img=45',
      lastMessage: 'شكراً، سأتواصل معك قريباً',
      time: 'أمس',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatModel(
      id: '3',
      userName: 'محمد حسن',
      userImage: 'https://i.pravatar.cc/150?img=12',
      lastMessage: 'ما هي تفاصيل العقد؟',
      time: 'الجمعة',
      unreadCount: 1,
      isOnline: true,
    ),
    ChatModel(
      id: '4',
      userName: 'فاطمة أحمد',
      userImage: 'https://i.pravatar.cc/150?img=47',
      lastMessage: 'هل يمكن التفاوض على السعر؟',
      time: 'الخميس',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatModel(
      id: '5',
      userName: 'عمر خالد',
      userImage: 'https://i.pravatar.cc/150?img=68',
      lastMessage: 'تم، سأحضر غداً في تمام الساعة 3',
      time: 'الأربعاء',
      unreadCount: 0,
      isOnline: false,
    ),

    ChatModel(
      id: '6',
      userName: 'ليلى سمير',
      userImage: 'https://i.pravatar.cc/150?img=22',
      lastMessage: 'هل الشقة قريبة من المواصلات العامة؟',
      time: 'الثلاثاء',
      unreadCount: 3,
      isOnline: true,
    ),

    ChatModel(
      id: '7',
      userName: 'يوسف علي',
      userImage: 'https://i.pravatar.cc/150?img=55',
      lastMessage: 'أين يمكنني العثور على المزيد من الصور؟',
      time: 'الإثنين',
      unreadCount: 0,
      isOnline: false,
    ),
  ];

  // ✅ Toggle this to test empty state
  bool _showEmptyState = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            'الرسائل',
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(20),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black87,
                size: ResponsiveHelper.width(24),
              ),
              onPressed: () {
                // TODO: Implement search
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.black87,
                size: ResponsiveHelper.width(24),
              ),
              onPressed: () {
                // TODO: Implement more options
              },
            ),
          ],
        ),
        body: _showEmptyState || _chats.isEmpty
            ? const ChatEmptyState()
            : Column(
                children: [
                  // Stats Bar
                  Container(
                    padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        _buildStatCard(
                          icon: Icons.chat_bubble_rounded,
                          label: 'المحادثات',
                          value: _chats.length.toString(),
                          color: AppColors.primary,
                        ),
                        SizedBox(width: ResponsiveHelper.width(12)),
                        _buildStatCard(
                          icon: Icons.mark_chat_unread_rounded,
                          label: 'غير مقروءة',
                          value: _chats
                              .where((chat) => chat.unreadCount > 0)
                              .length
                              .toString(),
                          color: AppColors.error,
                        ),
                      ],
                    ),
                  ),

                  // Chat List
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.height(12),
                      ),
                      itemCount: _chats.length,
                      itemBuilder: (context, index) {
                        final chat = _chats[index];
                        return ChatListItem(
                          chat: chat,
                          onTap: () {
                            context.push('/chat/${chat.id}', extra: chat);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(12),
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(18)),
            ),
            SizedBox(width: ResponsiveHelper.width(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(18),
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.tajawal(
                    fontSize: ResponsiveHelper.fontSize(11),
                    color: Colors.grey.shade700,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
