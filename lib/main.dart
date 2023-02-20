import 'index.dart';
import 'admin/users.dart';
import 'admin/clients.dart';
import 'admin/reports.dart';
import 'admin/payments.dart';
import 'admin/products.dart';
import 'admin/admin_page.dart';
import 'manager/ManagerPage.dart';
import 'package:flutter/material.dart';

/*void main() => runApp(const MyApp(
      title: '',
    )); */

void main() {
  //HttpOverrides.global = new MyHttpOverrides();
  //HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp(
    title: '',
  ));
}

String username = '';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    return MaterialApp(
      //theme: buildTheme(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      title: 'CRM - SSS',
      home: const IndexPage(
          //title: '',
          ),
      routes: <String, WidgetBuilder>{
        '/MainPage': (BuildContext context) => const MyApp(
              title: '',
            ),
        '/AdminPage': (BuildContext context) => const AdminPage(
              title: 'Admin Page',
              //username: '',
            ),
        '/ManagerPage': (BuildContext context) => const ManagerPage(
              username: '',
            ),
        '/UsersPage': (BuildContext context) => UsersPage(context),
        '/ProductsPage': (BuildContext context) => const ProductsPage(
              // title: 'Products',
            ),
        '/ClientsPage': (BuildContext context) => const ClientsPage(
              title: 'Clients',
            ),
        '/ReportsPage': (BuildContext context) => const ReportsPage(
              title: 'Clients',
            ),
        '/PaymentsPage': (BuildContext context) => const PaymentsPage(
              title: 'Clients',
            ),
        //'/MyLoginPage': (BuildContext context) => const MyLoginPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/settings":
          //return MaterialPageRoute(builder: (context) => const Settings());
          case "/MainPage":
            return MaterialPageRoute(
                builder: (context) => const MyApp(
                      title: '',
                    ));
          default:
            return MaterialPageRoute(
                builder: (context) => const MyApp(
                      title: '',
                    ));
        }
      },
    );
  }

  /*ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      //hintColor: Colors.purple,
      //primaryColor: Colors.yellow,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.blue,
        ),
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
      ),
    );
  } */
}
