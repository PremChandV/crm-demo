// ignore_for_file: file_names

/*import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'AdminPage.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  final List<String> items = ['Account', 'Profile', 'Logout'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin - Users"), actions: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                Icon(Icons.account_circle_rounded,
                    size: 20, color: Colors.white),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            //value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
                /*if (value == 0) {
                      setState(() {
                      });
                    } */
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            iconSize: 20,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.grey,
            buttonHeight: 50,
            buttonWidth: 160,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            /*buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ), 
                  color: Colors.blueGrey,
                ), */
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        ),
      ]),
      drawer: Drawer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              //controller: sideMenu,
              controller: page,
              style: SideMenuStyle(
                //showTooltip: false,
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
                      color: Colors.black54,
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
                  //backgroundBlendMode: BlendMode.color
                ), /*backgroundColor: Colors.black12*/
              ),
              title: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 150,
                      maxWidth: 150,
                    ),
                    child: Image.asset(
                      'assets/images/crm_logo.png',
                    ),
                  ),
                  const Divider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                ],
              ),
              footer: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '_____',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AdminPage(title: 'Dashboard')),
                    );
                  },
                  icon: const Icon(Icons.home),
                  tooltipContent: "Dashboard",
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Users',
                  onTap: () {
                    //sideMenu.changePage(const AdminUsersPage());
                    //setState(() => const AdminUsersPage());
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UsersPage(title: 'Users'))); */
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UsersPage(
                                title: 'Users',
                              )),
                    );
                  },
                  icon: const Icon(Icons.assignment_ind),
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Products',
                  onTap: (page, _) {
                    sideMenu.changePage(const UsersPage(
                      title: '',
                    ));
                  },
                  icon: const Icon(Icons.ballot),
                  /*trailing: Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                        'New',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    )), */
                ),
                SideMenuItem(
                  priority: 3,
                  title: 'Clients',
                  onTap: (page, _) {
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.supervisor_account),
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Reports',
                  onTap: (page, _) {
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.analytics),
                ),
                /* SideMenuItem(
                 priority: 5,
                 onTap:(page){
                   sideMenu.changePage(5);
                 },
                 icon: const Icon(Icons.image_rounded),
               ),
               SideMenuItem(
                 priority: 6,
                 title: 'Only Title',
                 onTap:(page){
                   sideMenu.changePage(6);
                 },
               ), */
                const SideMenuItem(
                  priority: 7,
                  title: 'Payments',
                  icon: Icon(Icons.credit_card),
                ),
              ],
            ),
            /*Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Title',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Icon',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ), */
          ],
        ),
      ),

      body: Column(
          /*children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 40.0)),
          const Center(
              child: Text(
            'Hello..! ',
            style: TextStyle(fontSize: 20.0),
          )),
          const Padding(padding: EdgeInsets.only(top: 40.0)),
          ElevatedButton(
            child: const Text("Log Out"),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, '/MainPage');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp(title: "")),
              );
            },
          ),
        ], */
          ),

//    'Copyrights' code stars from here...
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
//    'Copyrights' code ends here...
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
} */
