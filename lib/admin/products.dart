// ignore_for_file: constant_identifier_names, unused_field, prefer_final_fields
import 'dart:io';
// import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'admin_page.dart';
import 'sub_pages/add_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'sub_pages/AddUpdateProduct.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    Key? key,
  }) : super(key: key);

  final String title = "Flutter DataTable";

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  /* // static const _GET_ALL_ACTION = 'GET_ALL';
  // int _currentSortColumn = 0;
  // Generate a list of fiction prodcts
  /* final List<Map> _products = List.generate(30, (i) {
    return {
      "product_id": i,
      "firstname": "Product $i",
      "product": Random().nextInt(200) + 1
    };
  }); */ */

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
  late Products _selectedProduct;
  late String _titleProgress;
  late List<Products> _products;
  late TextEditingController _productCodeController;
  late TextEditingController _productNameController;

/*   String productCode = "";
  String productName = "";
  String quantity = "";
  String price = "";
  String category = "";
  String productDetails = "";
  String supplier = "";
  String empId = "";
  String assignedTo = ""; */

  @override
  void initState() {
    super.initState();
    _products = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    // _scaffoldKey = GlobalKey();
    _productCodeController = TextEditingController();
    _productNameController = TextEditingController();
    _getProducts();
  }

  _setValues(Products product) {
    // _productCodeController.text = product.productCode;
    _productNameController.text = product.productName;
    setState(() {
      _isUpdating = true;
    });
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getProducts() {
    _showProgress('Loading Products...');
    Services.getProducts().then((products) {
      setState(() {
        // _products = products.cast<Products>();
        _products = products;
      });
      _showProgress(widget.title);
      debugPrint("Length: ${products.length}");
    });
  }

  _deleteProduct(Products products) {
    _showProgress('Deleting Product...');
    Services.deleteProduct(products.productId).then((result) {
      if ('success' == result) {
        setState(() {
          _products.remove(products);
        });
        _getProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
//============================== Appbar code here... ==============================
      appBar: AppBar(
          title: const Text("Products Page"),
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
                  Navigator.pushReplacementNamed(context, '/UsersPage');
                },
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
                  //sideMenu.changePage(page);
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
                  child: Text("Products View Page",
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
                              builder: (context) => const AddProductPage(
                                    title: '',
                                  )));
                        },
                        child: const Text("Add Product",
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
                          child: const Text("Update Product",
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
                          _getProducts();
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
                          label: Text("PRODUCT ID"),
                          numeric: false,
                          /* onSort: (int columnIndex, bool ascending) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending == true) {
                                  _isAscending = false;
                                  // sort the products list in Ascending, order by ID
                                  _products.sort((productA, productB) =>
                                      productB.productId
                                          .compareTo(productA.productId));
                                } else {
                                  _isAscending = true;
                                  // sort the products list in Descending, order by ID
                                  _products.sort((productA, productB) =>
                                      productA.productId
                                          .compareTo(productB.productId));
                                }
                              });
                            } */
                        ),
                        DataColumn(
                          label: Text(
                            "PRODUCT CODE",
                          ),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Text("PRODUCT NAME"),
                          numeric: false,
                        ),
                        DataColumn(label: Text("QUANTITY"), numeric: false),
                        DataColumn(label: Text("PRICE"), numeric: false),
                        DataColumn(label: Text("CATEGORY"), numeric: false),
                        DataColumn(
                            label: Text("PRODUCT DETAILS"), numeric: false),
                        DataColumn(label: Text("SUPPLIER"), numeric: false),
                        DataColumn(label: Text("EMPLOYEE ID"), numeric: false),
                        DataColumn(label: Text("ASSIGNED TO"), numeric: false),
                        DataColumn(
                            label: Text("ACTIONS"),
                            numeric: false,
                            tooltip: "Related Actions"),
                      ],
                      rows: _products
                          .map(
                            (product) => DataRow(
                              cells: [
                                DataCell(
                                  Text(product.productId),
                                  /* onTap: () {
                                    debugPrint("Tapped ${product.productId}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddUpdateProductPage()));
                                    _setValues(product);
                                    _selectedProduct = product;
                                  }, */
                                ),
                                DataCell(
                                  Text(
                                    product.productCode,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.productName /* .toUpperCase() */,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.quantity,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.price,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.category,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.productDetails,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.supplier,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.empId,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
                                  },
                                ),
                                DataCell(
                                  Text(
                                    product.assignedTo,
                                  ),
                                  onTap: () {
                                    _setValues(product);
                                    _selectedProduct = product;
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
                                                    const AddUpdateProductPage()),
                                          );
                                          debugPrint("Edit Mode Enabled...");
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteProduct(product);
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

class Products {
  /* int */ String productId;
  /* int */ String productCode;
  String productName;
  /* int */ String quantity;
  /* int */ String price;
  String category;
  String productDetails;
  String supplier;
  /* int */ String empId;
  String assignedTo;

  Products({
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.category,
    required this.productDetails,
    required this.supplier,
    required this.empId,
    required this.assignedTo,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      // productId: int.parse(json['product_id']),
      productId: json['product_id'],
      // productCode: int.parse(json['procuct_code']),
      productCode: json['product_code'],
      productName: json['product_name'] as String,
      // quantiry: int.parse(json['quantity']),
      quantity: json['quantity'],
      // price: int.parse(json['price']),
      price: json['price'],
      category: json['category'] as String,
      productDetails: json['product_details'] as String,
      supplier: json['supplier'] as String,
      // empId: int.parse(json['emp_id']),
      empId: json['emp_id'],
      assignedTo: json['assigned_to'] as String,
    );
  }
}

/*extension StringExtension on String {
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
} */
//
//============================= Services Class Code =================================
class Services {
  static const ROOT = 'http://localhost/crm/product_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _ADD_PRODUCT_ACTION = 'ADD_PRODUCT';
  static const String _UPDATE_PRODUCT_ACTION = 'UPDATE_PRODUCT';
  static const String _DELETE_PRODUCT_ACTION = 'DELETE_PRODUCT';

  static Future<List<Products>> getProducts() async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("getProducts >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Products> list = parsePhotos(response.body);
        return list;
      } else {
        // throw List<Employee>();
        throw <Products>[];
      }
    } catch (e) {
      // return List<Employee>();
      return <Products>[];
    }
  }

  static List<Products> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Products>((json) => Products.fromJson(json)).toList();
  }

  static Future<String> addProduct(String firstName, String lastName) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _ADD_PRODUCT_ACTION;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("addProduct >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateProduct(
      String productId, String firstName, String lastName) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_PRODUCT_ACTION;
      map["product_id"] = productId;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("updateProduct >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteProduct(String productId) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _DELETE_PRODUCT_ACTION;
      map["product_id"] = productId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint("deleteProduct >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
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
