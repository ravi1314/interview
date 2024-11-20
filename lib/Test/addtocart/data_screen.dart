part of 'data_import.dart';

class DataScreen extends StatelessWidget {
  List<PostModel> data;
  DataScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.toString()),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Material(
              child: Container(
                height: 240,
                width: 300,
                child: Column(
                  children: [
                    Text(data[index].title.toString()),
                    Container(
                        height: 200,
                        child: Image.network(data[index].image.toString())),
                    Text("Rs ${data[index].price.toString()}")
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
