import 'package:equatable/equatable.dart';

class LocalException extends Equatable {
  const LocalException({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => <Object>[];
}
