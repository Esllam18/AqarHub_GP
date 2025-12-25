import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:go_router/go_router.dart';
import '../widgets/apartment_list_item.dart';

class SmartSearchView extends StatefulWidget {
  const SmartSearchView({super.key});

  @override
  State<SmartSearchView> createState() => _SmartSearchViewState();
}

class _SmartSearchViewState extends State<SmartSearchView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  // ignore: unused_field
  bool _showApartments = false;

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

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isUser: true,
          showApartments: false,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: 'وجدت 5 عقارات مطابقة لمتطلباتك! 🏡',
            isUser: false,
            showApartments: true,
          ),
        );
        _showApartments = true;
      });
      _scrollToBottom();
    });
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
      textDirection: TextDirection.rtl, // RTL for entire view
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(8)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
                child: Icon(
                  Icons.psychology_outlined,
                  color: AppColors.primary,
                  size: ResponsiveHelper.width(22),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Text(
                HomeStrings.aiSearchTitle,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          backgroundColor: AppColors.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: AppColors.primary),
        ),
        body: Column(
          children: [
            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),

            // Input Field
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(16)),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: ResponsiveHelper.height(10),
                    offset: Offset(0, ResponsiveHelper.height(-2)),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: HomeStrings.typeMessage,
                          hintStyle: GoogleFonts.tajawal(
                            color: Colors.grey.shade400,
                            fontSize: ResponsiveHelper.fontSize(14),
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.radius(25),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                            vertical: ResponsiveHelper.height(12),
                          ),
                        ),
                        style: GoogleFonts.tajawal(
                          fontSize: ResponsiveHelper.fontSize(14),
                        ),
                        textDirection: TextDirection.rtl,
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.width(12)),
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: ResponsiveHelper.width(24),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: AppColors.white,
                          size: ResponsiveHelper.width(20),
                        ),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
          child: Row(
            mainAxisAlignment: message.isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: message.isUser
                ? TextDirection.ltr
                : TextDirection.rtl,
            children: [
              if (!message.isUser)
                CircleAvatar(
                  radius: ResponsiveHelper.width(18),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.smart_toy_outlined,
                    color: AppColors.primary,
                    size: ResponsiveHelper.width(18),
                  ),
                ),
              SizedBox(width: ResponsiveHelper.width(8)),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(ResponsiveHelper.width(14)),
                  decoration: BoxDecoration(
                    color: message.isUser ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ResponsiveHelper.radius(16)),
                      topRight: Radius.circular(ResponsiveHelper.radius(16)),
                      bottomLeft: Radius.circular(
                        message.isUser
                            ? ResponsiveHelper.radius(16)
                            : ResponsiveHelper.radius(4),
                      ),
                      bottomRight: Radius.circular(
                        message.isUser
                            ? ResponsiveHelper.radius(4)
                            : ResponsiveHelper.radius(16),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: ResponsiveHelper.height(6),
                        offset: Offset(0, ResponsiveHelper.height(2)),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: message.isUser ? AppColors.white : Colors.black87,
                      height: 1.4,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(8)),
              if (message.isUser)
                CircleAvatar(
                  radius: ResponsiveHelper.width(18),
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: ResponsiveHelper.width(18),
                  ),
                ),
            ],
          ),
        ),
        if (message.showApartments) _buildApartmentResults(),
      ],
    );
  }

  Widget _buildApartmentResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(12)),
          child: Text(
            HomeStrings.searchResults,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ApartmentListItem(
              onTap: () {
                context.push(RouteNames.apartmentDetails);
              },
            );
          },
        ),
      ],
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
