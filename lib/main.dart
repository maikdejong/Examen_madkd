import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

void main() {
  runApp(const ProductsApp());
}

bool _isSwitched = false;

class ProductsApp extends StatefulWidget {
  const ProductsApp({super.key});

  @override
  State<ProductsApp> createState() => ProductsAppState();

  static ProductsAppState of(BuildContext context) =>
      context.findAncestorStateOfType<ProductsAppState>()!;
}

class ProductsAppState extends State<ProductsApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MADkd',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      home: NavigationWidget(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class NavigationWidget extends StatefulWidget {
  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget widget;

    Map<int, Widget> widgets = {
      0: HomeWidget(),
      1: ProductsWidget(),
      2: ContactWidget(),
      3: SettingsWidget(),
    };

    widget = widgets[selectedIndex] ?? HomeWidget();

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 700,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.production_quantity_limits),
                    label: Text('Products'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.contact_page),
                    label: Text('Contact'),
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.settings), 
                      label: Text('Settings')),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = (value);
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: widget,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a list of 100 cards containing a text widget with it's index
    // and render it using a ResponsiveGridList

    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: ResponsiveGridList(
        horizontalGridMargin: 50,
        verticalGridMargin: 50,
        minItemWidth: 100,
        children: List.generate(
          100,
          (index) => ColoredBox(
            color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                '$index',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body:
          const Center(child: Text('Act like this page is the Contact page.')),
    );
  }
}

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading:
                _isSwitched ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
            title: _isSwitched
                ? Text('Turn off the light')
                : Text('Turn on the light'),
            trailing: Switch(
              value: _isSwitched,
              onChanged: (value) {
                setState(() {
                  _isSwitched = value;
                });
                _isSwitched
                    ? ProductsApp.of(context).changeTheme(ThemeMode.light)
                    : ProductsApp.of(context).changeTheme(ThemeMode.dark);
              },
            ),
          ),
        ],
      ),
    );
  }
}
