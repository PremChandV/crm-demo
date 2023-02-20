import 'dart:async';
import 'dart:convert';
import 'admin_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crm/admin/sub_pages/add_client.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  PaymentsPageState createState() => PaymentsPageState();
}

class PaymentsPageState extends State<PaymentsPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  //Create the (Global) Keys
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();

  var appBarHeight = AppBar().preferredSize.height;

  String productCode = "";
  String productName = "";
  String quantity = "";
  String price = "";
  String category = "";
  String productDetails = "";
  String supplier = "";
  String empId = "";
  String assignedTo = "";

  String msg = "New User added Successfully..!";
  String msgErr = "The User is already Exist..!";

  TextEditingController psw = TextEditingController();
  TextEditingController dateinput = TextEditingController();

//================================= 'Send Data' API ===============================
  Future senddata() async {
    var response = await http
        .post(Uri.parse("http://localhost/crm/product_register.php"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    }, body: {
      "procuct_code": productCode,
      "product_name": productName,
      "quantity": quantity,
      "price": price,
      "category": category,
      "product_details": productDetails,
      "supplier": supplier,
      "emp_id": empId,
      "assigned_to": assignedTo
    });
//============================== Dialog Box code ===============================
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your data has been submitted Successfully..!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
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
                    Navigator.of(context).pop(); // Close the dialog
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset(); // Empty the form fields
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        );
      },
    );

    var datauser =
        jsonDecode(response.body); //Some Unexpected Exception here...

    if (datauser == 0) {
      setState(() {});
    } else {
      setState(() {});
    }
    return const PaymentsPage(
      title: '',
    );
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
                      /*msg = "The User is already Existing..!";
                      log('data: $msg'); */
                      senddata();
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
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
//============================== Appbar code here... ==============================
        appBar: AppBar(
            title: const Text("Payments Page"),
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
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Payments View Page",
                          style: TextStyle(
                            fontSize: 24,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
//============================ 'Product Code' code here ===============================
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: 'Product Code',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 4 ||
                                      value.length > 4 ||
                                      value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                    return 'Invalid Product Code..!';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    productCode = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    productCode = value;
                                  });
                                },
                              ),
                            ),
//================================= 'Product Name' code here ===========================
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Product Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 3) {
                                    return 'Invalid Product Name..!';
                                  } else if (value
                                      .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                    return 'Product Name cannot contain special characters..!';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    productName = value.capitalize();
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    productName = value.capitalize();
                                  });
                                },
                              ),
                            ),
//========================================= Submit Button Code... ===========================
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(60)),
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                //_submit();
                                if (_formKey.currentState!.validate()) {
                                  submit();
                                  //senddata();
                                }
                              },
                              child: const Text("Submit",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
