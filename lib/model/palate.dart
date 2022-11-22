import 'colorblind_type.dart';

enum PalateType {
  number,
  line,
}

class Palate {
  Palate({required this.file, required this.answers, this.type = PalateType.number});

  final String file;
  final Map<ColorblindType, String> answers;
  final PalateType type;
}