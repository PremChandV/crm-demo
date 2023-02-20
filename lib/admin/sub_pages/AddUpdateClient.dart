// ignore_for_file: file_names, constant_identifier_names, unused_field, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class AddUpdateClientPage extends StatefulWidget {
  const AddUpdateClientPage({Key? key}) : super(key: key);

  final String title = "Client Page";

  @override
  State<AddUpdateClientPage> createState() => _AddUpdateClientPageState();
}

class _AddUpdateClientPageState extends State<AddUpdateClientPage> {
  /* 1 */ String productCode = "";
  /* 2 */ String productName = "";
  /* 3 */ String quantity = "";
  /* 4 */ String price = "";
  /* 5 */ String category = "";
  /* 6 */ String productDetails = "";
  /* 7 */ String supplier = "";
  /* 8 */ String empId = "";
  /* 9 */ String assignedTo = "";

  //Create the (Global) Keys...
  final GlobalKey<FormState> _formKey = GlobalKey();
  late GlobalKey<ScaffoldState> _scaffoldKey;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  // TextEditingController _firstNameController = TextEditingController();
  // TextEditingController _lastNameController = TextEditingController();
  // TextEditingController jobController;
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController extensionController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController altMobileController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController joinDateController = TextEditingController();
  // final TextEditingController photoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController reportToController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // TextEditingController psw = TextEditingController();
  var appBarHeight = AppBar().preferredSize.height;
  // bool _passwordVisible = true;
  late bool _isUpdating;
  late Users _selectedUser;
  late String _titleProgress;
  late List<Users> _users;

  @override
  void initState() {
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getUsers();
  }

  /* _setValues(Users user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    setState(() {
      _isUpdating = true;
    });
  } */

  _addUser() {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      debugPrint("Empty fields");
      return;
    }
    _showProgress('Product Added...');
    Services.addUser(
            _firstNameController.text,
            _lastNameController.text,
            _jobController.text,
            emailController.text,
            passwordController.text,
            genderController.text,
            extensionController.text,
            mobileController.text,
            altMobileController.text,
            birthDateController.text,
            joinDateController.text,
            // photoController.text,
            addressController.text,
            cityController.text,
            countryController.text,
            regionController.text,
            postalCodeController.text,
            reportToController.text,
            descriptionController.text)
        .then((result) {
      if ('success' == result) {
        // _getUsers();
        debugPrint('Success');
      }
      _clearValues();
    });
  }

  _getUsers() {
    _showProgress('Loading Product...');
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
      });
      _showProgress(widget.title);
      debugPrint("Length: ${users.length}");
    });
  }

  _updateUser(Users user) {
    _showProgress('Updating Product...');
    Services.updateUser(
            user.userId, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers();
        setState(() {
          _isUpdating = false;
        });
        _firstNameController.text = '';
        _lastNameController.text = '';
      }
    });
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
    _jobController.text = '';
    emailController.text = '';
    passwordController.text = '';
    genderController.text = '';
    extensionController.text = '';
    mobileController.text = '';
    altMobileController.text = '';
    birthDateController.text = '';
    joinDateController.text = '';
    // photoController.text = '';
    addressController.text = '';
    cityController.text = '';
    countryController.text = '';
    regionController.text = '';
    postalCodeController.text = '';
    reportToController.text = '';
    descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//============================== Appbar code here... ==============================
      appBar: AppBar(title: Text(_titleProgress),

          ///
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
//====================================== Body Code Here... =============================
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Update Client",
                    style: TextStyle(
                      fontSize: 24,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
//============================ 'Product Code' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: postalCodeController,
                        decoration: const InputDecoration(
                            labelText: 'Product Code',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
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
//================================== "Product Name" Text Field Code... ========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                            labelText: "Product Name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        onFieldSubmitted: (value) {
                          setState(() {
                            productCode = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            productCode = value.capitalizeAllWord();
                          });
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Product Name must contain at least 3 characters..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Product Name cannot contain special characters..!';
                          }
                          return null;
                        },
                      ),
                    ),
//==================================== "Quantity" Text Field Code... ========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        //keyboardType: TextInputType.phone,
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        decoration: const InputDecoration(
                            labelText: 'Quantity',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10 ||
                              value.length > 1 ||
                              value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                            return 'Invalid Number..!';
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
                    ),
//================================== "Price" Text Field Code... ======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        //keyboardType: TextInputType.phone,
                        keyboardType: TextInputType.number,
                        controller: altMobileController,
                        decoration: const InputDecoration(
                            labelText: 'Price',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10 ||
                              value.length > 10 ||
                              value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                            return 'Invalid Alternate Mobile No..!';
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
                    ),
//================================= 'Category' code here ===========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                            labelText: 'Category',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Invalid Category Name..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Category cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            category = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            category = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//============================ 'Product Details' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: countryController,
                        decoration: const InputDecoration(
                            labelText: 'Product Details',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Invalid Product Details..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Product Details cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            productDetails = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            productDetails = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//============================ 'Supplier' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: regionController,
                        decoration: const InputDecoration(
                            labelText: 'Supplier',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 4) {
                            return 'Invalid Supplier..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Supplier cannot contain special characters..!';
                          } else if (!value.contains(RegExp(
                              r"^[asia | Asia | africa | Africa | antarctica | Antarctica | europe | Europe | north america | North america | north America | North America | south america | South america | south America | South America | australia | Australia]"))) {
                            return 'Supplier is Invalid..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            supplier = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            supplier = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//==================================== "Employee ID" Selection Code... ======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: genderController,
                        decoration: const InputDecoration(
                            labelText: 'Employee ID',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 4) {
                            return 'Invalid Gender..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Gender cannot contain special characters..!';
                          } else if (!value.contains(
                              RegExp(r"^[male | Male | female | Female]"))) {
                            return 'Gender is Invalid..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            empId = value.capitalize();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            empId = value.capitalize();
                          });
                        },
                      ),
                    ),

//============================ 'Assigned to' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: TextFormField(
                        controller: reportToController,
                        decoration: const InputDecoration(
                            labelText: "Whom did you want to Assign this..?",
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 4) {
                            return 'Invalid Field..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'This Field cannot contain special characters..!';
                          } else if (!value.contains(RegExp(
                              r"^[admin | Admin | manager | Manager | Executive | sales manager | Sales manager | sales Manager | Sales Manager | sales executive | Sales executive | sales Executive | Sales Executive]"))) {
                            return 'Field is Invalid..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            assignedTo = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            assignedTo = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),

                    ///
                    ///
                    _isUpdating
                        ? Row(
                            children: <Widget>[
                              TextButton(
                                child: const Text('UPDATE'),
                                onPressed: () {
                                  _updateUser(_selectedUser);
                                },
                              ),
                              TextButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  setState(() {
                                    _isUpdating = false;
                                  });
                                  _clearValues();
                                },
                              ),
                            ],
                          )
                        : /* Container(), */
//========================================= Submit Button Code... ===========================
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(60),
                                padding: const EdgeInsets.only(
                                    left: 100.0, right: 100.0)),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              //_submit();
                              if (_formKey.currentState!.validate()) {
                                _addUser();
                              }
                            },
                            child: const Text("Submit",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                    /* Expanded(
                      child: _dataBody(),
                    ) */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddUpdateClientPage()),
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

class Services {
  static const ROOT = 'http://localhost/crm/user_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_USER_ACTION = 'ADD_EMP';
  static const String _UPDATE_USER_ACTION = 'UPDATE_EMP';
  static const String _DELETE_USER_ACTION = 'DELETE_EMP';

  static Future<List<Users>> getUsers() async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Users> list = parsePhotos(response.body);
        return list;
      } else {
        // throw List<Employee>();
        return <Users>[];
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

  /* static Future<String> createTable() async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _CREATE_TABLE;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  } */

  static Future<String> addUser(
      String firstName,
      String lastName,
      String job,
      String email,
      String pass,
      String gender,
      String extension,
      String mobile,
      String alterMobile,
      String birthDate,
      String joinDate,
      // String photo,
      String address,
      String city,
      String country,
      String region,
      String postalCode,
      String reportTo,
      String description) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _ADD_USER_ACTION;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      map["job_role"] = job;
      map["email"] = email;
      map["password"] = pass;
      map["gender"] = gender;
      map["extension"] = extension;
      map["mobile"] = mobile;
      map["alter_mobile"] = alterMobile;
      map["birth_date"] = birthDate;
      map["join_date"] = joinDate;
      // map["photo"] = photo;
      map["address"] = address;
      map["city"] = city;
      map["country"] = country;
      map["region"] = region;
      map["postal_code"] = postalCode;
      map["report_to"] = reportTo;
      map["description"] = description;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("addUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateUser(
      String userId, String firstName, String lastName) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_USER_ACTION;
      map["user_id"] = userId;
      map["firstname"] = firstName;
      map["lastname"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteUser >> Response:: ${response.body}");
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
      print("deleteUser >> Response:: ${response.body}");
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

  Users(
      {required this.userId, required this.firstName, required this.lastName});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'] as String,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
    );
  }
}
