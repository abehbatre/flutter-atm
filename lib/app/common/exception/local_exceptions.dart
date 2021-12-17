import 'package:equatable/equatable.dart';

class LocalException extends Equatable {
  @override
  List<Object?> get props => [];

  final String message;

  LocalException(this.message);
}
