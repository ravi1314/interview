class Stock {
  final String ticker;
  final String name;
  final String price;
  final String exchange;
  final String currency;

  Stock({
    required this.ticker,
    required this.name,
    required this.price,
    required this.exchange,
    required this.currency,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      ticker: json['ticker'] ?? '',
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '',
      exchange: json['exchange'] ?? '',
      currency: json['currency'] ?? '',
    );
  }
}
