// lib/services/stock_service.dart
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class StockService {
  static Future<List<Stock>> fetchStockData(int numberOfStocks) async {
    final apiKey = 'Uuc2J73WWc22LcUhvpmhZcPjPptbRLbE';
    final uri = Uri.parse('https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2023-01-09/2023-01-09?apiKey=$apiKey');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse the response and return a list of Stock objects limited by numberOfStocks
      // Update the 'price' field of existing stocks
      // Return the updated list of stocks
      return <Stock>[]; // Replace with actual parsing logic
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}
