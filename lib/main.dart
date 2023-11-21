import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _isSwitched = prefs.getBool('isSwitched') ?? false;
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

  void changeTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeModeIndex = prefs.getInt('themeMode');
    if (themeModeIndex != null) {
      setState(() {
        _themeMode = ThemeMode.values[themeModeIndex];
      });
    }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _isSwitched
                    ? AssetImage('images/coffeebackground2.png')
                    : AssetImage('images/coffeebackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Coffee',
                fontSize: 75,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: _isSwitched ? Colors.black : Colors.white,
            fontSize: 30,
            fontFamily: 'Coffee'),
        title: Text('Products'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data?.docs.toList();
              return Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 8.0,
                spacing: 8.0,
                children: products!.map((product) {
                  var quantity = int.parse(product['quantity'].toString());

                  return Offstage(
                    offstage: quantity == 0,
                    child: Card(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 195,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: FittedBox(
                                    fit: BoxFit.contain, 
                                    child: Image.asset(
                                      product['imagePath'],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(product['name']),
                              SizedBox(height: 10),
                              Text('Quantity: $quantity'),
                              SizedBox(height: 10),
                              Text('Price: €${product['price']}'),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 0) {
                                          quantity--;
                                          FirebaseFirestore.instance
                                              .collection('products')
                                              .doc(product.id)
                                              .update({'quantity': quantity});
                                        }
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                        FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(product.id)
                                            .update({'quantity': quantity});
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }

            return Container(); // Return an empty container if there's no data
          },
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
        titleTextStyle: TextStyle(
            color: _isSwitched ? Colors.black : Colors.white,
            fontSize: 30,
            fontFamily: 'Coffee'),
        title: Text('Contact'),
      ),
      body: ContactUs(
        cardColor: _isSwitched ? Colors.teal : Colors.white,
        textColor: _isSwitched ? Colors.white : Colors.black,
        logo: _isSwitched ? const AssetImage('images/coffeelogo.png') : const AssetImage('images/coffeelogodark.png'),
        email: 'maik-de-jong@live.nl',
        companyName: 'Koffiewinkel',
        companyColor: _isSwitched ? Colors.black : Colors.white,
        dividerThickness: 1,
        phoneNumber: '+310615493504',
        website: 'http://maik.fc.school/',
        githubUserName: 'Maikdejong',
        tagLine: 'Maik de Jong',
        taglineColor: Colors.teal,
        companyFont: 'Coffee',
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
        titleTextStyle: TextStyle(
            color: _isSwitched ? Colors.black : Colors.white,
            fontSize: 30,
            fontFamily: 'Coffee'),
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
              onChanged: (value) async{
                setState(() {
                  _isSwitched = value;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isSwitched', value);
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
