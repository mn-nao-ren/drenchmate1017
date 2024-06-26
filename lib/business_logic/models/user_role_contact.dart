

class UserRoleContact {
  final String contactNumber;
  final String role;

  UserRoleContact({required this.contactNumber, required this.role});

  Map<String, dynamic> toMap() {
    return {
      'contactNumber': contactNumber,
      'role': role,
    };
  }

  // Basic validation method
  bool isValid() {
    return contactNumber.isNotEmpty && role.isNotEmpty;
  }
}
