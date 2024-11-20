part of 'test_import.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final PostBloc postBloc = PostBloc();

  @override
  void initState() {
    postBloc.add(PostInitialsEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Interview"),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          bloc: postBloc,
          listenWhen: (previous, current) => current is PostActionState,
          buildWhen: (previous, current) => current is! PostActionState,
          listener: (context, state) {
            if (state is PostFetchingDataErrorState) {
              return null;
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is PostFetchingDataSuccessfullyState) {
              return ListView.builder(
                  itemCount: state.post.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.post[index].title.toString()),
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
