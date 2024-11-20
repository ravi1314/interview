part of 'counter_import.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterBloc counterBloc = CounterBloc();

  @override
  void initState() {
    super.initState();
    // Dispatch the initial event to set up the state
    counterBloc.add(CounterInitialsEvent());
  }

  @override
  void dispose() {
    // Dispose of the bloc when the screen is disposed to avoid memory leaks
    counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter App with BLoC")),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          bloc: counterBloc,
          builder: (context, state) {
            int counterValue = 0; // Default counter value
            if (state is CounterInitial) {
              counterValue = 0;
            } else if (state is CounterIncrementState) {
              counterValue = state.val;
            } else if (state is CounterDecrementState) {
              counterValue = state.val;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$counterValue',
                  style: TextStyle(fontSize: 60),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      elevation: 10,
                      color: Colors.blue,
                      onPressed: () {
                        counterBloc.add(CounterIncrementEvent());
                      },
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    MaterialButton(
                      elevation: 10,
                      color: Colors.red,
                      onPressed: () {
                        counterBloc.add(CounterDecrementEvent());
                      },
                      child: Text(
                        "-",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}