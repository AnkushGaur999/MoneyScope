class UserEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String country;
  final double monthlyIncome;
  final String empType;
  String? profileImagePath;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.monthlyIncome,
    required this.empType,
    this.profileImagePath,
  });

}
