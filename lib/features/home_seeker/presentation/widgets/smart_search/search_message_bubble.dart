import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'search_apartment_results.dart';
import '../../views/smart_search_view.dart';

class SearchMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final List<Map<String, dynamic>> searchResults;

  const SearchMessageBubble({
    super.key,
    required this.message,
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
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
              if (!message.isUser) _buildAIAvatar(),
              SizedBox(width: ResponsiveHelper.width(8)),
              Flexible(child: _buildMessageContainer()),
              SizedBox(width: ResponsiveHelper.width(8)),
              if (message.isUser) _buildUserAvatar(),
            ],
          ),
        ),
        if (message.showApartments)
          SearchApartmentResults(searchResults: searchResults),
      ],
    );
  }

  Widget _buildAIAvatar() {
    return CircleAvatar(
      radius: ResponsiveHelper.width(18),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      child: Icon(
        Icons.smart_toy_outlined,
        color: AppColors.primary,
        size: ResponsiveHelper.width(18),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: ResponsiveHelper.width(18),
      backgroundColor: AppColors.primary,
      child: Icon(
        Icons.person,
        color: AppColors.white,
        size: ResponsiveHelper.width(18),
      ),
    );
  }

  Widget _buildMessageContainer() {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(14)),
      decoration: BoxDecoration(
        gradient: message.isUser
            ? LinearGradient(colors: [AppColors.primary, AppColors.secondary])
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
    );
  }
}
