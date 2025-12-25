import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/consts/home_strings.dart';
import 'package:aqar_hub_gp/core/widgets/custom_text.dart';

class EmptyApartmentsState extends StatelessWidget {
  const EmptyApartmentsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.apartment,
                size: 100,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 30),
            // Title
            const CustomText(
              txt: HomeStrings.noPropertiesTitle,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Subtitle
            CustomText(
              txt: HomeStrings.noPropertiesSubtitle,
              fontSize: 16,
              color: Colors.grey.shade600,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Action Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to Add Apartment
              },
              icon: const Icon(Icons.add),
              label: const Text(HomeStrings.addProperty),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
