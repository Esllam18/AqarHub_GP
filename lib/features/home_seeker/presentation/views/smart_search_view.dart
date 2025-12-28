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
  bool _isTyping = false;

  // Sample search results with variety
  final List<Map<String, dynamic>> _searchResults = const [
    {
      'title': 'شقة استوديو حديثة بالقرب من الجامعة',
      'location': 'مدينة نصر، القاهرة',
      'price': 3200,
      'imageUrl':
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      'bedrooms': 1,
      'bathrooms': 1,
      'area': 65,
      'rating': 4.7,
      'reviewCount': 156,
      'isVerified': true,
      'isFeatured': true,
    },
    {
      'title': 'شقة عائلية مفروشة بالكامل',
      'location': 'التجمع الخامس، القاهرة الجديدة',
      'price': 5800,
      'imageUrl':
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      'bedrooms': 3,
      'bathrooms': 2,
      'area': 130,
      'rating': 4.9,
      'reviewCount': 203,
      'isVerified': true,
      'badge': 'عرض خاص',
    },
    {
      'title': 'استوديو اقتصادي بموقع ممتاز',
      'location': 'المعادي، القاهرة',
      'price': 2500,
      'imageUrl':
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
      'bedrooms': 1,
      'bathrooms': 1,
      'area': 50,
      'rating': 4.5,
      'reviewCount': 89,
      'isVerified': true,
      'badge': 'أقل سعر',
    },
    {
      'title': 'شقة فاخرة مع إطلالة بانورامية',
      'location': 'الزمالك، القاهرة',
      'price': 7500,
      'imageUrl':
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      'bedrooms': 2,
      'bathrooms': 2,
      'area': 110,
      'rating': 4.8,
      'reviewCount': 267,
      'isFeatured': true,
      'isVerified': true,
    },
    {
      'title': 'شقة دوبلكس مع حديقة خاصة',
      'location': 'الشيخ زايد، الجيزة',
      'price': 8200,
      'imageUrl':
          'https://images.unsplash.com/photo-1494526585095-c41746248156?w=800',
      'bedrooms': 4,
      'bathrooms': 3,
      'area': 200,
      'rating': 5.0,
      'reviewCount': 142,
      'isVerified': true,
      'badge': 'جديد',
    },
  ];

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

    // Simulate AI typing
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
            // Quick Suggestions
            _buildQuickSuggestions(),

            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(ResponsiveHelper.width(16)),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return _buildTypingIndicator();
                  }
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),

            // Input Field
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSuggestions() {
    final suggestions = [
      {'icon': Icons.attach_money_rounded, 'text': 'شقة اقتصادية'},
      {'icon': Icons.family_restroom_rounded, 'text': 'شقة عائلية'},
      {'icon': Icons.weekend_rounded, 'text': 'شقة مفروشة'},
      {'icon': Icons.apartment_rounded, 'text': 'استوديو'},
    ];

    return Container(
      height: ResponsiveHelper.height(70),
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(12),
        ),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Padding(
            padding: EdgeInsets.only(left: ResponsiveHelper.width(8)),
            child: InkWell(
              onTap: () {
                _messageController.text = suggestion['text'] as String;
                _sendMessage();
              },
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(16),
                  vertical: ResponsiveHelper.height(8),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(12),
                  ),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      suggestion['icon'] as IconData,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(18),
                    ),
                    SizedBox(width: ResponsiveHelper.width(8)),
                    Text(
                      suggestion['text'] as String,
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(13),
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
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
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(14)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                SizedBox(width: ResponsiveHelper.width(4)),
                _buildDot(1),
                SizedBox(width: ResponsiveHelper.width(4)),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: ResponsiveHelper.width(8),
          height: ResponsiveHelper.width(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(
              0.3 + (0.7 * ((value + index * 0.33) % 1)),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        if (mounted) setState(() {});
      },
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
                    gradient: message.isUser
                        ? LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          )
                        : null,
                    color: message.isUser ? null : AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ResponsiveHelper.radius(18)),
                      topRight: Radius.circular(ResponsiveHelper.radius(18)),
                      bottomLeft: Radius.circular(
                        message.isUser
                            ? ResponsiveHelper.radius(18)
                            : ResponsiveHelper.radius(4),
                      ),
                      bottomRight: Radius.circular(
                        message.isUser
                            ? ResponsiveHelper.radius(4)
                            : ResponsiveHelper.radius(18),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: message.isUser
                            ? AppColors.primary.withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: message.isUser ? AppColors.white : Colors.black87,
                      height: 1.5,
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
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(16)),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(8)),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(8),
                  ),
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: ResponsiveHelper.width(20),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Text(
                HomeStrings.searchResults,
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(17),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final apartment = _searchResults[index];
            return ApartmentListItem(
              onTap: () {
                context.push('/${RouteNames.apartmentDetails}');
              },
              title: apartment['title'] as String,
              location: apartment['location'] as String,
              price: apartment['price'] as int,
              imageUrl: apartment['imageUrl'] as String,
              bedrooms: apartment['bedrooms'] as int,
              bathrooms: apartment['bathrooms'] as int,
              area: apartment['area'] as int,
              rating: apartment['rating'] as double,
              reviewCount: apartment['reviewCount'] as int,
              isVerified: apartment['isVerified'] as bool? ?? false,
              isFeatured: apartment['isFeatured'] as bool? ?? false,
              badge: apartment['badge'] as String?,
            );
          },
        ),
      ],
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.mic_rounded,
                      color: AppColors.primary.withOpacity(0.6),
                    ),
                    onPressed: () {
                      // Voice input functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'ميزة البحث الصوتي قريباً',
                            style: GoogleFonts.tajawal(),
                            textDirection: TextDirection.rtl,
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
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
