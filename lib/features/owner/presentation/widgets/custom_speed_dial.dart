import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class CustomSpeedDial extends StatefulWidget {
  const CustomSpeedDial({super.key});

  @override
  State<CustomSpeedDial> createState() => _CustomSpeedDialState();
}

class _CustomSpeedDialState extends State<CustomSpeedDial>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.625,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Overlay
          if (_isOpen)
            GestureDetector(
              onTap: _toggle,
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),

          // Action Buttons
          Positioned(
            right: ResponsiveHelper.width(20),
            bottom: ResponsiveHelper.height(90),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildSpeedDialButton(
                  icon: Icons.search_rounded,
                  label: 'بحث',
                  color: Colors.purple,
                  delay: 0,
                  onTap: () {
                    _toggle();
                    _onSearch();
                  },
                ),
                SizedBox(height: ResponsiveHelper.height(12)),
                _buildSpeedDialButton(
                  icon: Icons.location_on_rounded,
                  label: 'تحديد موقع',
                  color: Colors.orange,
                  delay: 50,
                  onTap: () {
                    _toggle();
                    _onSetLocation();
                  },
                ),
                SizedBox(height: ResponsiveHelper.height(12)),
                _buildSpeedDialButton(
                  icon: Icons.edit_rounded,
                  label: 'تعديل',
                  color: AppColors.primary,
                  delay: 100,
                  onTap: () {
                    _toggle();
                    _onEdit();
                  },
                ),
                SizedBox(height: ResponsiveHelper.height(12)),
                _buildSpeedDialButton(
                  icon: Icons.delete_rounded,
                  label: 'حذف',
                  color: Colors.red,
                  delay: 150,
                  onTap: () {
                    _toggle();
                    _onDelete();
                  },
                ),
              ],
            ),
          ),

          // Main FAB
          Positioned(
            right: ResponsiveHelper.width(20),
            bottom: ResponsiveHelper.height(20),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159 * 2,
                  child: FloatingActionButton(
                    onPressed: _toggle,
                    backgroundColor: AppColors.primary,
                    elevation: 8,
                    child: Icon(
                      _isOpen ? Icons.close_rounded : Icons.add_rounded,
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedDialButton({
    required IconData icon,
    required String label,
    required Color color,
    required int delay,
    required VoidCallback onTap,
  }) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(12),
              vertical: ResponsiveHelper.height(8),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(13),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(10)),

          // Button
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: ResponsiveHelper.width(50),
              height: ResponsiveHelper.width(50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: ResponsiveHelper.width(24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'البحث عن عقار',
          style: GoogleFonts.tajawal(),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.purple,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onSetLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تحديد الموقع',
          style: GoogleFonts.tajawal(),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onEdit() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تعديل العقار',
          style: GoogleFonts.tajawal(),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onDelete() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'حذف العقار',
          style: GoogleFonts.tajawal(),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
