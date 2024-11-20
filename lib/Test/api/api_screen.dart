part of 'api_import.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<PostModel> post = [];
  List<PostModel> cart = []; // List to store cart items

  bool isLoading = true; // Add a loading state

  Future<void> getData() async {
    var url = 'https://fakestoreapi.com/products';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          post =
              data.map<PostModel>((item) => PostModel.fromJson(item)).toList();
          isLoading = false; // Set loading to false once data is loaded
        });
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Data"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: post.length,
              itemBuilder: (context, index) {
                return Material(
                  elevation: 10,
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(post[index].image.toString()),
                    ),
                    title: Text(post[index].title.toString()),
                    subtitle: Text("Rs.${post[index].price.toString()}"),
                    trailing: MaterialButton(
                      elevation: 10,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          cart.add(post[index]);
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataScreen(data: cart)));
                      },
                      child: Text("Add to Cart"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
