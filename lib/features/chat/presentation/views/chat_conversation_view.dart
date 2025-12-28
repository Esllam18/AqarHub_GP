import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/conversation/chat_app_bar.dart';
import '../widgets/conversation/apartment_info_banner.dart';
import '../widgets/conversation/typing_indicator.dart';
import '../widgets/conversation/scroll_to_bottom_button.dart';

class ChatConversationView extends StatefulWidget {
  final ChatModel chat;

  const ChatConversationView({super.key, required this.chat});

  @override
  State<ChatConversationView> createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<MessageModel> _messages;
  bool _showScrollToBottom = false;
  bool _isOtherUserTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
    _setupScrollListener();
    _simulateTypingIndicator();
  }

  void _initializeMessages() {
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
  }

  void _setupScrollListener() {
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(animate: false);
    });
  }

  void _simulateTypingIndicator() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isOtherUserTyping = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _isOtherUserTyping = false);
        });
      }
    });
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      final shouldShow = maxScroll - currentScroll > 200;
      if (shouldShow != _showScrollToBottom) {
        setState(() => _showScrollToBottom = shouldShow);
      }
    }
  }

  void _scrollToBottom({bool animate = true}) {
    if (_scrollController.hasClients) {
      if (animate) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
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
        appBar: ChatAppBar(chat: widget.chat, isTyping: _isOtherUserTyping),
        body: Stack(
          children: [
            Column(
              children: [
                const ApartmentInfoBanner(),
                Expanded(child: _buildMessagesList()),
                ChatInputField(
                  controller: _messageController,
                  onSend: _sendMessage,
                ),
              ],
            ),
            if (_showScrollToBottom)
              ScrollToBottomButton(onTap: _scrollToBottom),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(8)),
      itemCount: _messages.length + (_isOtherUserTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isOtherUserTyping) {
          return const TypingIndicator();
        }
        final message = _messages[index];
        return MessageBubble(
          message: message,
          onReply: () {
            // TODO: Implement reply
          },
        );
      },
    );
  }
}
