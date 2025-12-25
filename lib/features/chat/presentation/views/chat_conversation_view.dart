import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_field.dart';

class ChatConversationView extends StatefulWidget {
  final ChatModel chat;

  const ChatConversationView({super.key, required this.chat});

  @override
  State<ChatConversationView> createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ✅ Sample messages for demonstration
  late List<MessageModel> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      MessageModel(
        id: '1',
        message: 'السلام عليكم، أنا مهتم بالشقة',
        time: '09:15 ص',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        id: '2',
        message: 'وعليكم السلام، أهلاً وسهلاً',
        time: '09:16 ص',
        isSentByMe: false,
        isRead: true,
      ),
      MessageModel(
        id: '3',
        message: 'هل يمكنني معاينة الشقة غداً؟',
        time: '09:17 ص',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        id: '4',
        message: 'بالتأكيد، ما هو الوقت المناسب لك؟',
        time: '09:18 ص',
        isSentByMe: false,
        isRead: true,
      ),
      MessageModel(
        id: '5',
        message: 'الساعة 3 مساءً إن أمكن',
        time: '09:20 ص',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        id: '6',
        message:
            'ممتاز، سأكون في انتظارك. العنوان: شارع عباس العقاد، مدينة نصر',
        time: '09:22 ص',
        isSentByMe: false,
        isRead: true,
      ),
      MessageModel(
        id: '7',
        message: 'شكراً جزيلاً، سأراك غداً 👍',
        time: '09:25 ص',
        isSentByMe: true,
        isRead: true,
      ),
      MessageModel(
        id: '8',
        message: 'مرحباً، هل الشقة متاحة للمعاينة اليوم؟',
        time: '10:30 ص',
        isSentByMe: true,
        isRead: false,
      ),
    ];

    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        MessageModel(
          id: DateTime.now().toString(),
          message: _messageController.text.trim(),
          time: _formatTime(DateTime.now()),
          isSentByMe: true,
          isRead: false,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'م' : 'ص';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: Colors.black87,
              size: ResponsiveHelper.width(24),
            ),
            onPressed: () => context.pop(),
          ),
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              // User Image with Online Status
              Stack(
                children: [
                  Container(
                    width: ResponsiveHelper.width(42),
                    height: ResponsiveHelper.width(42),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.chat.isOnline
                            ? AppColors.success
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.chat.userImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.person,
                              size: ResponsiveHelper.width(20),
                              color: Colors.grey.shade400,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (widget.chat.isOnline)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: ResponsiveHelper.width(12),
                        height: ResponsiveHelper.width(12),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.userName,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  if (widget.chat.isOnline)
                    Text(
                      'متصل الآن',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(11),
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.call_rounded,
                color: AppColors.primary,
                size: ResponsiveHelper.width(22),
              ),
              onPressed: () {
                // TODO: Implement call
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.black87,
                size: ResponsiveHelper.width(22),
              ),
              onPressed: () {
                // TODO: Implement more options
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Apartment Info Banner
            Container(
              margin: EdgeInsets.all(ResponsiveHelper.width(12)),
              padding: EdgeInsets.all(ResponsiveHelper.width(12)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: ResponsiveHelper.width(60),
                    height: ResponsiveHelper.width(60),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(10),
                      ),
                    ),
                    child: Icon(
                      Icons.apartment_rounded,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(30),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.width(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'شقة استوديو فاخرة',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: ResponsiveHelper.height(4)),
                        Text(
                          'مدينة نصر، القاهرة • 3,500 جنيه/شهر',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(11),
                            color: Colors.grey.shade600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.primary,
                    size: ResponsiveHelper.width(20),
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(12),
                  vertical: ResponsiveHelper.height(8),
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final showTime =
                      index == 0 || _messages[index - 1].time != message.time;

                  return Column(
                    children: [
                      if (showTime) _buildDateDivider(message.time),
                      MessageBubble(message: message),
                    ],
                  );
                },
              ),
            ),

            // Input Field
            ChatInputField(
              controller: _messageController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateDivider(String time) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.grey.shade300],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(12),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(12),
                vertical: ResponsiveHelper.height(4),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(12),
                ),
              ),
              child: Text(
                'اليوم',
                style: GoogleFonts.tajawal(
                  fontSize: ResponsiveHelper.fontSize(11),
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade300, Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
