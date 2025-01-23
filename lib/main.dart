import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Navigation with Counters',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

/// The top-level [HomeScreen] that holds the bottom navigation bar
/// and an [IndexedStack] of navigators (one per tab).
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The current index of the selected tab in the BottomNavigationBar.
  int _currentIndex = 0;

  /// Each tab gets its own [NavigatorState] via a [GlobalKey].
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  /// Intercept the system back button or any "back" pop from the scaffold.
  Future<bool> _onWillPop() async {
    final currentNavigatorState = _navigatorKeys[_currentIndex].currentState!;
    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    }
    return true;
  }

  /// A helper to build a Navigator for a given [index].
  Widget _buildNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (RouteSettings settings) {
        switch (index) {
          case 0:
            return _buildPage1Routes(settings);
          case 1:
            return _buildPage2Routes(settings);
          case 2:
            return _buildPage3Routes(settings);
          default:
            return MaterialPageRoute(builder: (_) => const Page1());
        }
      },
    );
  }

  /// Route table for tab #0 (Page1, Page1.1)
  Route _buildPage1Routes(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const Page1();
        break;
      case '/page1_1':
        page = const Page1_1();
        break;
      default:
        page = const Page1();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  /// Route table for tab #1 (Page2 and subpages).
  /// Includes Page3.1 and Page3.2 for cross-navigation.
  Route _buildPage2Routes(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const Page2();
        break;
      case '/page2_1':
        page = const Page2_1();
        break;
      case '/page3_1':
        // We'll pass route arguments (the counter) into Page3.1.
        page = const Page3_1();
        break;
      case '/page3_2':
        page = const Page3_2();
        break;
      default:
        page = const Page2();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  /// Route table for tab #2 (Page3 and subpages).
  /// Includes Page2.1 for cross-navigation.
  Route _buildPage3Routes(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const Page3();
        break;
      case '/page3_1':
        // We'll pass route arguments (the counter) into Page3.1.
        page = const Page3_1();
        break;
      case '/page3_1_1':
        page = const Page3_1_1();
        break;
      case '/page3_2':
        page = const Page3_2();
        break;
      case '/page2_1':
        page = const Page2_1();
        break;
      default:
        page = const Page3();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            _buildNavigator(0),
            _buildNavigator(1),
            _buildNavigator(2),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_one),
              label: 'Page1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              label: 'Page2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_3),
              label: 'Page3',
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Page 1 & Subpage -------------------

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Page1 counter: $counter'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => counter++),
              child: const Text('Increment'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/page1_1');
              },
              child: const Text('Go to Page1.1'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1_1 extends StatefulWidget {
  const Page1_1({Key? key}) : super(key: key);

  @override
  State<Page1_1> createState() => _Page1_1State();
}

class _Page1_1State extends State<Page1_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page1.1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back to Page1'),
        ),
      ),
    );
  }
}

// ------------------- Page 2 & Subpage -------------------

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  /// The counter for Page2
  int _counter = 0;

  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Slider value: $_sliderValue'),
              const SizedBox(height: 16),
              Slider(
                value: _sliderValue,
                onChanged: (val) => setState(() => _sliderValue = val),
                min: 0,
                max: 100,
              ),
              const SizedBox(height: 16),
              Text('Page2 counter: $_counter'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() => _counter++),
                child: const Text('Increment Page2 counter'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/page2_1'),
                child: const Text('Go to Page2.1'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                // Pass the current Page2 counter to Page3.1
                onPressed: () => Navigator.of(context)
                    .pushNamed('/page3_1', arguments: _counter),
                child: const Text('Go to Page3.1 with Page2\'s counter'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/page3_2'),
                child: const Text('Go to Page3.2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page2_1 extends StatefulWidget {
  const Page2_1({Key? key}) : super(key: key);

  @override
  State<Page2_1> createState() => _Page2_1State();
}

class _Page2_1State extends State<Page2_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2.1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is Page2.1'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/page3_1'),
              child: const Text('Go to Page3.1'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/page3_2'),
              child: const Text('Go to Page3.2'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back to Page2'),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Page 3 & Subpages -------------------

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  /// The counter for Page3
  int _counter = 0;

  String text = "Hello from Page3!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            const SizedBox(height: 16),
            Text('Page3 counter: $_counter'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _counter++),
              child: const Text('Increment Page3 counter'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // Pass the current Page3 counter to Page3.1
              onPressed: () => Navigator.of(context)
                  .pushNamed('/page3_1', arguments: _counter),
              child: const Text('Go to Page3.1 with Page3\'s counter'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/page3_2'),
              child: const Text('Go to Page3.2'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Page3.1 can display the counter passed as an argument from Page2 or Page3.
class Page3_1 extends StatefulWidget {
  const Page3_1({Key? key}) : super(key: key);

  @override
  State<Page3_1> createState() => _Page3_1State();
}

class _Page3_1State extends State<Page3_1> {
  String userNote = "This is Page3.1";

  /// We'll store the "origin" counter here.
  int? _originCounter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Grab any passed arguments from the route.
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      _originCounter = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no counter was provided, default to 0 for display.
    final counterToShow = _originCounter ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page3.1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userNote),
            const SizedBox(height: 8),
            Text(
              'Counter from previous page: $counterToShow',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/page3_1_1'),
              child: const Text('Go to Page3.1.1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/page2_1'),
              child: const Text('Go to Page2.1'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page3_1_1 extends StatefulWidget {
  const Page3_1_1({Key? key}) : super(key: key);

  @override
  State<Page3_1_1> createState() => _Page3_1_1State();
}

class _Page3_1_1State extends State<Page3_1_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page3.1.1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back to Page3.1'),
        ),
      ),
    );
  }
}

class Page3_2 extends StatefulWidget {
  const Page3_2({Key? key}) : super(key: key);

  @override
  State<Page3_2> createState() => _Page3_2State();
}

class _Page3_2State extends State<Page3_2> {
  String info = "Welcome to Page3.2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page3.2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(info),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/page2_1'),
              child: const Text('Go to Page2.1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back to Page3'),
            ),
          ],
        ),
      ),
    );
  }
}
