class Failure {
  Failure(
    this.message,
  );

  final String message;

  factory Failure.fromHttpErrorMap(Map<String, dynamic> json) => Failure(
        json["message"],
      );

  @override
  String toString() => 'Failure(message: ${message.toString()})';
}
