class Profile {
  final String userId;
  final String username;
  final String email;
  final String propertyId; // ID of the property the user has access to

  Profile({
    required this.userId,
    required this.username,
    required this.email,
    required this.propertyId,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'propertyId': propertyId,
    };
  }

  // Convert from Firestore Map
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      userId: map['userId'] ?? '',
      username: map['name'] ?? '',
      email: map['email'] ?? '',
      propertyId: map['propertyId'] ?? '',
    );
  }
}
