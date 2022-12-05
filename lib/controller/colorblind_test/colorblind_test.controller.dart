import 'package:eyerizer/controller/colorblind_test/colorblind_test.state.dart';
import 'package:eyerizer/model/colorblind_type.dart';
import 'package:eyerizer/model/palate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/ishihara_test_model.dart';

class ColorblindTestController extends Cubit<ColorblindTestState> {
  ColorblindTestController() : super(const TestInitialState()) {
    init();
  }

  late final IshiharaTestModel testModel;

  void init() {
    emit(const TestInitiating());
    testModel = IshiharaTestModel();
    Future.delayed(const Duration(milliseconds: 1000), () => emit(const TestInitiated()));
  }

  int _currentPalate = 0;
  Palate get currentPalate => testModel.palates[_currentPalate];
  final Map<Palate, String> _results = {};

  void submitAnswer(String answer) {
    _results[currentPalate] = answer;
    _currentPalate++;
    if (_currentPalate == testModel.palates.length) {
      emit(const TestFinish());
    } else {
      emit(TestNextPalate(answer));
    }
  }

  ColorblindType get result {
    final ratings = <ColorblindType, int>{
      ColorblindType.normal: 0,
      ColorblindType.redGreen: 0,
      ColorblindType.deuteranopia: 0,
      ColorblindType.protanopia: 0,
      ColorblindType.any: 0,
    };
    for (final entry in _results.entries) {
      final answers = entry.key.answers;
      final choice = entry.value;
      if (answers.containsValue(choice)) {
        final key = answers.entries.firstWhere((element) => element.value == choice).key;
        ratings[key] = ratings[key]! + 1;
      } else {
        ratings[ColorblindType.any] = ratings[ColorblindType.any]! + 1;
      }
    }
    var maxRating = ratings.entries.first;
    for (final rate in ratings.entries) {
      if (rate.value > maxRating.value) {
        maxRating = rate;
      }
    }
    return maxRating.key;
  }
}