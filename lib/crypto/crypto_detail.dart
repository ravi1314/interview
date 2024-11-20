part of 'crypto_detail_import.dart';

class CryptoDetail extends StatefulWidget {
  final CryptoModel cryptoModel;
  const CryptoDetail({super.key, required this.cryptoModel});

  @override
  State<CryptoDetail> createState() => _CryptoDetailState();
}

class _CryptoDetailState extends State<CryptoDetail> {
  late List<CryptoModel> chartData;

  @override
  void initState() {
    chartData = getChart();
    super.initState();
  }

  List<CryptoModel> getChart() {
    return <CryptoModel>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 70,
                          width: 70,
                          child: Image.network(widget.cryptoModel.image ?? '')),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cryptoModel.name.toString(),
                          style: const TextStyle(fontSize: 29),
                        ),
                        Text(widget.cryptoModel.symbol.toString())
                      ],
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    Text(
                      widget.cryptoModel.currentPrice.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 420,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(20),
                              child: SfCartesianChart(
                                series: [
                                  CandleSeries<CryptoModel, dynamic>(
                                      dataSource: chartData,
                                      xValueMapper: (CryptoModel sales, _) =>
                                          widget.cryptoModel.high24h,
                                      lowValueMapper: (CryptoModel sales, _) =>
                                          widget.cryptoModel.low24h,
                                      highValueMapper: (CryptoModel sales, _) =>
                                          widget.cryptoModel.totalVolume,
                                      openValueMapper: (CryptoModel sales, _) =>
                                          widget.cryptoModel.totalVolume,
                                      closeValueMapper:
                                          (CryptoModel sales, _) =>
                                              widget.cryptoModel.totalVolume)
                                ],
                              )),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.cryptoModel.name.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 230,
                            ),
                            Text(
                              widget.cryptoModel.currentPrice.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Market Cap : " +
                                widget.cryptoModel.marketCap.toString(),
                            style: const TextStyle(fontSize: 19),
                          ),
                          Text("Market Cap rank : " +
                              widget.cryptoModel.marketCapRank.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Today High : " + widget.cryptoModel.high24h.toString(),
                style: const TextStyle(color: Colors.green, fontSize: 17),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "Today Low : " + widget.cryptoModel.low24h.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Market Cap : " +
                                widget.cryptoModel.priceChangePercentage24h
                                    .toString(),
                            style: TextStyle(
                                fontSize: 19,
                                color: widget.cryptoModel
                                            .priceChangePercentage24h ==
                                        0
                                    ? Colors.red
                                    : Colors.green),
                          ),
                          Text("Market Cap rank : " +
                              widget.cryptoModel.marketCapRank.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
