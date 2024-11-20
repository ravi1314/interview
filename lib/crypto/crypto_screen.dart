part of 'crypto_import.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  List<CryptoModel> cryptoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCrypto();
  }

  Future<void> fetchCrypto() async {
    var url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data) {
          // Check if item is not null and contains the expected data
          if (item != null) {
            try {
              cryptoList.add(CryptoModel.fromJson(item));
            } catch (e) {
              print("Error parsing crypto item: $e");
            }
          }
          setState(() {
            cryptoList;
          });
        }
      }
    } catch (e) {
      print("Error fetching data: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          'CRYPTOBASE',
          style: TextStyle(color: Colors.grey[900]),
        ),
      ),
      body: ListView.builder(
        itemCount: cryptoList.length,
        itemBuilder: (BuildContext context, int index) {
          var crypto = cryptoList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CryptoDetail(cryptoModel: crypto)));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 20,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          color: Colors.white,
                          child: Container(
                            height: 66,
                            width: 66,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                crypto.image ?? '',
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crypto.name ?? 'Unknown',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              crypto.symbol?.toUpperCase() ?? 'N/A',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              crypto.currentPrice?.toStringAsFixed(2) ?? '0.00',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              crypto.priceChange24h != null
                                  ? crypto.priceChange24h! >= 0
                                      ? '+${crypto.priceChange24h!.toStringAsFixed(2)}'
                                      : '${crypto.priceChange24h!.toStringAsFixed(2)}'
                                  : '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: crypto.priceChange24h != null &&
                                        crypto.priceChange24h! >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Text(
                              crypto.marketCap?.toStringAsFixed(0) ?? '0',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
