import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String? message;

  const SignUpState({this.message});

  SignUpState copyWith({String? message}) {
    return SignUpState(message: message ?? this.message);
  }

  @override
  List<Object?> get props => [message];
}
