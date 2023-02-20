// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, prefer_typing_uninitialized_variables, unused_field, constant_identifier_names, prefer_final_fields
// import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'admin_page.dart';
import 'sub_pages/add_user.dart';
import 'sub_pages/AddUpdateUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_sidemenu/easy_sidemenu.dart';

class UsersPage extends StatefulWidget {
  const UsersPage(
    BuildContext context, {
    Key? key,
    //required String title,
  }) : super(key: key);

  final String title = "Flutter DataTable";

  @override
  UsersPageState createState() => UsersPageState();
}

class UsersPageState extends State<UsersPage> {
  var appBarHeight = AppBar().preferredSize.height;
  PageController page = PageController();

  /* // static const _GET_ALL_ACTION = 'GET_ALL';
  // int _currentSortColumn = 0;
  // Generate a list of fiction products
  /* final List<Map> _products = List.generate(30, (i) {
    return {
      "user_id": i,
      "firstname": "User $i",
      "user": Random().nextInt(200) + 1
    };
  }); */ */

  //Create the (Global) Keys
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  // late GlobalKey<ScaffoldState> _scaffoldKey;
  final ScrollController horizontal = ScrollController(),
      vertical = ScrollController();

  // bool _isSortAsc = true;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late bool _isUpdating;
  late Users _selectedUser;
  late String _titleProgress;
  late List<Users> _users;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  var list;
  var index;

  @override
  void initState() {
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    // _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getUsers();
  }

  static List<Users> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJson(json)).toList();
  }

  _setValues(Users user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    setState(() {
      _isUpdating = true;
    });
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getUsers() {
    _showProgress('Loading User...');
    Services.getUsers().then((users) {
      setState(() {
        // _users = users.cast<User>();
        _users = users;
      });
      _showProgress(widget.title);
      debugPrint("Length: ${users.length}");
    });
  }

  _deleteUser(Users user) {
    _showProgress('Deleting User...');
    Services.deleteUser(user.userId).then((result) {
      if ('success' == result) {
        setState(() {
          _users.remove(user);
        });
        _getUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//============================== Appbar code here... ==============================
        appBar: AppBar(
            title: const Text("Users Page"),
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
              ),
            ]),
//
        body: Scaffold(
          //second scaffold
          key: _drawerscaffoldkey, //set gobal key defined above
//======================================== Drawer code here... ==========================
          drawer: Row(children: [
            SideMenu(
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
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
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
                  },
                  //),
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
            ),
          ]),
//====================================== Main Body Code Here... =============================
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 320.0, top: 35.0, right: 35.0, bottom: 100.0),
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Users View Page",
                        style: TextStyle(
                          fontSize: 24,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 400.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blueGrey,
                            side: const BorderSide(
                              color: Colors.black26,
                              width: 0.5,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20.0),
                          ),
                          onPressed: () {
                            //_submit();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AddUserPage(
                                      title: '',
                                    )));
                          },
                          child: const Text("Add User",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const SizedBox(
                          width: 100.0,
                        ),
                        /* OutlinedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blueGrey,
                            side: const BorderSide(
                              color: Colors.black26,
                              width: 0.5,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20.0),
                          ),
                          onPressed: () {
                            debugPrint('Edit Button Clicked');
                          },
                          child: const Text("Update User",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const SizedBox(
                          width: 100.0,
                        ), */
                        OutlinedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blueGrey,
                            side: const BorderSide(
                              color: Colors.black26,
                              width: 0.5,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20.0),
                          ),
                          onPressed: () {
                            //_submit();
                            _getUsers();
                            /* Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UsersPage(context))); */
                          },
                          child: const Text("Refresh",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Scrollbar(
                    thickness: 5,
                    controller: horizontal,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      controller: horizontal,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        /* sortColumnIndex: _currentSortColumn,
                        sortAscending: _isSortAsc,
                        sortColumnIndex : 0,
                        sortAscending   : 10.0, */
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        showCheckboxColumn: true,
                        // sortColumnIndex: 0,
                        // sortAscending: true,
                        /* selected: true,
                        showEditIcon: true, */
                        border: TableBorder.all(
                          width: 1.0,
                          color: Colors.black45,
                        ),
                        headingRowColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blueGrey),
                        headingTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        columns: const [
                          /* DataColumn(
                              label: Text(
                                "LINE NO. #",
                              ),
                              numeric: false,
                              tooltip: "This is the Line No."), */
                          DataColumn(
                            label: Text("USER ID"),
                            numeric: false,
                            tooltip: "This is the user id",
                            /* onSort: (int columnIndex, bool ascending) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    // sort the users list in Ascending, order by ID
                                    _users.sort((userA, userB) =>
                                        userB.userId.compareTo(userA.userId));
                                  } else {
                                    _isAscending = true;
                                    // sort the users list in Descending, order by ID
                                    _users.sort((userA, userB) =>
                                        userA.userId.compareTo(userB.userId));
                                  }
                                });
                              } */
                          ),
                          DataColumn(
                              label: Text(
                                "FIRST NAME",
                              ),
                              numeric: false,
                              tooltip: "This is the last name"),
                          DataColumn(
                              label: Text("LAST NAME"),
                              numeric: false,
                              tooltip: "This is the last name"),
                          DataColumn(
                              label: Text("ACTIONS"),
                              numeric: false,
                              tooltip: "Related Actions"),
                        ],
                        rows: _users
                            .map(
                              (user) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(user.userId),
                                    /* onTap: () {
                                      debugPrint("Tapped ${user.userId}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddUpdateUserPage()));
                                      _setValues(user);
                                      _selectedUser = user;
                                    }, */
                                  ),
                                  DataCell(
                                    Text(
                                      user.firstName,
                                    ),
                                    onTap: () {
                                      debugPrint("Tapped ${user.firstName}");
                                      _setValues(user);
                                      _selectedUser = user;
                                    },
                                  ),
                                  DataCell(
                                    Text(
                                      user.lastName /* .toUpperCase() */,
                                    ),
                                    onTap: () {
                                      debugPrint("Tapped ${user.lastName}");
                                      _setValues(user);
                                      _selectedUser = user;
                                    },
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          tooltip: "Edit",
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddUpdateUserPage(
                                                        list: list,
                                                        index: index),
                                              ),
                                            );
                                            debugPrint("Edit Mode Enabled...");
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          tooltip: "Delete",
                                          onPressed: () {
                                            _deleteUser(user);
                                            debugPrint("Data Row Deleted...");
                                          },
                                        ),
                                      ],
                                    ),
                                    /* onTap: () {
                                      // print("Tapped 'Delete' Action");
                                      debugPrint("Data Row Deleted...");
                                    }, */
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
//
//=========================== 'Copyrights' code stars from here... ====================
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
//=========================== 'Copyrights' code ends here... =========================
        ));
  }
}

//============================= Services Class Code =================================
class Services {
  static const ROOT = 'http://localhost/crm/user_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _ADD_USER_ACTION = 'ADD_USER';
  static const String _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const String _DELETE_USER_ACTION = 'DELETE_USER';

  static Future<List<Users>> getUsers() async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Users> list = parsePhotos(response.body);
        return list;
      } else {
        // throw List<Employee>();
        throw <Users>[];
      }
    } catch (e) {
      // return List<Employee>();
      return <Users>[];
    }
  }

  static List<Users> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJson(json)).toList();
  }

  static Future<String> addUser(
    String firstName,
    String lastName,
  ) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _ADD_USER_ACTION;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("addUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateUser(
    /* String userId, */
    String firstName,
    String lastName,
  ) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_USER_ACTION;
      // map["user_id"] = userId;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteUser(String userId) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _DELETE_USER_ACTION;
      map["user_id"] = userId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}

class Users {
  String userId;
  String firstName;
  String lastName;

  Users({
    required this.userId,
    required this.firstName,
    required this.lastName,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'],
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
    );
  }
}
