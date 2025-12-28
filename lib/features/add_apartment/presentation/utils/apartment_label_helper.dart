class ApartmentLabelHelper {
  static String getTypeLabel(String? type) {
    const typeLabels = {
      'apartment': 'شقة',
      'villa': 'فيلا',
      'studio': 'استوديو',
      'penthouse': 'بنتهاوس',
      'duplex': 'دوبلكس',
      'chalet': 'شاليه',
    };
    return typeLabels[type] ?? type ?? 'غير محدد';
  }

  static String getAmenityLabel(String amenity) {
    const amenityLabels = {
      'wifi': 'واي فاي',
      'parking': 'موقف سيارات',
      'elevator': 'مصعد',
      'ac': 'تكييف',
      'security': 'حراسة',
      'pool': 'حمام سباحة',
      'gym': 'جيم',
      'garden': 'حديقة',
      'balcony': 'بلكونة',
      'furnished': 'مفروش',
      'kitchen': 'مطبخ',
      'laundry': 'غسالة',
      'dishwasher': 'غسالة أطباق',
      'heating': 'تدفئة',
      'intercom': 'انتركم',
      'cctv': 'كاميرات مراقبة',
      'pet_friendly': 'يسمح بالحيوانات',
      'sea_view': 'إطلالة بحرية',
      'city_view': 'إطلالة على المدينة',
      'smart_home': 'منزل ذكي',
    };
    return amenityLabels[amenity] ?? amenity;
  }
}
