import 'package:equatable/equatable.dart';

abstract class ColorblindTestState extends Equatable {
  const ColorblindTestState();
}

class TestInitialState extends ColorblindTestState {
  const TestInitialState();

  @override
  List<Object?> get props => [];
}

class TestInitiating extends ColorblindTestState {
  const TestInitiating();

  @override
  List<Object?> get props => [];
}

class TestInitiated extends ColorblindTestState {
  const TestInitiated();

  @override
  List<Object?> get props => [];
}

class TestNextPalate extends ColorblindTestState {
  const TestNextPalate(this.answer);

  final String answer;

  @override
  List<Object?> get props => [answer, DateTime.now()];
}

class TestFinish extends ColorblindTestState {
  const TestFinish();

  @override
  List<Object?> get props => [];
}