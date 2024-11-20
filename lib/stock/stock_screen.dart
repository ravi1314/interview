part of 'stock_import.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List<Stock> stockList = [];

  @override
  void initState() {
    super.initState();
    fetchStock();
  }

  Future<void> fetchStock() async {
    var url = 'https://api.api-ninjas.com/v1/stockprice?ticker=AAPL';

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'X-Api-Key': '5SHE+KmHZstRTxdKqNzhXw==t4yTY7aZufB03KII'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        setState(() {
          stockList = [Stock.fromJson(jsonData)];
        });
      }
    } else {
      print('Failed to load stock data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: stockList.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: stockList.length,
                    itemBuilder: (context, index) {
                      Stock stock = stockList[index];
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ticker: ${stock.ticker}',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Company name : ${stock.name}",
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "price : ${stock.price} USD",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("exchange : ${stock.exchange}"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("currency : ${stock.currency}"),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
