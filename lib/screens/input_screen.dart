// lib/screens/input_screen.dart
import 'package:flutter/material.dart';
import 'stock_list_screen.dart';

class InputScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Number of Stocks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter number of stocks'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                int numberOfStocks = int.tryParse(_controller.text) ?? 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockListScreen(numberOfStocks: numberOfStocks),
                  ),
                );
              },
              child: Text('Load Stocks'),
            ),
          ],
        ),
      ),
    );
  }
}
