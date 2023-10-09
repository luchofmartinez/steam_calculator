// ignore_for_file: public_member_api_docs, sort_constructors_first
class Game {
  double? value;
  List<Tax>? taxes;

  Game({
    this.value,
    this.taxes,
  });

  @override
  String toString() => 'Game(value: $value, taxes: $taxes)';
}

class Tax {
  String description;
  double percentage;
  double value;

  Tax({
    required this.description,
    required this.percentage,
    required this.value,
  });

  @override
  String toString() =>
      'Tax(description: $description, percentage: $percentage, value: $value)';
}
