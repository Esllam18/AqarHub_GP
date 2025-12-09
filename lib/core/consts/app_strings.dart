// ============================================
// lib/core/consts/app_strings.dart
// ============================================

class OnboardingStrings {
  // ====== Page 1 ======
  static const String page1Title = 'ابحث عن سكنك بسهولة';
  static const String page1Description =
      'استكشف الشقق القريبة منك بسرعة وسهولة، واختر المكان الذي يناسبك من بين العديد من الخيارات الموثوقة.';

  // ====== Page 2 ======
  static const String page2Title = 'تواصل مباشرة مع المالك';
  static const String page2Description =
      'وداعًا للوسطاء! تواصل مع أصحاب الشقق مباشرة دون عمولات أو تأخير، واطلب التفاصيل التي تهمك.';

  // ====== Page 3 ======
  static const String page3Title = 'احجز وادفع بأمان';
  static const String page3Description =
      'احجز شقتك المفضلة وادفع بطريقة آمنة وسهلة من داخل التطبيق، مع ضمان موثوقية العملية بالكامل.';

  // ====== Buttons ======
  static const String buttonNext = 'التالي';
  static const String buttonSkip = 'تخطي';
  static const String buttonStart = 'ابدأ الآن';
}

// ============================================
// Strings used globally in the app
// ============================================

class AppStrings {
  static const String appName = 'AqarHub';
  static const String loading = 'جاري التحميل...';
  static const String noInternet = 'لا يوجد اتصال بالإنترنت';
  static const String tryAgain = 'حاول مرة أخرى';
}

class AuthStrings {
  // Welcome Screen
  static const String welcomeTitle = 'مرحباً بك في عقار هاب';
  static const String welcomeSubtitle = 'ابدأ رحلتك في عالم العقارات';
  static const String loginWithPhone = 'تسجيل الدخول برقم الجوال';
  static const String loginWithGoogle = 'تسجيل الدخول بجوجل';
  static const String continueAsGuest = 'الدخول كزائر';

  // Phone Auth
  static const String phoneAuthTitle = 'أدخل رقم جوالك';
  static const String phoneAuthSubtitle = 'سنرسل لك رمز التحقق';
  static const String phoneLabel = 'رقم الجوال';
  static const String phoneHint = '+966 5X XXX XXXX';
  static const String sendOtp = 'إرسال الرمز';

  // OTP Verification
  static const String otpTitle = 'تحقق من رقم جوالك';
  static const String otpSubtitle = 'أدخل الرمز المرسل إلى';
  static const String verifyButton = 'تحقق';
  static const String resendOtp = 'إعادة إرسال الرمز';
  static const String didntReceiveCode = 'لم تستلم الرمز؟';

  // Role Selection
  static const String roleTitle = 'اختر نوع حسابك';
  static const String roleSubtitle = 'يمكنك تغيير هذا لاحقاً';
  static const String roleUser = 'مستخدم';
  static const String roleUserDesc = 'أبحث عن عقار للإيجار أو الشراء';
  static const String roleOwner = 'مالك عقار';
  static const String roleOwnerDesc = 'أريد عرض عقاراتي للإيجار أو البيع';
  static const String continueButton = 'متابعة';

  // Complete Profile
  static const String completeProfileTitle = 'أكمل ملفك الشخصي';
  static const String completeProfileSubtitle = 'ساعدنا لنخدمك بشكل أفضل';
  static const String firstNameLabel = 'الاسم الأول';
  static const String lastNameLabel = 'اسم العائلة';
  static const String emailLabel = 'البريد الإلكتروني (اختياري)';
  static const String cityLabel = 'المدينة';
  static const String finishButton = 'إنهاء';

  // Common
  static const String skip = 'تخطي';
  static const String loading = 'جاري التحميل...';
}
