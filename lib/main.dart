import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math'; // Import the dart:math library

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocks App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StockPage(),
    );
  }
}

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  static const String apiKey = 'Uuc2J73WWc22LcUhvpmhZcPjPptbRLbE';
  static const String apiUrl =
      'https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2023-01-09?adjusted=true&apiKey=$apiKey';

  List<Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    updateStockPricesPeriodically();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming the data structure is as mentioned in your example.
        final List<dynamic> results = data['results'];
        stocks = results.map((result) => Stock.fromJson(result)).toList();
        updateStockPricesInFile();
      } else {
        print('Failed to fetch stocks: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching stocks: $error');
    }
  }

  Future<void> updateStockPricesInFile() async {
    final file = File('stock_prices.json');
    final List<Map<String, dynamic>> stockDataList = [];

    for (final stock in stocks) {
      stock.refreshInterval = Duration(seconds: Random().nextInt(5) + 1);
      stock.currentPrice = stock.previousClose + Random().nextDouble();

      stockDataList.add({
        'name': stock.name,
        'price': stock.currentPrice,
      });
    }

    await file.writeAsString(json.encode(stockDataList));
    // Call setState to trigger a UI update.
    setState(() {});
  }

  void updateStockPricesPeriodically() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateStockPricesInFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          return ListTile(
            title: Text('${stock.name} - \$${stock.currentPrice.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

class Stock {
  String name;
  double previousClose;
  Duration refreshInterval;
  double currentPrice;

  Stock({
    required this.name,
    required this.previousClose,
    required this.refreshInterval,
    required this.currentPrice,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['T'],
      previousClose: json['c'].toDouble(),
      refreshInterval: Duration(seconds: 1), // Default to 1 second.
      currentPrice: 0.0, // Default to 0.0.
    );
  }
}
