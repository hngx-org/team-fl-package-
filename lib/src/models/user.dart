class User {
  final String id;
  final String name;
  final String email;
  final DateTime ? createdAt;
  final DateTime ? updatedAt;
  final int ? credits;
  final String ? cookie;

  @override
  String toString() => 'User Created Succesfully';


  User( {
    required this.id,
    required this.name,
    required this.email,
     this.createdAt,
     this.updatedAt,
     this.credits,
     this.cookie,
  });
}
