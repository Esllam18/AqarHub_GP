import 'package:aqar_hub_gp/features/authentication/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/enums/user_role.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    super.phoneNumber,
    super.email,
    super.firstName,
    super.lastName,
    super.photoUrl,
    required super.role,
    super.city,
    required super.createdAt,
    required super.isProfileComplete,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      photoUrl: data['photoUrl'],
      role: UserRole.fromString(data['role'] ?? 'user'),
      city: data['city'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isProfileComplete: data['isProfileComplete'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'phoneNumber': phoneNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'role': role.name,
      'city': city,
      'createdAt': Timestamp.fromDate(createdAt),
      'isProfileComplete': isProfileComplete,
    };
  }

  UserModel copyWith({
    String? uid,
    String? phoneNumber,
    String? email,
    String? firstName,
    String? lastName,
    String? photoUrl,
    UserRole? role,
    String? city,
    DateTime? createdAt,
    bool? isProfileComplete,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }
}
