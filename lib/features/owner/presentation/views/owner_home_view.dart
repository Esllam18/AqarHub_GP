import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import '../widgets/owner_apartment_card.dart';
import '../widgets/empty_apartments_state.dart';

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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير';
    if (hour < 18) return 'مساء الخير';
    return 'مساء الخير';
  }

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

  @override
  Widget build(BuildContext context) {
    final bool hasApartments = _apartments.isNotEmpty;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
        _buildBeautifulHeader(), // Changed from _buildCleanHeader()
        // Stats Section (Below Header)
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.fromLTRB(
              ResponsiveHelper.width(20),
              ResponsiveHelper.height(20),
              ResponsiveHelper.width(20),
              ResponsiveHelper.height(16),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                _buildStatCard(
                  '$_totalApartments',
                  'إجمالي العقارات',
                  Icons.apartment_rounded,
                  AppColors.primary,
                ),
                SizedBox(width: ResponsiveHelper.width(10)),
                _buildStatCard(
                  '$_availableCount',
                  'متاح',
                  Icons.check_circle_rounded,
                  Colors.green,
                ),
                SizedBox(width: ResponsiveHelper.width(10)),
                _buildStatCard(
                  '$_rentedCount',
                  'مؤجر',
                  Icons.home_work_rounded,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ),

        // Section Header with Filter
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(20)),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عقاراتي',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(22),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(4)),
                    Text(
                      '${_filteredApartments.length} عقار',
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(13),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.radius(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_list_rounded,
                      color: AppColors.primary,
                      size: ResponsiveHelper.width(22),
                    ),
                    onPressed: _showSmartFilter,
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(height: ResponsiveHelper.height(16)),
        ),

        // Active Filter Indicator
        if (_selectedFilter != 'الكل')
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(20),
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(bottom: ResponsiveHelper.height(16)),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(12),
                  vertical: ResponsiveHelper.height(8),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(10),
                  ),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(
                      Icons.filter_alt_rounded,
                      size: ResponsiveHelper.width(16),
                      color: AppColors.primary,
                    ),
                    SizedBox(width: ResponsiveHelper.width(6)),
                    Text(
                      'تصفية: $_selectedFilter',
                      style: GoogleFonts.cairo(
                        fontSize: ResponsiveHelper.fontSize(13),
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.width(8)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = 'الكل';
                        });
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: ResponsiveHelper.width(16),
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Apartments List
        SliverPadding(
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
        ),

        SliverToBoxAdapter(
          child: SizedBox(height: ResponsiveHelper.height(100)),
        ),
      ],
    );
  }

  Widget _buildBeautifulHeader() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primary, AppColors.secondary],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(ResponsiveHelper.radius(15)),
            bottomRight: Radius.circular(ResponsiveHelper.radius(15)),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.width(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar - Greeting and Notification
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.rtl,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreeting(),
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(13),
                            color: AppColors.white.withOpacity(0.9),
                          ),
                        ),
                        SizedBox(height: ResponsiveHelper.height(4)),
                        Text(
                          'أهلاً بك في عقار هاب',
                          style: GoogleFonts.cairo(
                            fontSize: ResponsiveHelper.fontSize(20),
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: ResponsiveHelper.height(4)),
                        Text(
                          'إدارة عقاراتك من هنا',
                          style: GoogleFonts.tajawal(
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.white.withOpacity(0.85),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: ResponsiveHelper.width(44),
                      height: ResponsiveHelper.width(44),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.primary,
                          size: ResponsiveHelper.width(24),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                // Search Bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(14)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(16)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: ResponsiveHelper.width(20)),
            ),
            SizedBox(height: ResponsiveHelper.height(8)),
            Text(
              value,
              style: GoogleFonts.cairo(
                fontSize: ResponsiveHelper.fontSize(20),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: ResponsiveHelper.height(2)),
            Text(
              label,
              style: GoogleFonts.tajawal(
                fontSize: ResponsiveHelper.fontSize(11),
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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

  void _showSmartFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl, // RTL for filters
        child: Container(
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
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(ResponsiveHelper.width(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تصفية العقارات',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(20),
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),

                      SizedBox(height: ResponsiveHelper.height(20)),

                      // Filter Options (RTL)
                      _buildFilterOption(
                        'الكل',
                        Icons.apps_rounded,
                        Colors.grey.shade700,
                        'عرض جميع العقارات',
                      ),

                      _buildFilterOption(
                        'العقارات المتاحة',
                        Icons.check_circle_rounded,
                        Colors.green,
                        'العقارات الجاهزة للتأجير',
                      ),

                      _buildFilterOption(
                        'العقارات المؤجرة',
                        Icons.home_work_rounded,
                        Colors.blue,
                        'العقارات المؤجرة حالياً',
                      ),

                      _buildFilterOption(
                        'تحذيرات السعر',
                        Icons.warning_amber_rounded,
                        Colors.orange,
                        'عقارات بأسعار مشكوك فيها',
                      ),

                      Divider(height: ResponsiveHelper.height(24)),

                      Text(
                        'الترتيب',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                        textDirection: TextDirection.rtl,
                      ),

                      SizedBox(height: ResponsiveHelper.height(8)),

                      _buildFilterOption(
                        'الأحدث أولاً',
                        Icons.new_releases_rounded,
                        Colors.purple,
                        null,
                      ),

                      _buildFilterOption(
                        'السعر من الأقل للأعلى',
                        Icons.arrow_upward_rounded,
                        Colors.teal,
                        null,
                      ),

                      SizedBox(height: ResponsiveHelper.height(12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption(
    String label,
    IconData icon,
    Color color,
    String? description,
  ) {
    final isSelected = _selectedFilter == label;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveHelper.height(8)),
        padding: EdgeInsets.all(ResponsiveHelper.width(12)),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          border: Border.all(
            color: isSelected ? color.withOpacity(0.3) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.radius(10),
                ),
              ),
              child: Icon(icon, size: ResponsiveHelper.width(20), color: color),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(14),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      color: isSelected ? color : Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (description != null) ...[
                    SizedBox(height: ResponsiveHelper.height(2)),
                    Text(
                      description,
                      style: GoogleFonts.tajawal(
                        fontSize: ResponsiveHelper.fontSize(11),
                        color: Colors.grey.shade600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: color,
                size: ResponsiveHelper.width(20),
              ),
          ],
        ),
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

  void _showDeleteDialog(BuildContext context, String apartmentId) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(20)),
          ),
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveHelper.width(8)),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_rounded,
                  color: AppColors.error,
                  size: ResponsiveHelper.width(24),
                ),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Text(
                'حذف العقار',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'هل أنت متأكد من حذف هذا العقار؟ لا يمكن التراجع عن هذا الإجراء.',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: GoogleFonts.cairo(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _apartments.removeWhere((a) => a.id == apartmentId);
                });
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(20),
                  vertical: ResponsiveHelper.height(12),
                ),
              ),
              child: Text(
                'حذف',
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
