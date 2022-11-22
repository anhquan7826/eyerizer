import 'colorblind_type.dart';
import 'palate.dart';

class IshiharaTestModel {
  IshiharaTestModel() {
    palates = List.generate(38, (index) {
      switch (index + 1) {
        case 1:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.any: '12',
            },
          );
        case 2:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '8',
              ColorblindType.redGreen: '3',
            },
          );
        case 3:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '6',
              ColorblindType.redGreen: '5',
            },
          );
        case 4:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '29',
              ColorblindType.redGreen: '70',
            },
          );
        case 5:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '57',
              ColorblindType.redGreen: '35',
            },
          );
        case 6:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '5',
              ColorblindType.redGreen: '2',
            },
          );
        case 7:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '3',
              ColorblindType.redGreen: '5',
            },
          );
        case 8:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '15',
              ColorblindType.redGreen: '17',
            },
          );
        case 9:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '74',
              ColorblindType.redGreen: '21',
            },
          );
        case 10:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '2',
              ColorblindType.redGreen: '-1',
            },
          );
        case 11:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '6',
              ColorblindType.redGreen: '-1',
            },
          );
        case 12:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '91',
              ColorblindType.redGreen: '-1',
            },
          );
        case 13:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '45',
              ColorblindType.redGreen: '-1',
            },
          );
        case 14:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '5',
              ColorblindType.redGreen: '-1',
            },
          );
        case 15:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '7',
              ColorblindType.redGreen: '-1',
            },
          );
        case 16:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '16',
              ColorblindType.redGreen: '-1',
            },
          );
        case 17:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '73',
              ColorblindType.redGreen: '-1',
            },
          );
        case 18:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: 'Nothing.',
              ColorblindType.redGreen: '5',
            },
          );
        case 19:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: 'Nothing.',
              ColorblindType.redGreen: '2',
            },
          );
        case 20:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: 'Nothing.',
              ColorblindType.redGreen: '45',
            },
          );
        case 21:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: 'Nothing.',
              ColorblindType.redGreen: '73',
            },
          );
        case 22:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '26',
              ColorblindType.protanopia: '6',
              ColorblindType.deuteranopia: '2',
            },
          );
        case 23:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '42',
              ColorblindType.protanopia: '2',
              ColorblindType.deuteranopia: '4',
            },
          );
        case 24:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '35',
              ColorblindType.protanopia: '5',
              ColorblindType.deuteranopia: '3',
            },
          );
        case 25:
          return Palate(
            file: '${index + 1}.jpg',
            answers: {
              ColorblindType.normal: '96',
              ColorblindType.protanopia: '6',
              ColorblindType.deuteranopia: '9',
            },
          );
        case 26:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Purple and red spots.',
              ColorblindType.protanopia: 'Purple line.',
              ColorblindType.deuteranopia: 'Red line.',
            },
          );
        case 27:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Purple and red spots.',
              ColorblindType.protanopia: 'Purple line.',
              ColorblindType.deuteranopia: 'Red line.',
            },
          );
        case 28:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Nothing.',
              ColorblindType.redGreen: 'A line.',
            },
          );
        case 29:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Nothing.',
              ColorblindType.redGreen: 'A line.',
            },
          );
        case 30:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Blue-green line.',
              ColorblindType.redGreen: 'Nothing.',
            },
          );
        case 31:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Blue-green line.',
              ColorblindType.redGreen: 'Nothing.',
            },
          );
        case 32:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Orange line.',
              ColorblindType.redGreen: 'False line or nothing.',
            },
          );
        case 33:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Orange line.',
              ColorblindType.redGreen: 'False line or nothing.',
            },
          );
        case 34:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Blue-green and yellow-green line.',
              ColorblindType.redGreen: 'Red-green and violet line.',
            },
          );
        case 35:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Blue-green and yellow-green line.',
              ColorblindType.redGreen: 'Blue-green and violet line.',
            },
          );
        case 36:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Violet and orange line.',
              ColorblindType.redGreen: 'Blue-green and violet line.',
            },
          );
        case 37:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.normal: 'Violet and orange line.',
              ColorblindType.redGreen: 'Blue-green and violet line',
            },
          );
        case 38:
          return Palate(
            file: '${index + 1}.jpg',
            type: PalateType.line,
            answers: {
              ColorblindType.any: 'A line.',
            },
          );
      }
      return Palate(file: '01.jpg', answers: {});
    });
  }

  late final List<Palate> palates;
}
