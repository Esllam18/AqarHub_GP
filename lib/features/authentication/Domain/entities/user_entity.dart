import 'package:equatable/equatable.dart';
import '../../../../core/enums/user_role.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final UserRole role;
  final String? city;
  final DateTime createdAt;
  final bool isProfileComplete;

  const UserEntity({
    required this.uid,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.photoUrl,
    required this.role,
    this.city,
    required this.createdAt,
    required this.isProfileComplete,
  });

  String get displayName =>
      '${firstName ?? ''} ${lastName ?? ''}'.trim().isEmpty
      ? phoneNumber ?? email ?? 'مستخدم'
      : '${firstName ?? ''} ${lastName ?? ''}'.trim();

  @override
  List<Object?> get props => [
    uid,
    phoneNumber,
    email,
    firstName,
    lastName,
    photoUrl,
    role,
    city,
    createdAt,
    isProfileComplete,
  ];
}
