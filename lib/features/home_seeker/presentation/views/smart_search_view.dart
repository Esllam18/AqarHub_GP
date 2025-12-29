import 'package:aqar_hub_gp/features/home_seeker/data/apartments_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../widgets/smart_search/search_quick_suggestions.dart';
import '../widgets/smart_search/search_typing_indicator.dart';
import '../widgets/smart_search/search_message_bubble.dart';
import '../widgets/smart_search/search_input_field.dart';

class SmartSearchView extends StatefulWidget {
  const SmartSearchView({super.key});

  @override
  State<SmartSearchView> createState() => _SmartSearchViewState();
}

class _SmartSearchViewState extends State<SmartSearchView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        text: HomeStrings.aiGreeting,
        isUser: false,
        showApartments: false,
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    final userMessage = _messageController.text;
    setState(() {
      _messages.add(
        ChatMessage(text: userMessage, isUser: true, showApartments: false),
      );
      _isTyping = true;
    });
    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: _getAIResponse(userMessage),
            isUser: false,
            showApartments: true,
          ),
        );
      });
      _scrollToBottom();
    });
  }

  String _getAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    if (message.contains('رخيص') || message.contains('اقتصادي')) {
      return 'وجدت 5 عقارات اقتصادية مناسبة لميزانيتك! 💰\nالأسعار تبدأ من 2,500 جنيه شهرياً.';
    } else if (message.contains('عائلي') || message.contains('كبيرة')) {
      return 'عثرت على 5 شقق عائلية واسعة! 🏠\nمساحات من 130 إلى 200 متر مربع.';
    } else if (message.contains('استوديو') || message.contains('صغيرة')) {
      return 'إليك 5 شقق استوديو مناسبة! 🎯\nمثالية للأفراد والطلاب.';
    } else if (message.contains('مفروش')) {
      return 'وجدت 5 شقق مفروشة بالكامل وجاهزة للسكن! ✨';
    } else {
      return 'وجدت 5 عقارات مطابقة لمتطلباتك! 🏡\nمتنوعة في المساحات والأسعار.';
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(8)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.15),
                      AppColors.secondary.withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(10),
                  ),
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  color: AppColors.primary,
                  size: ResponsiveHelper.width(24),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HomeStrings.aiSearchTitle,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(17),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'متصل الآن',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(11),
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          iconTheme: const IconThemeData(color: AppColors.primary),
        ),
        body: Column(
          children: [
            SearchQuickSuggestions(
              onSuggestionTap: (text) {
                _messageController.text = text;
                _sendMessage();
              },
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return const SearchTypingIndicator();
                  }
                  return SearchMessageBubble(
                    message: _messages[index],
                    searchResults: searchResults,
                  );
                },
              ),
            ),
            SearchInputField(
              controller: _messageController,
              onSendPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final bool showApartments;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.showApartments = false,
  });
}
