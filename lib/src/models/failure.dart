/// A class representing a failure with a specific error message.
///
/// This class is used to handle and communicate failures and error messages
/// within the application. It includes a [message] property to store the error
/// message and provides methods to create an instance from an error map and to
/// convert the instance to a string for debugging and logging purposes.
class Failure {
  /// The error message associated with the failure.
  final String message;

  /// Create a [Failure] instance with the given [message].
  Failure(
    this.message,
  );

  /// Factory method to create a [Failure] instance from an error map.
  factory Failure.fromHttpErrorMap(Map<String, dynamic> json) => Failure(
        json["message"],
      );

  /// Returns a string representation of the [Failure] instance.
  @override
  String toString() => 'Failure(message: $message)';
}
