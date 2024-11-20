part of 'onboarding_import.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool music = true,
      mathematics = false,
      geography = false,
      sciencenature = false,
      isanswer = false;

  String? question, answer;
  List<String> option = [];
  String? selectedOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restOption().then((_) => fetchQuiz("music"));
  }

  Future<void> fetchQuiz(String category) async {
    var url = 'https://api.api-ninjas.com/v1/trivia?category=$category';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'X-Api-Key': '5SHE+KmHZstRTxdKqNzhXw==t4yTY7aZufB03KII'
    });
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> quiz = jsonData[0];
        question = quiz['question'];
        answer = quiz['answer'];
      }
      setState(() {});
    }
  }

  Future<void> restOption() async {
    var url = 'https://api.api-ninjas.com/v1/randomword';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'X-Api-Key': '5SHE+KmHZstRTxdKqNzhXw==t4yTY7aZufB03KII'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        String word = jsonData['word'].toString();
        option.add(word);
      }
      if (option.length < 4) {
        restOption();
      } else {
        shuffelelist();
      }
      print(option.toString());
      setState(() {});
    }
  }

  void shuffelelist() {
    option = List.from(option)..shuffle(Random());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: option.length != 4
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  music = true;
                                  mathematics = false;
                                  geography = false;
                                  sciencenature = false;
                                  option = [];
                                  await restOption();
                                  await fetchQuiz("music");
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: music
                                                ? Colors.deepOrange
                                                : Colors.black)),
                                    child: Material(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Center(child: Text('music')),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  music = false;
                                  mathematics = true;
                                  geography = false;
                                  sciencenature = false;
                                  option = [];
                                  await restOption();
                                  await fetchQuiz("mathematics");
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: mathematics
                                                ? Colors.deepOrange
                                                : Colors.black)),
                                    child: Material(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Center(child: Text('mathematics')),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  music = false;
                                  mathematics = false;
                                  geography = true;
                                  sciencenature = false;
                                  option = [];
                                  await restOption();
                                  await fetchQuiz("geography");
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: geography
                                                ? Colors.deepOrange
                                                : Colors.black)),
                                    child: Material(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Center(child: Text('geography')),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  music = false;
                                  mathematics = false;
                                  geography = false;
                                  sciencenature = true;
                                  option = [];
                                  await restOption();
                                  await fetchQuiz("sciencenature");
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: sciencenature
                                                ? Colors.deepOrange
                                                : Colors.black)),
                                    child: Material(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      elevation: 10,
                                      color: Colors.white,
                                      child:
                                          Center(child: Text('sciencenature')),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //question  box
                    Expanded(
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 500,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  question ?? 'Loading question',
                                  style: TextStyle(fontSize: 27),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = option[
                                          0]; // Store the selected option
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: selectedOption == null
                                              ? Colors.black
                                              : selectedOption == answer
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          option[0].replaceAll(
                                              RegExp(r'[/[\]]'), ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = option[
                                          1]; // Store the selected option
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: selectedOption == null
                                              ? Colors.black
                                              : selectedOption == answer
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          option[1].replaceAll(
                                              RegExp(r'[/[\]]'), ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = option[
                                          2]; // Store the selected option
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: selectedOption == null
                                              ? Colors.black
                                              : selectedOption == answer
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          option[2].replaceAll(
                                              RegExp(r'[/[\]]'), ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = option[
                                          3]; // Store the selected option
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: selectedOption == null
                                              ? Colors.black
                                              : selectedOption == answer
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          option[3].replaceAll(
                                              RegExp(r'[/[\]]'), ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
