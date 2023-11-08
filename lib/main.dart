import 'package:flutter/material.dart';

void main() {
  runApp(const ProductsApp());
}

class ProductsApp extends StatefulWidget {
  const ProductsApp({super.key});

  @override
  State<ProductsApp> createState() => _ProductsAppState();
}

class _ProductsAppState extends State<ProductsApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MADkd',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: NavigationWidget(),
    );
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
                    label: Text('Settings')
                    ),
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
      body: const Center(
          child: Text('Act like this page is filled with useful information.')),
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
      body: const Center(
          child: Text('Act like this page is the Contact page.')),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: const Center(
          child: Text('Act like this page is the Settings page.')),
    );
  }
}