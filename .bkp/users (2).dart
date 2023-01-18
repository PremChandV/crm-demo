// ignore_for_file: file_names

/*import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
//import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

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
  //PageController page = PageController();
  //SideMenuController sideMenu = SideMenuController();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();

  String msg = '';

  Future/*<List>*/ senddata() async {
    var response = await http
        .post(Uri.parse("http://localhost/login/register.php"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    }, body: {
      "lastname": name.text/*.toString()*/,
      "email": email.text/*.toString()*/,
      "mobile": mobile.text/*.toString()*/,
    });
    var datauser = jsonDecode(response.body);
    if (datauser == 0) {
      setState(() {
        //msg = "New User added SUccessfully..!";
      });
    } else {
      setState(() {
        //msg = "The User is already Existing..!";
      });
    }
    return const UsersPage(
      title: '',
    );
  }

  // ignore: unused_field
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  final List<String> items = ['Account', 'Profile', 'Logout'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users"), actions: <Widget>[
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
                //selectedValue = value as String;
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
          ],
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            //alignment: Alignment.center,
            /*child: const Padding(
              padding: EdgeInsets.all(50.0),
            ), */
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ), //Border.all
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    3.0,
                    3.0,
                  ), //Offset
                  blurRadius: 10.0,
                  //spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Column(
              children: <Widget>[
                const Text(
                  "Username",
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(hintText: 'Enter Your Name'),
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: email,
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Email Id'),
                ),
                const Text(
                  "Mobile",
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: mobile,
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Mobile No.'),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () {
                    senddata;
                  },
                ),
                const SizedBox(height: 30.0),
                Text(
                  msg,
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
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

/*class SideMenuController {
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
}*/  */
