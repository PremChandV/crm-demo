// ignore_for_file: file_names, unnecessary_null_comparison, library_private_types_in_public_api, prefer_is_empty, duplicate_ignore
import 'dart:async';
import '../main.dart';
import 'sub_pages/add_user.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  //Create the (Global) Keys
  //final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();

  var appBarHeight = AppBar().preferredSize.height;

  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//============================== Appbar code here... ==============================
      appBar: AppBar(
          title: const Text("Admin Page"),
          leading: IconButton(
            onPressed: () {
              //on drawer menu pressed
              if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                //if drawer is open, then close the drawer
                Navigator.pop(context);
              } else {
                _drawerscaffoldkey.currentState?.openDrawer();
                //if drawer is closed then open the drawer.
              }
            },
            icon: const Icon(Icons.menu),
          ),
          actions: <Widget>[
            DropdownButtonHideUnderline(
//
              child: PopupMenuButton<int>(
                //padding: const EdgeInsets.only(right: 50.0),
                color: Colors.white,
                onSelected: (item) => onSelected(context, item),
                offset: Offset(-20.0, appBarHeight),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.account_circle_outlined /* person */,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 8),
                        Text('Account'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 8),
                        Text('Log Out'),
                      ],
                    ),
                  ),
                ],
              ),
//
            ),
          ]),
//
      body: Scaffold(
        //second scaffold
        key: _drawerscaffoldkey, //set gobal key defined above
//======================================== Drawer code here... ==========================
        /* drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Dashboard'),
                onTap: () {
                  //Navigator.pop(context, const AdminPage(title: 'Admin Page'));
                  Navigator.pushReplacementNamed(context, '/AdminPage');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.assignment_ind,
                ),
                title: const Text('Users'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.ballot,
                ),
                title: const Text('Products'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/ProductsPage');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.supervisor_account,
                ),
                title: const Text('Clients'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/ClientsPage');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.analytics,
                ),
                title: const Text('Reports'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/ReportsPage');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.credit_card,
                ),
                title: const Text('Payments'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/PaymentsPage');
                },
              ),
            ],
          ),
        ), */
        drawer: Row(children: [
          SideMenu(
            //controller: sideMenu,
            controller: page,
            style: SideMenuStyle(
              showTooltip: true,
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.blue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black12,
                border: Border(
                  right: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                /*boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ], */
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
                //backgroundBlendMode: BlendMode.color
              ), /*backgroundColor: Colors.black12*/
            ),
            title: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Image.asset(
                    'lib/assets/images/crm_logo.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                icon: const Icon(Icons.home),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/AdminPage');
                  //sideMenu.changePage(const AdminPage(title: 'Dashboard'));
                  /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminPage(title: 'Admin Page')),
                      ); */
                },
                tooltipContent: "Dashboard",
              ),
              SideMenuItem(
                priority: 1,
                title: 'Sales Team',
                icon: const Icon(Icons.assignment_ind),
                //GestureDetector(
                onTap: () {
                  //const UsersPage(title: 'title');
                  Navigator.pushReplacementNamed(context, '/UsersPage');
                  //sideMenu.changePage('/UsersPage');
                  //setState(() => const AdminUsersPage());
                  /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UsersPage(title: 'Users'))); */
                  /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UsersPage(
                                  title: 'Users',
                                )),
                      ); */
                },
                //
                /* new Column(
                    children: <Widget>[
                      // Only one of them is visible based on 'isMorning' condition
                        if (isMorning) Text('Good Morning')
                          else Text ('Good Evening'),
                    ],
                  ), */
                //
              ),
              SideMenuItem(
                priority: 2,
                title: 'Product Management',
                icon: const Icon(Icons.ballot),
                onTap: () {
                  //sideMenu.changePage(const UsersPage(title: '',));
                  Navigator.pushReplacementNamed(context, '/ProductsPage');
                },
              ),
              SideMenuItem(
                priority: 3,
                title: 'Client Management',
                icon: const Icon(Icons.supervisor_account),
                onTap: () {
                  //sideMenu.changePage(page);
                  Navigator.pushReplacementNamed(context, '/ClientsPage');
                },
              ),
              SideMenuItem(
                priority: 4,
                title: 'Report Generation',
                icon: const Icon(Icons.analytics),
                onTap: () {
                  //sideMenu.changePage(page);
                  Navigator.pushReplacementNamed(context, '/ReportsPage');
                },
              ),
              SideMenuItem(
                priority: 7,
                title: 'Payments',
                icon: const Icon(Icons.credit_card),
                onTap: () {
                  //sideMenu.changePage(page);
                  Navigator.pushReplacementNamed(context, '/PaymentsPage');
                },
              ),
            ],
            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '_____',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ]),
//====================================== Body Code Here... =============================
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 350.0, top: 70.0),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Admin Dashboard",
                      style: TextStyle(
                        fontSize: 25,
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("Admin Responsibilities",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.transparent,
                                decorationColor: Colors.grey,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -10))
                                ],
                                decoration: TextDecoration.underline,
                                decorationThickness: 1.0)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//Column - 1
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text("     1) User Management :",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Column(
                              children: const [
                                Text(
                                    "           - Create, update and delete the user.\n\n"
                                    "           - List and search the users.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Roboto_Light',
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: const [
                                Text("     2) Product Management :",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Column(
                              children: const [
                                Text(
                                    "             - Create, update and delete the product.\n\n"
                                    "             - List and search the products.\n\n"
                                    "             - Assign product to the sales manager",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Roboto_Light',
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 70.0,
                        ),
//Column - 2
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text("     3) Client Management  :",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Column(
                              children: const [
                                Text(
                                    "             - Create, update, and delete the client.\n\n"
                                    "             - List and search the clients.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Roboto_Light',
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: const [
                                Text("     4) Report Generation :",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Column(
                              children: const [
                                Text(
                                    "             - Sales managers and sales executives report generation.\n\n"
                                    "             - Print the reports.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Roboto_Light',
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      /* body: Center(
              child: Column(children: <Widget>[
            Row(
              children: const [
                Text("Admin Responsibilities",
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    )),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(100),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(200.0),
                children: [
                  TableRow(children: [
                    Column(children: const [
                      Text('User Management :', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: const [
                      Text('Client Management :', style: TextStyle(fontSize: 20.0))
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: const [Text('- Create, update and delete the user.')]),
                    Column(children: const [Text('')]),
                  ]),
                  TableRow(children: [
                    Column(children: const [Text('- List and search the users.')]),
                    Column(children: const [Text('MySQL')]),
                  ]),
                  TableRow(children: [
                    Column(children: const [Text('Javatpoint')]),
                    Column(children: const [Text('ReactJS')]),
                  ]),
                ],
              ),
            ),
          ]))), */
//======================== 'Copyrights' code stars from here... ====================
      bottomNavigationBar: const BottomAppBar(
          color: Colors.grey,
          child: SizedBox(
            width: 30.0,
            height: 30.0,
            child: Center(
                child: Text(
              "All rights are reserved @SSS - 2022",
              textAlign: TextAlign.center,
            )),
          )),
//========================= 'Copyrights' code ends here... =========================
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const AddUserPage(
                  title: '',
                )),
      );
      break;
    case 1:
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const MyApp(
                  title: '',
                )),
        (route) => false,
      );
  }
}

class SideMenuController {
  late int _currentPage;

  int get currentPage => _currentPage;

  SideMenuController({int initialPage = 0}) {
    _currentPage = initialPage;
  }
  final _streameController = StreamController<int>.broadcast();

  Stream<int> get stream => _streameController.stream;

  void changePage(index) {
    _currentPage = index;
    _streameController.sink.add(index);
  }

  void dispose() {
    _streameController.close();
  }

  void addListener(void Function(int) listener) {
    _streameController.stream.listen(listener);
  }

  void removeListener(void Function(int) listener) {
    _streameController.stream.listen(listener).cancel();
  }
}

class Global {
  static late SideMenuController controller;
  static late SideMenuStyle style;
  static DisplayModeNotifier displayModeState =
      DisplayModeNotifier(SideMenuDisplayMode.auto);
  static bool showTrailing = true;
  static List<Function> itemsUpdate = [];
}

class DisplayModeNotifier extends ValueNotifier<SideMenuDisplayMode> {
  DisplayModeNotifier(SideMenuDisplayMode value) : super(value);

  void change(SideMenuDisplayMode mode) {
    value = mode;
    notifyListeners();
  }
}
