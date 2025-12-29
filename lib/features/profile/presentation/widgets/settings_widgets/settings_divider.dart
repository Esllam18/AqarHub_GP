import 'package:flutter/material.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: ResponsiveHelper.width(60),
      endIndent: ResponsiveHelper.width(16),
      color: Colors.grey.shade200,
    );
  }
}
