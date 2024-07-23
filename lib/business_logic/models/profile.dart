class Profile {
  final String userId;
  final String username;
  final String email;
  final String role; // Owner, editor, etc.
  final String propertyId; // ID of the property the user has access to
  final List<String> permissions;
  final DateTime createdAt;

  Profile({
    required this.userId,
    required this.username,
    required this.email,
    required this.propertyId,
    required this.role,
    List<String>? permissions, // Allow null and default to empty list
    DateTime? createdAt, // Allow null and default to current date
  })  : permissions = permissions ?? [],
        createdAt = createdAt ?? DateTime.now();

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'role': role,
      'propertyId': propertyId,
      'permissions': permissions,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Firestore Map
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      propertyId: map['propertyId'] ?? '',
      role: map['role'] ?? '',
      permissions: List<String>.from(map['permissions'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
