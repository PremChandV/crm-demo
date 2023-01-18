import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'admin_page.dart';
import 'sub_pages/add_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  ClientsPageState createState() => ClientsPageState();
}

class ClientsPageState extends State<ClientsPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  //Create the (Global) Keys
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();

  var appBarHeight = AppBar().preferredSize.height;

  String clientId = "";
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
  String socialLinks = "";

//================================= 'Get/Fetch Data' API ===============================
  ProductDataSource? _productDataSource;
  List<GridColumn>? _columns;

//bool _isSortAsc = true;

  Future<dynamic> generateUserList() async {
    var url = 'http://localhost/crm/get_clients.php';
    final response = await http.get(
      Uri.parse(url),
    );
    var list = json.decode(response.body);

    // Convert the JSON to List collection.
    // ignore: no_leading_underscores_for_local_identifiers
    List<Client> _products =
        await list.map<Client>((json) => Client.fromJson(json)).toList();
    _productDataSource = ProductDataSource(_products);
    return _products;
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'client_id',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'Client ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'org_code',
          width: 80,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Company Code',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'org_name',
          width: 80,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Company Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'phone_no',
          width: 120,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Phone No.',
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'fax',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Fax',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'email_id',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Email ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'website',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Website',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'address',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'reg_no',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Registration No.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'reg_to',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Registered To',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'reg_date',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Registration Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'sector',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Sector',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'social_links',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Social Links',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
    ];
  }

  @override
  void initState() {
    super.initState();
    _columns = getColumns();
  }

//=============================== 'Submit()' function code ==============================
  void submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure to submit this data..?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () async {
                    FocusScope.of(context)
                        .unfocus(); // unfocus last selected input field
                    Navigator.pop(
                        context); //To revert back to the previous state
                  }, // so the alert dialog is closed when navigating back to main page
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 45.0, top: 20.0, right: 45.0, bottom: 20.0),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    setState(() {
                      //msg = "The User is already Existing..!";
                      //log('data: $msg');
                      //senddata();
                    });
                    Navigator.of(context).pop(); // Close the dialog
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset(); // Empty the form fields
                  },
                )
              ],
            ),
            const SizedBox(height: 10.0)
          ],
        );
      },
    );
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
                onTap: (page, _) {
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
//====================================== Body Code Here... =============================
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
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  height: 450.0,
                  /* constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ), */
                  child: FutureBuilder (
                      future: generateUserList(),
                      builder: (context, data) {
                        return data.hasData
                            ? SfDataGrid(
                                allowPullToRefresh: true,
                                source: _productDataSource!,
                                columns: _columns!,
                                columnWidthMode: ColumnWidthMode.auto,
                                gridLinesVisibility: GridLinesVisibility.both,
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: 0.7,
                              ));
                      }),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    /* style: ElevatedButton.styleFrom(
                        //minimumSize: const Size.fromHeight(60),
                        maximumSize: const Size.fromWidth(35),
                      ), */
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      //_submit();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddProductPage(
                                title: '',
                              )));
                    },
                    child: const Text("Add Client",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
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
      ),
    );
  }
}

class ProductDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  ProductDataSource(this.clients) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _clientDataGridRows = clients
        .map<DataGridRow>((c) => DataGridRow(cells: [
              //DataGridCell<int>(columnName: 'client_id', value: c.clientId),
              DataGridCell<int>(columnName: 'org_code', value: c.orgCode),
              DataGridCell<String>(columnName: 'org_name', value: c.orgName),
              DataGridCell<int>(columnName: 'phone_no', value: c.phoneNo),
              DataGridCell<String>(columnName: 'fax', value: c.fax),
              DataGridCell<String>(columnName: 'email_id', value: c.emailId),
              DataGridCell<String>(columnName: 'website', value: c.webSite),
              DataGridCell<String>(columnName: 'address', value: c.address),
              DataGridCell<int>(columnName: 'reg_no', value: c.regNo),
              DataGridCell<String>(columnName: 'reg_to', value: c.regTo),
              DataGridCell<String>(columnName: 'reg_date', value: c.regDate),
              DataGridCell<String>(columnName: 'sector', value: c.sector),
              DataGridCell<String>(
                  columnName: 'social_links', value: c.socialLinks),
            ]))
        .toList();
  }

  List<Client> clients = [];

  List<DataGridRow> _clientDataGridRows = [];

  @override
  List<DataGridRow> get rows => _clientDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((c) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(c.value.toString()),
      );
    }).toList());
  }

  void updateDataGrid() {
    notifyListeners();
  }
}

class Client {
  int clientId;
  int orgCode;
  String orgName;
  int phoneNo;
  String fax;
  String emailId;
  String webSite;
  String address;
  int regNo;
  String regTo;
  String regDate;
  String sector;
  String socialLinks;

  Client({
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

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientId: int.parse(json['client_id']),
      orgCode: int.parse(json['org_code']),
      orgName: json['org_name'] as String,
      phoneNo: int.parse(json['phone_no']),
      fax: json['fax'] as String,
      emailId: json['email_id'] as String,
      webSite: json['website'] as String,
      address: json['address'] as String,
      regNo: int.parse(json['reg_no']),
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
