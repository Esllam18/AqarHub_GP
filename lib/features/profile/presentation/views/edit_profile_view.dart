import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:aqar_hub_gp/core/consts/app_colors.dart';
import 'package:aqar_hub_gp/core/utils/responsive_helper.dart';
import '../widgets/edit_profile_widgets/profile_image_picker.dart';
import '../widgets/edit_profile_widgets/profile_text_field.dart';
import '../widgets/edit_profile_widgets/save_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'أحمد محمد علي');
  final _emailController = TextEditingController(text: 'ahmed@example.com');
  final _phoneController = TextEditingController(text: '+20 100 123 4567');
  final _bioController = TextEditingController(
    text: 'مستثمر عقاري مهتم بالعقارات السكنية',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveHelper.width(16)),
            child: Column(
              children: [
                SizedBox(height: ResponsiveHelper.height(20)),
                const ProfileImagePicker(
                  imageUrl: 'https://i.pravatar.cc/150?img=12',
                ),
                SizedBox(height: ResponsiveHelper.height(32)),
                _buildFormFields(),
                SizedBox(height: ResponsiveHelper.height(32)),
                SaveButton(onPressed: _handleSave),
                SizedBox(height: ResponsiveHelper.height(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'تعديل الملف الشخصي',
        style: GoogleFonts.cairo(
          fontSize: ResponsiveHelper.fontSize(18),
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        ProfileTextField(
          controller: _nameController,
          label: 'الاسم الكامل',
          icon: Icons.person_rounded,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال الاسم';
            }
            return null;
          },
        ),
        SizedBox(height: ResponsiveHelper.height(16)),
        ProfileTextField(
          controller: _emailController,
          label: 'البريد الإلكتروني',
          icon: Icons.email_rounded,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال البريد الإلكتروني';
            }
            if (!value.contains('@')) {
              return 'البريد الإلكتروني غير صحيح';
            }
            return null;
          },
        ),
        SizedBox(height: ResponsiveHelper.height(16)),
        ProfileTextField(
          controller: _phoneController,
          label: 'رقم الهاتف',
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال رقم الهاتف';
            }
            return null;
          },
        ),
        SizedBox(height: ResponsiveHelper.height(16)),
        ProfileTextField(
          controller: _bioController,
          label: 'نبذة عنك',
          icon: Icons.info_rounded,
          maxLines: 3,
          validator: null,
        ),
      ],
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'تم حفظ التغييرات بنجاح',
              style: GoogleFonts.tajawal(color: Colors.white),
            ),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
          ),
        ),
      );
      context.pop();
    }
  }
}
