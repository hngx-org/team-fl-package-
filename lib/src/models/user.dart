/// A class representing a user with various attributes.
///
/// This class represents a user in the application and includes properties
/// such as [id], [name], [email], [createdAt], [updatedAt], [credits], and [cookie].
/// It is used to store user information and is designed to be flexible with optional
/// properties for certain user attributes.
class User {
  /// The unique identifier of the user.
  final String id;

  /// The name of the user.
  final String name;

  /// The email address of the user.
  final String email;

  /// The created at date which is optional.
  final DateTime? createdAt;

  /// The updated at date which is optional.
  final DateTime? updatedAt;

  /// The credit of the user.
  final int? credits;

  /// The cookie of the user.
  final String? cookie;

  /// The date and time when the user was created (optional).
  final DateTime? createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
    this.credits,
    this.cookie,
  });

  /// Returns a string representation of a user creation message.
  @override
  String toString() => 'User Created Successfully';
}
