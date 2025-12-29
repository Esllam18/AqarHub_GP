import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../models/favorite_apartment_model.dart';
import '../widgets/empty_state/favorites_empty_state.dart';
import '../widgets/cards/favorite_apartment_card.dart';
import '../widgets/app_bar/favorites_app_bar_content.dart';
import '../widgets/dialogs/filter_bottom_sheet.dart';
import '../widgets/dialogs/clear_all_dialog.dart';
import '../widgets/tab_bar_delegate.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample favorites for demonstration
  final List<FavoriteApartmentModel> _favorites = [
    FavoriteApartmentModel(
      id: '1',
      title: 'شقة استوديو فاخرة في موقع مميز',
      location: 'مدينة نصر، القاهرة',
      image:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      price: 3500,
      bedrooms: 2,
      bathrooms: 1,
      area: 80,
      isVerified: true,
      rating: 4.8,
      addedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    FavoriteApartmentModel(
      id: '2',
      title: 'شقة عصرية بإطلالة رائعة',
      location: 'التجمع الخامس، القاهرة',
      image:
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      price: 5000,
      bedrooms: 3,
      bathrooms: 2,
      area: 120,
      isVerified: true,
      rating: 4.9,
      addedDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    FavoriteApartmentModel(
      id: '3',
      title: 'شقة مفروشة بالكامل',
      location: 'الشيخ زايد، الجيزة',
      image: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
      price: 4200,
      bedrooms: 2,
      bathrooms: 2,
      area: 95,
      isVerified: false,
      rating: 4.6,
      addedDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
    FavoriteApartmentModel(
      id: '4',
      title: 'بنتهاوس فاخر مع سطح خاص',
      location: 'المعادي، القاهرة',
      image:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      price: 8000,
      bedrooms: 4,
      bathrooms: 3,
      area: 200,
      isVerified: true,
      rating: 5.0,
      addedDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _favorites.isEmpty
            ? const FavoritesEmptyState()
            : _buildFavoritesList(),
      ),
    );
  }

  Widget _buildFavoritesList() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        _buildTabBar(),
        _buildFavoritesGrid(),
        SliverToBoxAdapter(
          child: SizedBox(height: ResponsiveHelper.height(20)),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: ResponsiveHelper.height(180),
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
          child: SafeArea(
            child: FavoritesAppBarContent(
              favorites: _favorites,
              onFilterTap: _showFilterSheet,
              onClearAllTap: _showClearAllDialog,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverTabBarDelegate(
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
          ),
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'موثقة'),
            Tab(text: 'حديثة'),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesGrid() {
    return SliverPadding(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final apartment = _favorites[index];
          return FavoriteApartmentCard(
            apartment: apartment,
            onTap: () => _navigateToDetails(apartment.id),
            onRemove: () => _removeFavorite(apartment.id),
          );
        }, childCount: _favorites.length),
      ),
    );
  }

  void _navigateToDetails(String apartmentId) {
    context.push('/apartment-details/$apartmentId');
  }

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((apartment) => apartment.id == id);
    });
    _showSnackBar('تم الإزالة من المفضلة', AppColors.error);
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: ClearAllDialog(
          favoritesCount: _favorites.length,
          onConfirm: _clearAllFavorites,
        ),
      ),
    );
  }

  void _clearAllFavorites() {
    setState(() {
      _favorites.clear();
    });
    _showSnackBar('تم مسح جميع المفضلة بنجاح', AppColors.success);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.white),
            SizedBox(width: ResponsiveHelper.width(10)),
            Text(
              message,
              style: GoogleFonts.tajawal(),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'تراجع',
          textColor: AppColors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
