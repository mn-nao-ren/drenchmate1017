
class Property {

  String ownerEmail;
  String propertyName;
  String location;
  DateTime createdAt;

  Property({

    required this.ownerEmail,
    required this.propertyName,
    required this.location,
    required this.createdAt,
  });

  // Convert a Property instance to a map
  Map<String, dynamic> toMap() {
    return {

      'ownerEmail': ownerEmail,
      'propertyName': propertyName,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a Property instance from a map
  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(

      ownerEmail: map['ownerEmail'],
      propertyName: map['propertyName'],
      location: map['location'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }


  @override
  String toString() {
    return 'Property{ownerEmail: $ownerEmail, propertyName: $propertyName, location: $location, createdAt: $createdAt}';
  }

}