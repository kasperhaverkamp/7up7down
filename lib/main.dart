import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
  bool fightStage = false;
  int playerTurn = 0;
  int roundNumber = 0;
  int _counter = 0;
  List<int> expectedWins = [0, 0, 0, 0];
  List<int> score = [0, 0, 0, 0];
  List<String> _names = ['Kasper', 'Erik', 'Claudia', 'Niek'];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _subtractCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _submitExpectedWins() {
      setState(() {
        expectedWins[playerTurn] = _counter;
        if (playerTurn < 3) {
          playerTurn++;
        } else {
          playerTurn = 0;
        }
        _counter = 0;
      });

    }
  void _undo() {
    setState(() {
      playerTurn--;
      expectedWins[playerTurn] = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    String name1 = '';
    setState(() => name1 = _names[0]);
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

      Center(
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
            Text('P1 ${expectedWins[0]} P2 ${expectedWins[1]} P3 ${expectedWins[2]} P3 ${expectedWins[3]}'),
            ExpectedWinsCard(counter: _counter),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                    onPressed: _subtractCounter,
                    child: const Icon(Icons.remove),
                ),
               const SizedBox(width: 20),
               FloatingActionButton.large(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add)
                ),
              ],
            ),
        SizedBox(height:30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _undo, child: Text('undo turn')),
            ElevatedButton(onPressed: _submitExpectedWins, child: Text('Submit')),
          ],
        ),

        DataTable(
          columns: <DataColumn> [
            DataColumn(label: Text('Round')),
            DataColumn(label: Text(_names[0])),
            DataColumn(label: Text(_names[1])),
            DataColumn(label: Text(_names[2])),
            DataColumn(label: Text(_names[3])),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('0')),
                DataCell(Text('$_counter')),
                DataCell(Text('Student')),
                DataCell(Text('Student')),
                DataCell(Text('Student'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('1')),
                DataCell(Text('43')),
                DataCell(Text('Professor')),
                DataCell(Text('Student')),
                DataCell(Text('Student'))
              ],
            ),

            DataRow(
              cells: <DataCell>[
                DataCell(Text('2')),
                DataCell(Text('27')),
                DataCell(Text('Associate Professor')),
                DataCell(Text('Student')),
                DataCell(Text('Student'))
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('2')),
                DataCell(Text('27')),
                DataCell(Text('Associate Professor')),
                DataCell(Text('Student')),
                DataCell(Text('Student'))
              ],
            ),
          ],
        )
          ],
        ),
      ),
    );
  }
}

class ExpectedWinsCard extends StatelessWidget {
  const ExpectedWinsCard({
    super.key,
    required int counter,
  }) : _counter = counter;

  final int _counter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        child: Center(
          child: Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
