import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../widgets/owner_apartment_card.dart';
import '../widgets/empty_apartments_state.dart';
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

  final List<ApartmentData> _apartments = [
    ApartmentData(
      id: '1',
      title: 'شقة عائلية واسعة',
      location: 'بني سويف الجديدة',
      price: 2500,
      bedrooms: 3,
      bathrooms: 2,
      area: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      isRented: false,
    ),
    ApartmentData(
      id: '2',
      title: 'شقة استوديو حديثة',
      location: 'بني سويف - شارع 23 يوليو',
      price: 1800,
      bedrooms: 1,
      bathrooms: 1,
      area: 65,
      imageUrl:
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      isRented: true,
    ),
    ApartmentData(
      id: '3',
      title: 'شقة فاخرة مفروشة',
      location: 'بني سويف - حي الزهور',
      price: 8500,
      bedrooms: 4,
      bathrooms: 3,
      area: 180,
      imageUrl:
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
      isRented: false,
      hasSuspiciousPrice: true,
    ),
    ApartmentData(
      id: '4',
      title: 'شقة اقتصادية للطلاب',
      location: 'بني سويف - قرب الجامعة',
      price: 1200,
      bedrooms: 2,
      bathrooms: 1,
      area: 70,
      imageUrl:
          'https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=800',
      isRented: true,
    ),
    ApartmentData(
      id: '5',
      title: 'شقة متوسطة مريحة',
      location: 'بني سويف - كورنيش النيل',
      price: 3200,
      bedrooms: 2,
      bathrooms: 2,
      area: 100,
      imageUrl:
          'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800',
      isRented: false,
    ),
    ApartmentData(
      id: '6',
      title: 'شقة ديلوكس بالدور الأخير',
      location: 'بني سويف الجديدة - الحي الثالث',
      price: 4500,
      bedrooms: 3,
      bathrooms: 2,
      area: 150,
      imageUrl:
          'https://images.unsplash.com/photo-1565623833408-d77e39b88af6?w=800',
      isRented: false,
    ),
    ApartmentData(
      id: '7',
      title: 'شقة روف بإطلالة رائعة',
      location: 'بني سويف - شارع صلاح سالم',
      price: 15000,
      bedrooms: 5,
      bathrooms: 4,
      area: 250,
      imageUrl:
          'https://www.godwinvaapts.com/wp-content/uploads/2022/06/lewisRender2.jpg',
      isRented: false,
      hasSuspiciousPrice: true,
    ),
    ApartmentData(
      id: '8',
      title: 'شقة صغيرة مناسبة للعرسان',
      location: 'بني سويف - حي السلام',
      price: 2000,
      bedrooms: 2,
      bathrooms: 1,
      area: 85,
      imageUrl:
          'https://images.unsplash.com/photo-1556020685-ae41abfc9365?w=800',
      isRented: true,
    ),
  ];

  int get _totalApartments => _apartments.length;
  int get _rentedCount => _apartments.where((a) => a.isRented).length;
  int get _availableCount => _apartments.where((a) => !a.isRented).length;

  List<ApartmentData> get _filteredApartments {
    switch (_selectedFilter) {
      case 'العقارات المتاحة':
        return _apartments.where((a) => !a.isRented).toList();
      case 'العقارات المؤجرة':
        return _apartments.where((a) => a.isRented).toList();
      case 'تحذيرات السعر':
        return _apartments.where((a) => a.hasSuspiciousPrice).toList();
      default:
        return _apartments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasApartments = _apartments.isNotEmpty;

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
      final apartment = _apartments.firstWhere((a) => a.id == apartmentId);
      apartment.isRented = !apartment.isRented;
    });

    final apartment = _apartments.firstWhere((a) => a.id == apartmentId);
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
          setState(() => _apartments.removeWhere((a) => a.id == apartmentId));
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
