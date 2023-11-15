import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

// import 'package:responsive_grid_list/responsive_grid_list.dart';
// import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(ProductsApp());
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
                      icon: Icon(Icons.settings), label: Text('Settings')),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(children: [
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              List<Widget> productWidgets = [];

              if (snapshot.hasData) {
                final products = snapshot.data?.docs.reversed.toList();
                for (var product in products!) {
                  final productWidget = Card(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(height: 100, child: Image.asset('images/coffeelogo.png')),
                            Text(product['name']),
                            SizedBox(width: 10),
                            Text('Quantity:'),
                            Text(product['quantity'].toString()),
                          ],
                        ),
                      ],
                    ),
                  );
                  productWidgets.add(productWidget);
                }
              }

              return Column(
                // Wrap the productWidgets list in a Column widget
                children: productWidgets,
              );

            }),
      ]),
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
      body: ContactUs(
        cardColor: _isSwitched ? Colors.black : Colors.white,
        textColor: _isSwitched ? Colors.white : Colors.black,
        logo: const AssetImage('images/coffeelogo.png'),
        email: 'maik-de-jong@live.nl',
        companyName: 'Koffiewinkel',
        companyColor: _isSwitched ? Colors.black : Colors.white,
        dividerThickness: 1,
        phoneNumber: '+310615493504',
        website: 'http://maik.fc.school/',
        githubUserName: 'Maikdejong',
        tagLine: 'Maik de Jong',
        taglineColor: _isSwitched ? Colors.black : Colors.white,
      ),
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
