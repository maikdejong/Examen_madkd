import 'package:flutter/material.dart';

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
      4: NewHomeWidget(),
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
                      icon: Icon(Icons.settings), label: Text('Settings')),
                  NavigationRailDestination(
                      icon: Icon(Icons.holiday_village), label: Text('test')),
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

class NewHomeWidget extends StatelessWidget {
  const NewHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/coffeebackground.png'),
        //     fit: BoxFit.cover,
        //   )
        // ),

        // child: ListView(
        //   // This next line does the trick.
        //   scrollDirection: Axis.horizontal,
        //   children: <Widget>[
        //     Container(
        //       width: 160,
        //     ),
        //     SizedBox(
        //       width: 200, // Set the desired width
        //       height: 50, // Set the desired height
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Button action
        //         },
        //         child: Text('Button'),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 200, // Set the desired width
        //       height: 50, // Set the desired height
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Button action
        //         },
        //         child: Text('Button'),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 200, // Set the desired width
        //       height: 50, // Set the desired height
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Button action
        //         },
        //         child: Text('Button'),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 200, // Set the desired width
        //       height: 50, // Set the desired height
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Button action
        //         },
        //         child: Text('Button'),
        //       ),
        //     ),
        //   ],
        // ),


      ),
    );
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
      // body: FittedBox(
      //   child: Image.asset('images/coffee.png',
      //   fit: BoxFit.fill,
      //   )
      // )
    );
  }
}

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: const Center(
          child: Text('Act like this page is filled with products.')),
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
