// lib/models/stock_model.dart
class Stock {
  final String symbol;
  final String companyName;
  double price;

  Stock({
    required this.symbol,
    required this.companyName,
    required this.price,
  });
}
