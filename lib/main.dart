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
      title: 'Nested Navigation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

/// The top-level [HomeScreen] that holds the bottom navigation bar and an [IndexedStack] of navigators.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The current index of the selected tab in the bottom navigation bar.
  int _currentIndex = 0;

  /// Each tab gets its own [NavigatorState] via a [GlobalKey].
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  /// If the current tab can pop, pop it. If it can't, allow the system back to close the app.
  Future<bool> _onWillPop() async {
    final currentNavigatorState = _navigatorKeys[_currentIndex].currentState!;
    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false; // We handled the pop.
    }
    return true; // Let the system handle it (i.e., close the app if at root).
  }

  /// Builds a [Navigator] for each tab index.
  /// Each navigator handles its own route stack (subpages).
  Widget _buildNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (index) {
          case 0:
            page = _buildPage1Routes(settings);
            break;
          case 1:
            page = _buildPage2Routes(settings);
            break;
          case 2:
            page = _buildPage3Routes(settings);
            break;
          default:
            page = const Page1(); // Fallback
        }

        return MaterialPageRoute<dynamic>(
          builder: (_) => page,
          settings: settings,
        );
      },
    );
  }

  Widget _buildPage1Routes(RouteSettings settings) {
    switch (settings.name) {
      // Default route:
      case '/':
        return const Page1();
      case '/page1_1':
        return const Page1_1();
      default:
        return const Page1();
    }
  }

  Widget _buildPage2Routes(RouteSettings settings) {
    switch (settings.name) {
      // Default route:
      case '/':
        return const Page2();
      default:
        return const Page2();
    }
  }

  Widget _buildPage3Routes(RouteSettings settings) {
    switch (settings.name) {
      // Default route:
      case '/':
        return const Page3();
      case '/page3_1':
        return const Page3_1();
      case '/page3_1_1':
        return const Page3_1_1();
      default:
        return const Page3();
    }
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
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
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

//
// Below are all the separate pages as stateful widgets.
//

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
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
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
        // The default back button automatically appears
        // as long as this isn't the initial route of the Navigator.
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

// ------------------- Page 2 (No subpage in example) -------------------
class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2'),
      ),
      body: Center(
        child: Slider(
          value: sliderValue,
          onChanged: (val) {
            setState(() {
              sliderValue = val;
            });
          },
          min: 0,
          max: 100,
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/page3_1');
              },
              child: const Text('Go to Page3.1'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page3_1 extends StatefulWidget {
  const Page3_1({Key? key}) : super(key: key);

  @override
  State<Page3_1> createState() => _Page3_1State();
}

class _Page3_1State extends State<Page3_1> {
  String userNote = "This is Page3.1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page3.1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userNote),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/page3_1_1');
              },
              child: const Text('Go to Page3.1.1'),
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
