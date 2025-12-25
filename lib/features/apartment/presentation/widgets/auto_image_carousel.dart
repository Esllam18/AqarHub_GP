import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutoImageCarousel extends StatefulWidget {
  final List<String> images;

  const AutoImageCarousel({super.key, required this.images});

  @override
  State<AutoImageCarousel> createState() => _AutoImageCarouselState();
}

class _AutoImageCarouselState extends State<AutoImageCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image PageView
        SizedBox(
          height: ResponsiveHelper.height(320),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        size: ResponsiveHelper.width(60),
                        color: Colors.grey.shade400,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
              ),
            ),
          ),
        ),

        // ✅ Image Counter (Repositioned - Top Left)
        Positioned(
          bottom: ResponsiveHelper.height(20),
          left: ResponsiveHelper.width(20), // ✅ Changed from right to left
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(12),
              vertical: ResponsiveHelper.height(6),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
            ),
            child: Text(
              '${_currentPage + 1}/${widget.images.length}',
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(12),
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Page Indicator
        Positioned(
          bottom: ResponsiveHelper.height(20),
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.images.length,
              effect: ExpandingDotsEffect(
                dotWidth: ResponsiveHelper.width(8),
                dotHeight: ResponsiveHelper.height(8),
                spacing: ResponsiveHelper.width(4),
                activeDotColor: AppColors.white,
                dotColor: AppColors.white.withOpacity(0.5),
                expansionFactor: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
