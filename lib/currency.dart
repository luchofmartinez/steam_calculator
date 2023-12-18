List<Currency> currencyList = [
  Currency(description: 'ARS', enable: true),
  Currency(description: 'USD', enable: true)
];

class Currency {
  String description;
  bool enable;

  Currency({
    required this.description,
    this.enable = false,
  });
}
