import 'dart:async';
import 'dart:convert';
import '../admin_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_sidemenu/easy_sidemenu.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  AddProductsPageState createState() => AddProductsPageState();
}

class AddProductsPageState extends State<AddProductPage> {
  PageController page = PageController();

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

/*   var dob;
  var gend;
  var exten;
  var regn;
  var report; */

  //bool _passwordVisible = true;

  TextEditingController psw = TextEditingController();
  TextEditingController dateinput = TextEditingController();

//================================= 'Send Data' API ===============================
  Future/*<UsersPage>*/ senddata() async {
    //log('data: $firstName');

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
          /*content: SingleChildScrollView(
            child: Column(
              //children: const <Widget>[],
            ),
          ), */
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
      setState(() {
        //msg = "The User is already Exist..!";
        //print('data: $msg');
      });
    } else {
      setState(() {
        //msg = "New User added Successfully..!";
        //print('data: $msgErr');
      });
    }
    return const AddProductPage(
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
          title: const Text('Are you sure to submit your data..?'),
          /* content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Full Name: ",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  //child: Text(firstName + " " + lastName),
                  child: Text("$firstName $lastName"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Email ID: ",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  // ignore: unnecessary_string_interpolations
                  child: Text("$email"),
                ),
              ],
            ),
          ), */
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
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
//============================== Appbar code here... ==============================
        appBar: AppBar(title: const Text("Products Page"), actions: <Widget>[
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
                  /*badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ), */
                  tooltipContent: "Dashboard",
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Users',
                  icon: const Icon(Icons.assignment_ind),
                  //GestureDetector(
                  onTap: () {
                    //const UsersPage(title: 'title');
                    //Navigator.pushReplacementNamed(context, '/UsersPage');
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
                  title: 'Products',
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
                  title: 'Clients',
                  icon: const Icon(Icons.supervisor_account),
                  onTap: () {
                    //sideMenu.changePage(page);
                    Navigator.pushReplacementNamed(context, '/ClientsPage');
                  },
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Reports',
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
//
//====================================== Body Code Here... =============================
          body: Center(
            child: SingleChildScrollView(
              // ignore: sort_child_properties_last
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Add Products Page",
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
                                labelText: 'Product Code',
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
                          const SizedBox(
                            height: 20,
                          ),
//================================= 'Product Name' code here ===========================
                          TextFormField(
                            //controller: pass,
                            decoration: const InputDecoration(
                                labelText: 'Product Name',
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
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Quantity" Text Field Code... ========================
                          TextFormField(
                            //keyboardType: TextInputType.phone,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Quantity',
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
                                  value.length > 1 ||
                                  value.length > 10000000 ||
                                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                return 'Invalid Quantity..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                quantity = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Price" Text Field Code... ========================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Price',
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
                                  //value.length > 999 ||
                                  //value.length > 10000000 ||
                                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                return 'Invalid Price..!';
                              } else if (value.length < 1000 &&
                                  value.length > 10000000) {
                                return 'Enter the Price between 1000 to 10000000..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                price = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                price = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//============================ 'Category' code here ===============================
                          TextFormField(
                            //controller: pass,
                            decoration: const InputDecoration(
                                labelText: 'Category',
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
                                return 'Invalid Category Name..!';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'Country cannot contain special characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                category = value.capitalize();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                category = value.capitalize();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//============================= "Product Details" code here... =======================
                          TextFormField(
                            //minLines: 5,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                labelText: 'Product Details',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Product Details..!';
                              } else if (value.length < 3) {
                                return 'Product Details must contain at least 3 characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                productDetails = value /*.capitalize()*/;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                productDetails = value /*.capitalize()*/;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//============================= "Supplier" code here... =======================
                          TextFormField(
                            //minLines: 5,
                            keyboardType: TextInputType.text,
                            //maxLines: null,
                            decoration: const InputDecoration(
                                labelText: 'Supplier',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Supplier Name..!';
                              } else if (value.length < 3) {
                                return 'Supplier Name must contain at least 3 characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                supplier = value /*.capitalize()*/;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                supplier = value /*.capitalize()*/;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//================================== "Emp ID" Text Field Code... ======================
                          TextFormField(
                            //keyboardType: TextInputType.phone,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Employe ID',
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
                                  value.length < 5 ||
                                  value.length > 5 ||
                                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                                return 'Invalid Employe ID..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                empId = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                empId = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//============================ 'Assigned To' code here ===============================
                          TextFormField(
                            //controller: pass,
                            decoration: const InputDecoration(
                                labelText: 'Assigned to',
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
                                return 'Name cannot contain any special characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                assignedTo = value.capitalize();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                assignedTo = value.capitalize();
                              });
                            },
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
  // Method used for Capitalize the First letter of first word from the form input values.
  String capitalize() {
    //String str = value;
    var result = this[0].toUpperCase();
    bool cap = true;
    // ignore: unnecessary_this
    for (int i = 1; i < this.length; i++) {
      if (this[i - 1] == " " && cap == true) {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
        cap = false;
      }
    }
    return result;
  }

  // Method used for Capitalize the First letter of each word from the form input values.
  String capitalizeAllWord(/* String value */) {
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
