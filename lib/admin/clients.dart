// ignore_for_file: unused_field, constant_identifier_names, prefer_final_fields
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'admin_page.dart';
import 'sub_pages/add_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'sub_pages/AddUpdateClient.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({
    Key? key,
    required String title,
  }) : super(key: key);

  final String title = "Flutter DataTable";

  @override
  ClientsPageState createState() => ClientsPageState();
}

class ClientsPageState extends State<ClientsPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  //Create the (Global) Keys
  // final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  // late GlobalKey<ScaffoldState> _scaffoldKey;
  final ScrollController horizontal = ScrollController(),
      vertical = ScrollController();

  var appBarHeight = AppBar().preferredSize.height;

  int _currentSortColumn = 0;
  bool _isAscending = true;
  late bool _isUpdating;
  late Clients _selectedClient;
  late String _titleProgress;
  late List<Clients> _clients;
  late TextEditingController _organizeCodeController;
  late TextEditingController _organizeNameController;

/*   String clientId = "";
  String orgCode = "";
  String orgName = "";
  String phoneNo = "";
  String fax = "";
  String emailId = "";
  String webSite = "";
  String address = "";
  String regNo = "";
  String regTo = "";
  String regDate = "";
  String sector = "";
  String socialLinks = ""; */

  @override
  void initState() {
    super.initState();
    _clients = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    // _scaffoldKey = GlobalKey();
    _organizeCodeController = TextEditingController();
    _organizeNameController = TextEditingController();
    _getClients();
  }

  _setValues(Clients client) {
    _organizeCodeController.text = client.orgCode;
    _organizeNameController.text = client.orgName;
    setState(() {
      _isUpdating = true;
    });
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getClients() {
    _showProgress('Loading Clients...');
    Services.getClients().then((clients) {
      setState(() {
        // _products = products.cast<Products>();
        _clients = clients;
      });
      _showProgress(widget.title);
      debugPrint("Length: ${clients.length}");
    });
  }

  _deleteClient(Clients clients) {
    _showProgress('Deleting Product...');
    Services.deleteClient(clients.clientId).then((result) {
      if ('success' == result) {
        setState(() {
          _clients.remove(clients);
        });
        _getClients();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
//============================== Appbar code here... ==============================
      appBar: AppBar(
          title: const Text("Clients Page"),
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
                },
                tooltipContent: "Dashboard",
              ),
              SideMenuItem(
                priority: 1,
                title: 'Sales Team',
                icon: const Icon(Icons.assignment_ind),
                //GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/UsersPage');
                },
                //),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Product Management',
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/ProductsPage');
                },
                icon: const Icon(Icons.ballot),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Client Management',
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/ClientsPage');
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Report Generation',
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/ReportsPage');
                },
                icon: const Icon(Icons.analytics),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Payments',
                icon: const Icon(Icons.credit_card),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/PaymentsPage');
                },
              ),
            ],
          ),
        ]),
//
//====================================== 'Main Body' Code Here... =============================
        body: SingleChildScrollView(
          child: Padding(
            //padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.only(left: 320.0, top: 35.0, right: 50.0),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Clients View Page",
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
                              builder: (context) => const AddClientPage(
                                    title: '',
                                  )));
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddClientPage(
                                      title: '',
                                    )),
                          ); */
                        },
                        child: const Text("Add Client",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(
                        width: 100.0,
                      ),
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
                          _getClients();
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
                      sortColumnIndex: _currentSortColumn,
                      sortAscending: _isAscending,
                      showCheckboxColumn: true,
                      border: TableBorder.all(
                        width: 1.0,
                        color: Colors.black45,
                      ),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blueGrey),
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      columns: const [
                        /* DataColumn(
                              label: Text(
                                "LINE NO. #",
                              ),
                              numeric: false,
                              tooltip: "This is the Line No."), */
                        DataColumn(
                          label: Text("CLIENT ID"),
                          numeric: false,
                          /* onSort: (int columnIndex, bool ascending) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending == true) {
                                  _isAscending = false;
                                  // sort the products list in Ascending, order by ID
                                  _clients.sort((productA, productB) =>
                                      productB.clientId
                                          .compareTo(productA.clientId));
                                } else {
                                  _isAscending = true;
                                  // sort the products list in Descending, order by ID
                                  _clients.sort((productA, productB) =>
                                      productA.clientId
                                          .compareTo(productB.clientId));
                                }
                              });
                            } */
                        ),
                        DataColumn(
                          label: Text(
                            "ORGANIZATION CODE",
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Text("ORGANIZATION NAME"),
                          numeric: false,
                        ),
                        DataColumn(label: Text("PHONE"), numeric: false),
                        DataColumn(label: Text("FAX"), numeric: false),
                        DataColumn(label: Text("EMAIL"), numeric: false),
                        DataColumn(label: Text("WEBSITE"), numeric: false),
                        DataColumn(label: Text("ADDRESS"), numeric: false),
                        DataColumn(
                            label: Text("REGISTRATION NO"), numeric: false),
                        DataColumn(
                            label: Text("REGISTRATION TO"), numeric: false),
                        DataColumn(
                            label: Text("REGISTRATION DATE"), numeric: false),
                        DataColumn(label: Text("SECTOR"), numeric: false),
                        DataColumn(label: Text("SOCIAL LINKS"), numeric: false),
                        DataColumn(
                            label: Text("ACTIONS"),
                            numeric: false,
                            tooltip: "Related Actions"),
                      ],
                      rows: _clients
                          .map(
                            (client) => DataRow(
                              cells: [
                                DataCell(
                                  Text(client.clientId),
                                  /* onTap: () {
                                    debugPrint("Tapped ${client.clientId}");
                                    /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddUpdateClientPage())); */
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddUpdateClientPage()));
                                    _setValues(client);
                                    _selectedClient = client;
                                  }, */
                                ),
                                DataCell(
                                  Text(
                                    client.orgCode,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.orgName /* .toUpperCase() */,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.phoneNo,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.fax,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.emailId,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.webSite,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.address,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.regNo,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.regTo,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.regDate,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.sector,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    client.socialLinks,
                                  ),
                                  onTap: () {
                                    _setValues(client);
                                    _selectedClient = client;
                                  },
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddUpdateClientPage()),
                                          );
                                          debugPrint("Edit Mode Enabled...");
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteClient(client);
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
                const SizedBox(
                  height: 35,
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
      ),
    );
  }
}

//
//============================= Services Class Code =================================
class Services {
  static const ROOT = 'http://localhost/crm/client_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _ADD_CLIENT_ACTION = 'ADD_CLIENT';
  static const String _UPDATE_CLIENT_ACTION = 'UPDATE_CLIENT';
  static const String _DELETE_CLIENT_ACTION = 'DELETE_CLIENT';

  static Future<List<Clients>> getClients() async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("getProducts >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Clients> list = parsePhotos(response.body);
        return list;
      } else {
        // throw List<Employee>();
        throw <Clients>[];
      }
    } catch (e) {
      // return List<Employee>();
      return <Clients>[];
    }
  }

  static List<Clients> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Clients>((json) => Clients.fromJson(json)).toList();
  }

  static Future<String> addClient(String firstName, String lastName) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _ADD_CLIENT_ACTION;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("addClient >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateClient(
      String productId, String firstName, String lastName) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_CLIENT_ACTION;
      // map["client_id"] = clientId;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("updateClient >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteClient(String clientId) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _DELETE_CLIENT_ACTION;
      map["client_id"] = clientId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("deleteClient >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}

class Clients {
  /* int */ String clientId;
  /* int */ String orgCode;
  String orgName;
  /* int */ String phoneNo;
  String fax;
  String emailId;
  String webSite;
  String address;
  /* int */ String regNo;
  String regTo;
  String regDate;
  String sector;
  String socialLinks;

  Clients({
    required this.clientId,
    required this.orgCode,
    required this.orgName,
    required this.phoneNo,
    required this.fax,
    required this.emailId,
    required this.webSite,
    required this.address,
    required this.regNo,
    required this.regTo,
    required this.regDate,
    required this.sector,
    required this.socialLinks,
  });

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      // clientId: int.parse(json['client_id']),
      clientId: json['client_id'],
      // orgCode: int.parse(json['org_code']),
      orgCode: json['org_code'],
      orgName: json['org_name'] as String,
      // phoneNo: int.parse(json['phone_no']),
      phoneNo: json['phone_no'],
      fax: json['fax'] as String,
      emailId: json['email_id'] as String,
      webSite: json['website'] as String,
      address: json['address'] as String,
      // regNo: int.parse(json['reg_no']),
      regNo: json['reg_no'],
      regTo: json['reg_to'] as String,
      regDate: json['reg_date'] as String,
      sector: json['sector'] as String,
      socialLinks: json['social_links'] as String,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
