enum UserRole {
  user,
  owner,
  guest;

  String get name {
    switch (this) {
      case UserRole.user:
        return 'user';
      case UserRole.owner:
        return 'owner';
      case UserRole.guest:
        return 'guest';
    }
  }

  static UserRole fromString(String role) {
    switch (role) {
      case 'owner':
        return UserRole.owner;
      case 'guest':
        return UserRole.guest;
      default:
        return UserRole.user;
    }
  }
}
