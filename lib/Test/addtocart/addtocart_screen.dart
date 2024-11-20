part of 'addtocart_import.dart';

class AddtocartScreen extends StatefulWidget {
  const AddtocartScreen({super.key});

  @override
  State<AddtocartScreen> createState() => _AddtocartScreenState();
}

class _AddtocartScreenState extends State<AddtocartScreen> {
  //list

  List data = [
    'apple',
    'samsung',
    'motorola',
    'infix',
    'vivo',
    'opp',
    'mi',
    'realm'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Data"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]),
                trailing: MaterialButton(
                  elevation: 10,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DataScreen(data: data[index])));
                  },
                  child: Icon(Icons.shopping_bag_outlined),
                ),
              );
            }),
      ),
    );
  }
}
