import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';
import 'package:provider/provider.dart';

void main() async{
  await SystemTheme.accentColor.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final accentColor = SystemTheme.accentColor.accent;
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme:  ColorScheme.fromSeed(seedColor: accentColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SevenUpSevenDown'),
    ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  bool fightStage = false;
  int playerTurn = 0;
  int roundNumber = 0;
  List<int> score = [0, 0, 0, 0];
  List<int> expectedWins = [0, 0, 0, 0];
  List<String> _names = ['Kasper', 'Erik', 'Claudia', 'Niek'];
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }
  void _subtractCounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }
  void _undo() {
    playerTurn--;
    _counter = expectedWins[playerTurn];
    notifyListeners();
  }
  void _submitExpectedWins() {
    expectedWins[playerTurn] = _counter;
    if (playerTurn < 3) {
      playerTurn++;
    } else {
      playerTurn = 0;
    }
    _counter = 0;
    notifyListeners();
  }

}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = ExpectedWinsPage();
        break;
      case 1:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');

    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      page
    );
  }
}

class ExpectedWinsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var _names = appState._names;
    var score = appState.score;
    var expectedWins = appState.expectedWins;
    var _counter = appState._counter;
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Title(color: Colors.black, child: const Text('Round 1', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold))),
          Text('P1 ${expectedWins[0]} P2 ${expectedWins[1]} P3 ${expectedWins[2]} P3 ${expectedWins[3]}'),
          ExpectedWinsCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.large(
                onPressed: appState._subtractCounter,
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 20),
              FloatingActionButton.large(
                  onPressed: appState._incrementCounter,
                  child: const Icon(Icons.add)
              ),
            ],
          ),
          const SizedBox(height:30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: appState._undo, child: Text('undo turn')),
              const SizedBox(width:20),
              ElevatedButton(onPressed: appState._submitExpectedWins, child: Text('Submit')),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(color:Colors.green, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [Text(_names[0]), Text('${score[0]}')]),
                )
                ),
                Card(color:Colors.deepOrange, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [Text(_names[1]), Text('${score[1]}')]),
                )
                ),
                Card(color:Colors.blue, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [Text(_names[2]), Text('${score[2]}')]),
                )
                ),
                Card(color:Colors.deepPurple, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [Text(_names[3]), Text('${score[3]}')]),
                )
                ),
              ]

          )
        ],
      ),
    );
  }
}
class ExpectedWinsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        child: Center(
          child: Text(
            '${appState._counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
