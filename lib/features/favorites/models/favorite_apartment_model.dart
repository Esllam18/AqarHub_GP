class FavoriteApartmentModel {
  final String id;
  final String title;
  final String location;
  final String image;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final bool isVerified;
  final double rating;
  final DateTime addedDate;

  FavoriteApartmentModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isVerified = false,
    this.rating = 0.0,
    required this.addedDate,
  });
}
