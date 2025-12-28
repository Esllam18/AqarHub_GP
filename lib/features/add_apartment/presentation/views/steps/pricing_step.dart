import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../../widgets/custom_step_button.dart';
import '../../widgets/price_verification_badge.dart';

class PricingStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PricingStep({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<PricingStep> createState() => _PricingStepState();
}

class _PricingStepState extends State<PricingStep> {
  final TextEditingController _priceController = TextEditingController();
  bool _isVerifying = false;
  bool? _isVerified;
  String? _aiMessage;

  @override
  void initState() {
    super.initState();
    final price = widget.data['price'];
    if (price != null && price > 0) {
      _priceController.text = price.toString();
    }
    _isVerified = widget.data['isVerified'];
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _verifyPrice() async {
    if (_priceController.text.isEmpty) return;

    setState(() {
      _isVerifying = true;
      _isVerified = null;
      _aiMessage = null;
    });

    // Simulate AI verification (TODO: Replace with actual AI call)
    await Future.delayed(const Duration(seconds: 2));

    final price = double.tryParse(_priceController.text) ?? 0;
    final area = widget.data['area'] ?? 100;
    final pricePerMeter = price / area;

    // Simple logic for demonstration
    setState(() {
      _isVerifying = false;

      if (pricePerMeter >= 8000 && pricePerMeter <= 25000) {
        _isVerified = true;
        _aiMessage = 'السعر مناسب للموقع والمواصفات ✓';
      } else if (pricePerMeter < 8000) {
        _isVerified = false;
        _aiMessage =
            'السعر منخفض مقارنة بالمنطقة. يمكنك إضافته ولكن بدون شارة التحقق.';
      } else {
        _isVerified = false;
        _aiMessage =
            'السعر مرتفع مقارنة بالمنطقة. يمكنك إضافته ولكن بدون شارة التحقق.';
      }
    });
  }

  void _saveAndNext() {
    widget.data['price'] = double.tryParse(_priceController.text) ?? 0;
    widget.data['isVerified'] = _isVerified ?? false;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final canProceed =
        _priceController.text.isNotEmpty &&
        _isVerified != null &&
        !_isVerifying;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.width(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'تحديد السعر',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    'أدخل السعر المطلوب وسنتحقق من مناسبته',
                    style: GoogleFonts.tajawal(
                      fontSize: ResponsiveHelper.fontSize(14),
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(32)),

                  // Price Input
                  Text(
                    widget.data['category'] == 'rent'
                        ? 'الإيجار الشهري'
                        : 'سعر البيع',
                    style: GoogleFonts.cairo(
                      fontSize: ResponsiveHelper.fontSize(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  SizedBox(height: ResponsiveHelper.height(12)),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.radius(16),
                      ),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _priceController,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(28),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            decoration: InputDecoration(
                              hintText: '0',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.width(20),
                                vertical: ResponsiveHelper.height(16),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isVerified = null;
                                _aiMessage = null;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(20),
                            vertical: ResponsiveHelper.height(16),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                ResponsiveHelper.radius(16),
                              ),
                              bottomLeft: Radius.circular(
                                ResponsiveHelper.radius(16),
                              ),
                            ),
                          ),
                          child: Text(
                            'جنيه',
                            style: GoogleFonts.cairo(
                              fontSize: ResponsiveHelper.fontSize(18),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isVerifying ? null : _verifyPrice,
                      icon: _isVerifying
                          ? SizedBox(
                              width: ResponsiveHelper.width(20),
                              height: ResponsiveHelper.width(20),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                              ),
                            )
                          : Icon(
                              Icons.verified_rounded,
                              size: ResponsiveHelper.width(20),
                            ),
                      label: Text(
                        _isVerifying
                            ? 'جاري التحقق...'
                            : 'التحقق من السعر بالذكاء الاصطناعي',
                        style: GoogleFonts.cairo(
                          fontSize: ResponsiveHelper.fontSize(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.height(16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.radius(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (_aiMessage != null) ...[
                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Verification Result
                    PriceVerificationBadge(
                      isVerified: _isVerified!,
                      message: _aiMessage!,
                    ),
                  ],

                  if (_isVerified != null) ...[
                    SizedBox(height: ResponsiveHelper.height(24)),

                    // Price Info
                    _buildPriceInfo(),
                  ],

                  SizedBox(height: ResponsiveHelper.height(20)),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: EdgeInsets.all(ResponsiveHelper.width(20)),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: CustomStepButton(
                    text: 'السابق',
                    onPressed: widget.onBack,
                    isPrimary: false,
                  ),
                ),
                SizedBox(width: ResponsiveHelper.width(12)),
                Expanded(
                  flex: 2,
                  child: CustomStepButton(
                    text: 'التالي',
                    onPressed: _saveAndNext,
                    isEnabled: canProceed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final area = widget.data['area'] ?? 100;
    final pricePerMeter = price / area;

    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            'سعر المتر المربع',
            '${pricePerMeter.toStringAsFixed(0)} جنيه',
          ),
          Divider(height: ResponsiveHelper.height(16)),
          _buildInfoRow('المساحة', '$area م²'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.tajawal(
            fontSize: ResponsiveHelper.fontSize(14),
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
