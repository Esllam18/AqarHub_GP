import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/features/home_seeker/presentation/views/user_home_view.dart';
import 'package:aqar_hub_gp/features/chat/presentation/views/chat_list_view.dart';
import 'package:aqar_hub_gp/features/favorites/presentation/views/favorites_view.dart';
import 'package:aqar_hub_gp/features/profile/presentation/views/profile_view.dart';
import 'package:aqar_hub_gp/features/owner/presentation/views/owner_home_view.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainLayoutView extends StatefulWidget {
  final bool isOwner;
  final dynamic user;

  const MainLayoutView({super.key, required this.isOwner, this.user});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final PageController _pageController;
  late final AnimationController _fabAnimationController;
  late final Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // FAB Animation Controller
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fabScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    if (widget.isOwner) {
      _fabAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  List<Widget> get _screens {
    if (widget.isOwner) {
      return [const OwnerHomeView(), const ChatListView(), const ProfileView()];
    }
    return [
      const UserHomeView(),
      const ChatListView(),
      const FavoritesView(),
      const ProfileView(),
    ];
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return; // Prevent unnecessary rebuilds

    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onAddButtonPressed() {
    // TODO: Navigate to Add Apartment Screen
    // context.push(RouteNames.addApartment);

    // Temporary feedback with RTL
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'انتقال إلى شاشة إضافة عقار',
            style: GoogleFonts.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL for entire layout
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          physics: const NeverScrollableScrollPhysics(), // Disable swipe
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          isOwner: widget.isOwner,
        ),
        floatingActionButton: widget.isOwner
            ? ScaleTransition(
                scale: _fabScaleAnimation,
                child: FloatingActionButton(
                  onPressed: _onAddButtonPressed,
                  backgroundColor: AppColors.primary,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: widget.isOwner
            ? FloatingActionButtonLocation.centerDocked
            : null,
      ),
    );
  }
}
