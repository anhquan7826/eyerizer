import 'package:equatable/equatable.dart';

abstract class ColorblindTestState extends Equatable {
  const ColorblindTestState();
}

class TestInitial extends ColorblindTestState {
  const TestInitial();

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