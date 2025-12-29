import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/features/home_seeker/presentation/views/user_home_view.dart';
import 'package:aqar_hub_gp/features/chat/presentation/views/chat_list_view.dart';
import 'package:aqar_hub_gp/features/favorites/presentation/views/favorites_view.dart';
import 'package:aqar_hub_gp/features/profile/presentation/views/profile_view.dart';
import 'package:aqar_hub_gp/features/owner/presentation/views/owner_home_view.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/animated_fab_button.dart';

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
    _initializeFabAnimation();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          physics: const NeverScrollableScrollPhysics(),
          children: _getScreens(),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          isOwner: widget.isOwner,
        ),
        floatingActionButton: widget.isOwner
            ? AnimatedFabButton(
                scaleAnimation: _fabScaleAnimation,
                onPressed: _onAddButtonPressed,
              )
            : null,
        floatingActionButtonLocation: widget.isOwner
            ? FloatingActionButtonLocation.endFloat
            : null,
      ),
    );
  }

  void _initializeFabAnimation() {
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

  List<Widget> _getScreens() {
    if (widget.isOwner) {
      return [
        const OwnerHomeView(),
        const ChatListView(),
        ProfileView(isOwner: true),
      ];
    }
    return [
      const UserHomeView(),
      const ChatListView(),
      const FavoritesView(),
      ProfileView(isOwner: false),
    ];
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onAddButtonPressed() {
    context.push(RouteNames.addApartment);
  }
}
