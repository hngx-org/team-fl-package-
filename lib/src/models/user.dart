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

  /// The date and time when the user was created (optional).
  final DateTime? createdAt;

  /// The date and time when the user was last updated (optional).
  final DateTime? updatedAt;

  /// The number of credits associated with the user (optional).
  final int? credits;

  /// The user's session cookie (optional).
  final String? cookie;

  /// Create a [User] instance with the provided properties.
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
