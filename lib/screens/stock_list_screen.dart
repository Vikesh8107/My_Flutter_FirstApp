// lib/screens/stock_list_screen.dart
import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/stock_service.dart';

class StockListScreen extends StatefulWidget {
  final int numberOfStocks;

  const StockListScreen({Key? key, required this.numberOfStocks}) : super(key: key);

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  late List<Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    _fetchStockData(widget.numberOfStocks);
  }

  Future<void> _fetchStockData(int numberOfStocks) async {
    try {
      List<Stock> updatedStocks = await StockService.fetchStockData(numberOfStocks);
      setState(() {
        stocks = updatedStocks;
      });
    } catch (e) {
      print('Error fetching stock data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Viewer - ${widget.numberOfStocks} Stocks'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _fetchStockData(widget.numberOfStocks);
        },
        child: ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(stocks[index].companyName),
              subtitle: Text(
                '${stocks[index].symbol} - ${stocks[index].price.toStringAsFixed(2)}',
              ),
            );
          },
        ),
      ),
    );
  }
}
