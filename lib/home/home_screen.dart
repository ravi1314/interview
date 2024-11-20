part of 'home_import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool music = false, geography = false, general = false, mathematics = false;
  bool isAnswer = false;
  String? question, answer;
  List<String> options = [];
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    fetchQuiz("music");
  }

  Future<void> fetchQuiz(String category) async {
    setState(() {
      question = null;
      answer = null;
      options.clear();
    });

    var url = 'https://api.api-ninjas.com/v1/trivia?category=$category';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'X-Api-Key': '5SHE+KmHZstRTxdKqNzhXw==t4yTY7aZufB03KII'
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> quiz = jsonData[0];
        setState(() {
          question = quiz['question'];
          answer = quiz['answer'];
        });
        await generateOptions();
      }
    } else {
      // Handle the error appropriately
      print("Failed to fetch quiz data: ${response.statusCode}");
    }
  }

  Future<void> generateOptions() async {
    options.clear();
    if (answer != null) {
      options.add(answer!);

      while (options.length < 4) {
        var url = 'https://api.api-ninjas.com/v1/randomword';
        var response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'X-Api-Key': '5SHE+KmHZstRTxdKqNzhXw==t4yTY7aZufB03KII'
        });

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = jsonDecode(response.body);
          if (jsonData.isNotEmpty) {
            String word = jsonData['word'].toString();
            if (!options.contains(word)) {
              options.add(word);
            }
          }
        } else {
          print("Failed to fetch random word: ${response.statusCode}");
        }
      }

      // Shuffle the options
      options.shuffle(Random());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: options.length != 4
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Category selection buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            categoryButton("Music", "music"),
                            SizedBox(width: 10),
                            categoryButton("Geography", "geography"),
                            SizedBox(width: 10),
                            categoryButton("General", "general"),
                            SizedBox(width: 10),
                            categoryButton("Mathematics", "mathematics"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Question box
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        child: Container(
                          height: 470,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  question ?? "Loading question...",
                                  style: TextStyle(fontSize: 22),
                                ),
                                SizedBox(height: 18),

                                // Options
                                ...options.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  String optionText = entry.value;
                                  return optionWidget(index, optionText);
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget categoryButton(String text, String category) {
    bool isSelected;
    switch (category) {
      case "music":
        isSelected = music;
        break;
      case "geography":
        isSelected = geography;
        break;
      case "general":
        isSelected = general;
        break;
      case "mathematics":
        isSelected = mathematics;
        break;
      default:
        isSelected = false;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          music = category == "music";
          geography = category == "geography";
          general = category == "general";
          mathematics = category == "mathematics";
        });
        fetchQuiz(category);
      },
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.black,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget optionWidget(int index, String optionText) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = optionText;
          isAnswer = selectedOption == answer;
        });
      },
      child: Container(
        height: 50,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedOption == optionText
                ? (isAnswer ? Colors.green : Colors.red)
                : Colors.black,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(String.fromCharCode(65 + index)), // A, B, C, D
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    optionText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
