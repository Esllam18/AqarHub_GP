import 'package:aqar_hub_gp/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'steps/basic_info_step.dart';
import 'steps/location_step.dart';
import 'steps/category_type_step.dart';
import 'steps/amenities_step.dart';
import 'steps/description_step.dart';
import 'steps/media_upload_step.dart';
import 'steps/pricing_step.dart';
import 'steps/preview_step.dart';
import '../widgets/step_indicator.dart';

class AddApartmentFlowView extends StatefulWidget {
  const AddApartmentFlowView({super.key});

  @override
  State<AddApartmentFlowView> createState() => _AddApartmentFlowViewState();
}

class _AddApartmentFlowViewState extends State<AddApartmentFlowView> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 8;

  // UI State Storage (No logic, just UI data)
  final Map<String, dynamic> _draftData = {
    'title': '',
    'rooms': 0,
    'bathrooms': 0,
    'area': 0,
    'governorate': '',
    'city': '',
    'district': '',
    'category': '', // Sale/Rent
    'type': '', // Apartment/Villa/Studio
    'amenities': <String>[],
    'description': '',
    'images': <String>[],
    'videos': <String>[],
    'price': 0,
    'isVerified': false,
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _saveDraft() {
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
              Icon(
                Icons.save_outlined,
                color: AppColors.primary,
                size: ResponsiveHelper.width(24),
              ),
              SizedBox(width: ResponsiveHelper.width(10)),
              Text(
                'حفظ المسودة',
                style: GoogleFonts.cairo(
                  fontSize: ResponsiveHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'سيتم حفظ بياناتك ويمكنك إكمالها لاحقاً',
            style: GoogleFonts.tajawal(
              fontSize: ResponsiveHelper.fontSize(14),
              color: Colors.grey.shade700,
            ),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: GoogleFonts.tajawal(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Save to storage
                Navigator.pop(context);
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.radius(10),
                  ),
                ),
              ),
              child: Text(
                'حفظ',
                style: GoogleFonts.tajawal(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentStep > 0) {
          _previousStep();
          return false;
        }
        _saveDraft();
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.grey.shade700,
                    size: ResponsiveHelper.width(24),
                  ),
                  onPressed: _saveDraft,
                ),
                Text(
                  'إضافة عقار جديد',
                  style: GoogleFonts.cairo(
                    fontSize: ResponsiveHelper.fontSize(18),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: ResponsiveHelper.width(40)), // Balance
              ],
            ),
          ),
          body: Column(
            children: [
              // Progress Indicator
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(20),
                  vertical: ResponsiveHelper.height(16),
                ),
                child: StepIndicator(
                  currentStep: _currentStep,
                  totalSteps: _totalSteps,
                ),
              ),

              // Steps Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BasicInfoStep(data: _draftData, onNext: _nextStep),
                    LocationStep(
                      data: _draftData,
                      onNext: _nextStep,
                      onBack: _previousStep,
                    ),
                    CategoryTypeStep(
                      data: _draftData,
                      onNext: _nextStep,
                      onBack: _previousStep,
                    ),
                    AmenitiesStep(
                      data: _draftData,
                      onNext: _nextStep,
                      onBack: _previousStep,
                    ),
                    DescriptionStep(
                      data: _draftData,
                      onNext: _nextStep,
                      onBack: _previousStep,
                    ),
                    MediaUploadStep(
                      data: _draftData,
                      onNext: _nextStep,
                      onBack: _previousStep,
                    ),
                    PricingStep(
                      data: _draftData,
                      onNext: _nextStep,
                      onBack: _previousStep,
                    ),
                    PreviewStep(
                      data: _draftData,
                      onBack: _previousStep,
                      onSubmit: () {
                        // TODO: Submit apartment
                        context.go(RouteNames.mainLayout);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
