class AppUser {
  final String id;
  String name;
  String email;
  String password;
  bool isOrganizer;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.isOrganizer = false,
  });
}