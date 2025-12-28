import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:aqar_hub_gp/features/owner/data/apartments_list.dart';
import 'package:aqar_hub_gp/features/owner/presentation/widgets/empty_apartments_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../widgets/owner_apartment_card.dart';
import '../widgets/owner_header_widget.dart';
import '../widgets/owner_stats_section.dart';
import '../widgets/apartments_section_header.dart';
import '../widgets/active_filter_chip.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/delete_apartment_dialog.dart';

// Apartment Model
class ApartmentData {
  final String id;
  final String title;
  final String location;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final String imageUrl;
  bool isRented;
  final bool hasSuspiciousPrice;

  ApartmentData({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.imageUrl,
    this.isRented = false,
    this.hasSuspiciousPrice = false,
  });
}

class OwnerHomeView extends StatefulWidget {
  const OwnerHomeView({super.key});

  @override
  State<OwnerHomeView> createState() => _OwnerHomeViewState();
}

class _OwnerHomeViewState extends State<OwnerHomeView> {
  String _selectedFilter = 'الكل';

  int get _totalApartments => apartments.length;
  int get _rentedCount => apartments.where((a) => a.isRented).length;
  int get _availableCount => apartments.where((a) => !a.isRented).length;

  List<ApartmentData> get _filteredApartments {
    switch (_selectedFilter) {
      case 'العقارات المتاحة':
        return apartments.where((a) => !a.isRented).toList();
      case 'العقارات المؤجرة':
        return apartments.where((a) => a.isRented).toList();
      case 'تحذيرات السعر':
        return apartments.where((a) => a.hasSuspiciousPrice).toList();
      default:
        return apartments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasApartments = apartments.isNotEmpty;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: null,
        backgroundColor: AppColors.background,
        body: hasApartments
            ? _buildContentView()
            : const EmptyApartmentsState(),
        floatingActionButton: _buildFAB(),
      ),
    );
  }

  Widget _buildContentView() {
    return CustomScrollView(
      slivers: [
        OwnerHeaderWidget(),
        OwnerStatsSection(
          totalApartments: _totalApartments,
          availableCount: _availableCount,
          rentedCount: _rentedCount,
        ),
        ApartmentsSectionHeader(
          apartmentsCount: _filteredApartments.length,
          onFilterPressed: _showSmartFilter,
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: ResponsiveHelper.height(16)),
        ),
        if (_selectedFilter != 'الكل')
          ActiveFilterChip(
            selectedFilter: _selectedFilter,
            onClear: () => setState(() => _selectedFilter = 'الكل'),
          ),
        _buildApartmentsList(),
        SliverToBoxAdapter(
          child: SizedBox(height: ResponsiveHelper.height(100)),
        ),
      ],
    );
  }

  Widget _buildApartmentsList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final apartment = _filteredApartments[index];
          return OwnerApartmentCard(
            apartment: apartment,
            onTap: () => context.push(RouteNames.apartmentDetails),
            onEdit: () => _onEdit(context),
            onDelete: () => _showDeleteDialog(context, apartment.id),
            onToggleRented: () => _toggleRentedStatus(apartment.id),
          );
        }, childCount: _filteredApartments.length),
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _onAddApartment,
      backgroundColor: AppColors.primary,
      elevation: 6,
      child: const Icon(Icons.add_rounded, color: AppColors.white, size: 28),
    );
  }

  void _toggleRentedStatus(String apartmentId) {
    setState(() {
      final apartment = apartments.firstWhere((a) => a.id == apartmentId);
      apartment.isRented = !apartment.isRented;
    });

    final apartment = apartments.firstWhere((a) => a.id == apartmentId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          apartment.isRented
              ? 'تم تحديد العقار كمؤجر'
              : 'تم تحديد العقار كمتاح',
          style: GoogleFonts.tajawal(),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: apartment.isRented ? Colors.blue : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSmartFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => FilterBottomSheet(
        selectedFilter: _selectedFilter,
        onFilterSelected: (filter) {
          setState(() => _selectedFilter = filter);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String apartmentId) {
    showDialog(
      context: context,
      builder: (context) => DeleteApartmentDialog(
        onConfirm: () {
          Navigator.pop(context);
          setState(() => apartments.removeWhere((a) => a.id == apartmentId));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم حذف العقار بنجاح',
                style: GoogleFonts.tajawal(),
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  void _onAddApartment() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'إضافة عقار جديد',
          style: GoogleFonts.tajawal(),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onEdit(BuildContext context) {
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
}
