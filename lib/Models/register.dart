class Register {
  String username;
  String email;
  String password;

  Register({
  required this.username,
      required this.email,
      required this.password,});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        username: json['userName'],
        email: json['email'],
        password: json['password'],);
  }
}
