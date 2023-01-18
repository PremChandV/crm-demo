import 'dart:async';
import 'dart:convert';
import '../admin_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:email_validator/email_validator.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  AddClientPageState createState() => AddClientPageState();
}

class AddClientPageState extends State<AddClientPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  //Create the (Global) Keys
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();

  var appBarHeight = AppBar().preferredSize.height;

  String orgCode = "";
  String orgName = "";
  String phoneNo = "";
  String fax = "";
  String email = "";
  String website = "";
  String address = "";
  String regNo = "";
  String regTo = "";
  String regDate = "";
  String sector = "";
  String socialLinks = "";

  String msg = "New User added Successfully..!";
  String msgErr = "The User is already Exist..!";

  TextEditingController psw = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  /* @override
  void initState() {
    dateinput.text = ''; //set the initial value of text field
    super.initState();
  } */

//================================= 'Send Data' API ===============================
  Future senddata() async {
    var response = await http
        .post(Uri.parse("http://localhost/crm/client_register.php"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    }, body: {
      "org_code": orgCode,
      "org_name": orgName,
      "phone_no": phoneNo,
      "fax": fax,
      "email_id": email,
      "website": website,
      "address": address,
      "reg_no": regNo,
      "reg_to": regTo,
      "reg_date": regDate,
      "sector": sector,
      "social_links": socialLinks,
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
    return const AddClientPage(
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
                      //msg = "The User is already Existing..!";
                      //log('data: $msg');
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

//
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
/*//============================== Appbar code here... ==============================
      appBar: AppBar(title: const Text("Clients"), actions: <Widget>[
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
//======================================== Drawer code here... ==========================
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
                Navigator.pushReplacementNamed(context, '/AdminPage');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.assignment_ind,
              ),
              title: const Text('Users'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/UsersPage');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.ballot,
              ),
              title: const Text('Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/ProductsPage');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.supervisor_account,
              ),
              title: const Text('Clients'),
              onTap: () {
                Navigator.pop(context);
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
                  title: 'Client Management',
                  icon: const Icon(Icons.supervisor_account),
                  onTap: () {
                    //sideMenu.changePage(page);
                    //Navigator.pushReplacementNamed(context, '/ClientsPage');
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
                      child: Text("Add Clients Page",
                          style: TextStyle(
                            fontSize: 24,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
//============================ 'Product Code' code here ===============================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Organization/Company Code',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
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
                                return 'Invalid Organization/Company Code..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                orgCode = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                orgCode = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//================================= 'Product Name' code here ===========================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Organization/Company Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Invalid Organization/Company Name..!';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'Product Name cannot contain special characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                orgName = value.capitalize();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                orgName = value.capitalize();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Phone No." Text Field Code... ========================
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: 'Phone',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10 ||
                                  value.length > 10 ||
                                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                return 'Invalid Phone Number..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                phoneNo = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                phoneNo = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Fax." Text Field Code... ========================
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: 'Fax',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 12 ||
                                  value.length > 12 ||
                                  value.contains(RegExp(r'^[a-zA-Z]'))) {
                                return 'Invalid Fax..!';
                              } else if (!value.contains(
                                  RegExp(r'^[0-9]+[-]+[0-9]+[-]+[0-9]')
                                  //RegExp(r'^[0-9-]+[0-9]+[-0-9]')
                                  )) {
                                return 'Invalid Fax..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                fax = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                fax = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//=================================== "Email ID" Text Field Code... =========================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email ID',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Email ID must contain at least 3 characters..!';
                              } else if (!EmailValidator.validate(
                                  value, true)) {
                                return 'Invalid Email ID, Please check again..!';
                              } else if (!value.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*-/+=?^_`{|}~]+@gmail.com"))) {
                                return 'Invalid Email ID, Please check again..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//=================================== "Website" Text Field Code... =========================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Website',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Website..!';
                              }
                              // !#$%&'*+=?^_`{|}~
                              else if (!value.contains(
                                  RegExp(r"^www.+[a-zA-Z0-9]+.com"))) {
                                return 'Invalid Website format, Please check again..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                website = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                website = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//============================= "Address" Selection code here... =======================
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                labelText: 'Address',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Address must contain at least 3 characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Registration No." Text Field Code... ========================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Registration Number',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10 ||
                                  value.length > 10 ||
                                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                return 'Invalid Registration Number..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                regNo = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                regNo = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//================================= 'Registration To' code here ===========================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Registration to',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Invalid Name..!';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'Name cannot contain special characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                regTo = value.capitalize();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                regTo = value.capitalize();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Registration Date" Text Field Code... ========================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Registration Date',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10 ||
                                  value.length > 10 ||
                                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                return 'Invalid Registration Date..!';
                              } else if (!value.contains(
                                  RegExp(r'^[0-9]+[-]+[0-9]+[-]+[0-9]'))) {
                                return "Invalid Date Format..!  Valid Date Format is : DD-MM-YYYY";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                regDate = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                regDate = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//================================= 'Sector' code here ===========================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Sector',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Invalid Sector..!';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'Sector cannot contain special characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                sector = value.capitalize();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                sector = value.capitalize();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//============================= "Social Media Links" Selection code here... =======================
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                labelText: 'Social Media Links',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Social Media Links must contain at least 3 characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                socialLinks = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                socialLinks = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//========================================= Submit Button Code... ===========================
                          const SizedBox(
                            height: 30,
                          ),
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

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    //String str = value;
    var result = this[0].toUpperCase();

    // ignore: unnecessary_this
    for (int i = 1; i < this.length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }
}

//Custom InputFormatter
/*class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // var buffer = new StringBuffer();
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      print(text.length);
      if (nonZeroIndex <= 5) {
        print("non");
        print(nonZeroIndex);
        if (nonZeroIndex % 5 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 12 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        // selection: new TextSelection.collapsed(offset: string.length));
        selection: TextSelection.collapsed(offset: string.length));
  }
} */
