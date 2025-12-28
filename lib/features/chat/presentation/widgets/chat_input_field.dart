import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

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

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
      if (hasText) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
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
            // Text Field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(25),
                  ),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: TextField(
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
                      ),
                    ),

                    // Action Buttons
                    if (!_hasText) ...[
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
                        onPressed: () {
                          _showAttachmentOptions(context);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(width: ResponsiveHelper.width(8)),

            // Send/Voice Button
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: _hasText ? _buildSendButton() : _buildVoiceButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: () {
          if (_hasText) {
            widget.onSend();
            _animationController.reverse();
          }
        },
        child: Container(
          key: const ValueKey('send'),
          width: ResponsiveHelper.width(48),
          height: ResponsiveHelper.width(48),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.send_rounded,
            color: AppColors.white,
            size: ResponsiveHelper.width(22),
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceButton() {
    return GestureDetector(
      onLongPressStart: (_) => _startRecording(),
      onLongPressEnd: (_) => _stopRecording(),
      child: Container(
        key: const ValueKey('voice'),
        width: ResponsiveHelper.width(48),
        height: ResponsiveHelper.width(48),
        decoration: BoxDecoration(
          color: _isRecording ? AppColors.error : Colors.grey.shade200,
          shape: BoxShape.circle,
          boxShadow: _isRecording
              ? [
                  BoxShadow(
                    color: AppColors.error.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          Icons.mic_rounded,
          color: _isRecording ? AppColors.white : Colors.grey.shade700,
          size: ResponsiveHelper.width(22),
        ),
      ),
    );
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    // TODO: Start voice recording
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    // TODO: Stop voice recording and send
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ResponsiveHelper.radius(24)),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.height(12),
                ),
                width: ResponsiveHelper.width(40),
                height: ResponsiveHelper.height(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(2),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(ResponsiveHelper.width(24)),
                child: Column(
                  children: [
                    Text(
                      'إرفاق ملف',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(20)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAttachmentOption(
                          icon: Icons.camera_alt_rounded,
                          label: 'كاميرا',
                          color: Colors.purple,
                          onTap: () => Navigator.pop(context),
                        ),
                        _buildAttachmentOption(
                          icon: Icons.photo_library_rounded,
                          label: 'معرض',
                          color: Colors.pink,
                          onTap: () => Navigator.pop(context),
                        ),
                        _buildAttachmentOption(
                          icon: Icons.insert_drive_file_rounded,
                          label: 'ملف',
                          color: Colors.blue,
                          onTap: () => Navigator.pop(context),
                        ),
                        _buildAttachmentOption(
                          icon: Icons.location_on_rounded,
                          label: 'موقع',
                          color: Colors.green,
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(8)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: ResponsiveHelper.width(56),
            height: ResponsiveHelper.width(56),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: ResponsiveHelper.width(28)),
          ),
          SizedBox(height: ResponsiveHelper.height(8)),
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ResponsiveHelper.fontSize(12),
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
