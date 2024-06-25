class UserReg {
  final String username;
  final String password;
  final String email;

  UserReg({required this.username, required this.password, required this.email});

  // Factory constructor to create a UserReg from a JSON object
  factory UserReg.fromJson(Map<String, dynamic> json) {
    return UserReg(
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }

  // Method to convert UserReg instance to JSON object
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
