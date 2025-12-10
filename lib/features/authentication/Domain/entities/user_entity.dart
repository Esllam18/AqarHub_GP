import 'package:equatable/equatable.dart';
import '../../../../core/enums/user_role.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final String? city;
  final UserRole role;
  final DateTime createdAt;
  final bool isProfileComplete;

  const UserEntity({
    required this.uid,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.city,
    required this.role,
    required this.createdAt,
    required this.isProfileComplete,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    phoneNumber,
    firstName,
    lastName,
    photoUrl,
    city,
    role,
    createdAt,
    isProfileComplete,
  ];
}
