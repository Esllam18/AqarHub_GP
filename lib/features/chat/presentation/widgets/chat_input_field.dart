import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'input/attachment_bottom_sheet.dart';
import 'input/send_button.dart';
import 'input/voice_button.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField>
    with SingleTickerProviderStateMixin {
  bool _hasText = false;
  bool _isRecording = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
      hasText ? _animationController.forward() : _animationController.reverse();
    }
  }

  void _startRecording() {
    setState(() => _isRecording = true);
    // TODO: Start voice recording
  }

  void _stopRecording() {
    setState(() => _isRecording = false);
    // TODO: Stop voice recording and send
  }

  void _handleSend() {
    if (_hasText) {
      widget.onSend();
      _animationController.reverse();
    }
  }

  void _showAttachmentOptions() {
    showAttachmentBottomSheet(context);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(child: _buildTextField()),
            SizedBox(width: ResponsiveHelper.width(8)),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(25)),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(child: _buildTextInput()),
          if (!_hasText) _buildInlineActions(),
        ],
      ),
    );
  }

  Widget _buildTextInput() {
    return TextField(
      controller: widget.controller,
      textDirection: TextDirection.rtl,
      style: GoogleFonts.tajawal(
        fontSize: ResponsiveHelper.fontSize(14),
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: 'اكتب رسالتك...',
        hintTextDirection: TextDirection.rtl,
        hintStyle: GoogleFonts.tajawal(
          fontSize: ResponsiveHelper.fontSize(14),
          color: Colors.grey.shade500,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(12),
        ),
      ),
      maxLines: 5,
      minLines: 1,
      textInputAction: TextInputAction.newline,
    );
  }

  Widget _buildInlineActions() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.grey.shade600,
            size: ResponsiveHelper.width(22),
          ),
          onPressed: () {
            // TODO: Show emoji picker
          },
        ),
        IconButton(
          icon: Icon(
            Icons.attach_file_rounded,
            color: Colors.grey.shade600,
            size: ResponsiveHelper.width(22),
          ),
          onPressed: _showAttachmentOptions,
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: _hasText
          ? SendButton(scaleAnimation: _scaleAnimation, onSend: _handleSend)
          : VoiceButton(
              isRecording: _isRecording,
              onLongPressStart: (_) => _startRecording(),
              onLongPressEnd: (_) => _stopRecording(),
            ),
    );
  }
}
