import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 9, 156, 129)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
    print(favorites);
  }

  void toggleDelete() {
    favorites.clear();
    notifyListeners();
    print(favorites);
  }

  String toggleShow() {
    return favorites.toString();
    // notifyListeners();
    // print(favorites);
  }
}

/*
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    String titulo = 'APP-3';
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 194, 209, 205),
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BigCardShowList(pair: pair, appState: appState),
            BigCard(pair: pair),
            Row(
              mainAxisSize: MainAxisSize.min,

              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Boton(appState: appState),
                BotonLike(appState: appState, icon: icon),
                BotonDisLike(appState: appState),
                ElevatedButton(
                  onPressed: () {
                    titulo = 'APP-4';
                  },
                  child: Row(
                    children: [Text('APP-4')],
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/

// ...

class MyHomePage extends StatefulWidget {
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
        page = GeneratorPage();
        break;
      case 1:
       page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

class Boton extends StatelessWidget {
  const Boton({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        appState.getNext();
      },
      child: Text('Next'),
    );
  }
}

class BotonLike extends StatelessWidget {
  final MyAppState appState;
  final icon;

  const BotonLike({super.key, required this.appState, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        appState.toggleFavorite();
      },
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        children: [Text('Like'), Icon(icon)],
      ),
    );
  }
}

class BotonDisLike extends StatelessWidget {
  const BotonDisLike({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        appState.toggleDelete();
      },
      child: Row(
        children: [Text('No Like'), Icon(Icons.heart_broken)],
      ),
    );
  }
}

//cartas para mostrar datos
class BigCardShowList extends StatelessWidget {
  final WordPair pair;
  final MyAppState appState;

  const BigCardShowList(
      {super.key, required this.pair, required this.appState});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          appState.toggleShow(),
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final WordPair pair;

  const BigCard({
    super.key,
    required this.pair,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}