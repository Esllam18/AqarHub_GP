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
