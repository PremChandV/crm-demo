// ignore_for_file: file_names, constant_identifier_names, unused_field, avoid_print, unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import 'package:email_validator/email_validator.dart';
// import '../users.dart';

class AddUpdateUserPage extends StatefulWidget {
  // const AddUpdateUserPage({Key? key}) : super(key: key);

  final String title = "User Page";
  final List list;
  final int index;

  const AddUpdateUserPage({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  State<AddUpdateUserPage> createState() => _AddUpdateUserPageState();
}

class _AddUpdateUserPageState extends State<AddUpdateUserPage> {
  /* 1 */ String firstName = "";
  /* 2 */ String lastName = "";
  /* 3 */ String job = "";
  /* 4 */ String email = "";
  /* 5 */ String pass = "";
  /* 6 */ String gender = "";
  /* 7 */ String extension = "";
  /* 8 */ String mobile = "";
  /* 9 */ String alterMobile = "";
  /* 10 */ String birthDate = "";
  /* 11 */ String joinDate = "";
  // /* 12 */ String photo = "";
  /* 13 */ String address = "";
  /* 14 */ String city = "";
  /* 15 */ String country = "";
  /* 16 */ String region = "";
  /* 17 */ String postalCode = "";
  /* 18 */ String reportTo = "";
  /* 19 */ String description = "";

  //Create the (Global) Keys...
  final GlobalKey<FormState> _formKey = GlobalKey();
  late GlobalKey<ScaffoldState> _scaffoldKey;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  /* late TextEditingController _jobController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _genderController;
  late TextEditingController _extensionController;
  late TextEditingController _mobileController;
  late TextEditingController _alterMobileController;
  late TextEditingController _birthDateController;
  late TextEditingController _joinDateController;
  // late TextEditingController _photoController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _regionController;
  late TextEditingController _postalCodeController;
  late TextEditingController _reportToController;
  late TextEditingController _descriptionController; */

  // TextEditingController psw = TextEditingController();
  var appBarHeight = AppBar().preferredSize.height;
  bool _passwordVisible = true;
  bool editMode = false;
  late bool _isUpdating;
  late Users _selectedUser;
  late String _titleProgress;
  late List<Users> _users;

  @override
  void initState() {
    if (widget.index != null) {
      editMode = true;
      _firstNameController.text = widget.list[widget.index]['firstname'];
      _lastNameController.text = widget.list[widget.index]['lastname'];
    }
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    // _scaffoldKey = GlobalKey();
    // _firstNameController = TextEditingController();
    // _lastNameController = TextEditingController();
    _getUsers();
  }

  _setValues(Users user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;

    setState(() {
      _isUpdating = true;
    });
  }

  _addUser() {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      debugPrint("Empty fields");
      return;
    }
    _showProgress('User Added...');
    Services.addUser(
      _firstNameController.text,
      _lastNameController.text,
    ).then((result) {
      if ('success' == result) {
        // _getUsers();
        debugPrint('Success');
      }
      _clearValues();
    });
  }

  _getUsers() {
    _showProgress('Loading User...');
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
      });
      _showProgress(widget.title);
      debugPrint("Length: ${users.length}");
    });
  }

  _updateUser(Users user) {
    _showProgress('Updating Employee...');
    Services.updateUser(
      // user.userId,
      user.firstName,
      user.lastName,

//
      _firstNameController.text,
      // _lastNameController.text,
      /* _jobController.text,
      _emailController.text,
      _passwordController.text,
      _genderController.text,
      _extensionController.text,
      _mobileController.text,
      _alterMobileController.text,
      _birthDateController.text,
      _joinDateController.text,
      // _photoController.text,
      _cityController.text,
      _countryController.text,
      _regionController.text,
      _postalCodeController.text,
      _reportToController.text,
      _descriptionController.text, */
    ).then((result) {
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
                child: Text("Update User",
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
//================================== "First Name" Text Field Code... ========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                            labelText: "First Name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        onFieldSubmitted: (value) {
                          setState(() {
                            firstName = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            firstName = value.capitalizeAllWord();
                          });
                        },
                        onTap: () {
                          // var user;
                          // debugPrint("Tapped ${user.firstName}");
                          _setValues(_selectedUser);
                          _selectedUser = _selectedUser;
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'First Name must contain at least 3 characters..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'First Name cannot contain special characters..!';
                          }
                          return null;
                        },
                      ),
                    ),
//=================================== "Last Name" Text Field Code... =========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                            labelText: "Last Name",
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
                            return 'Last Name must contain at least 3 characters..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Last Name cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            lastName = value.capitalizeAllWord();
                            // lastNameList.add(lastName);
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            lastName = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//====================================== "Job Role" Text Field Code... ========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _jobController,
                        decoration: const InputDecoration(
                            labelText: 'Job Role',
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
                            return 'Job Role must contain at least 3 characters..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Job Role cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            job = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            job = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//=================================== "Email ID" Text Field Code... =========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email ID',
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
                            return 'Email ID must contain at least 3 characters..!';
                          } else if (!EmailValidator.validate(value, true)) {
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
                    ),
//================================= "Password" Text Field Code... =======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _passwordController,
                        obscureText:
                            !_passwordVisible, //This will obscure text dynamically
                        decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Password must contain at least 8 characters..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Password cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            pass = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            pass = value;
                          });
                        },
                      ),
                    ),
//==================================== "Gender" Selection Code... ======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _genderController,
                        decoration: const InputDecoration(
                            labelText: 'Gender',
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
                            gender = value.capitalize();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            gender = value.capitalize();
                          });
                        },
                      ),
                    ),
//================================ "Mobile Extension" Selection Code... =====================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _extensionController,
                        decoration: const InputDecoration(
                            labelText: 'Mobile Extension',
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
                              //value.length < 3 ||
                              value.length > 3) {
                            return 'Invalid Extension..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Extension cannot contain special characters..!';
                          } else if (!value
                              .contains(RegExp(r"^[+]+[1 | 91]"))) {
                            return 'Extension is Invalid..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            extension = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            extension = value;
                          });
                        },
                      ),
                    ),
//==================================== "Mobile No." Text Field Code... ========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        //keyboardType: TextInputType.phone,
                        keyboardType: TextInputType.number,
                        // controller: _mobileController,
                        decoration: const InputDecoration(
                            labelText: 'Mobile',
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
                            return 'Invalid Mobile Number..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                      ),
                    ),
//================================== "Alter Mobile No." Text Field Code... ======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        //keyboardType: TextInputType.phone,
                        keyboardType: TextInputType.number,
                        // controller: _alterMobileController,
                        decoration: const InputDecoration(
                            labelText: 'Alternate Mobile',
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
                            alterMobile = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            alterMobile = value;
                          });
                        },
                      ),
                    ),
//===================================== "D.O Birth" Selection code here... =======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // controller: _birthDateController,
                        decoration: const InputDecoration(
                            labelText: 'Birth Date',
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
                            return 'Invalid Birth Date..!';
                          } else if (!value.contains(
                              RegExp(r'^[0-9]+[-]+[0-9]+[-]+[0-9]'))) {
                            return "Invalid Date Format..!  Valid Date Format is : DD-MM-YYYY";
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            birthDate = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            birthDate = value;
                          });
                        },
                      ),
                    ),
//===================================== "D.O Join" Selection code here... =======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // controller: _joinDateController,
                        decoration: const InputDecoration(
                            labelText: 'Join Date',
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
                            return 'Invalid Join Date..!';
                          } else if (!value.contains(
                              RegExp(r'^[0-9]+[-]+[0-9]+[-]+[0-9]'))) {
                            return "Invalid Date Format..!  Valid Date Format is : DD-MM-YYYY";
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            joinDate = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            joinDate = value;
                          });
                        },
                      ),
                    ),
//============================= "Address" Selection code here... =======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        //minLines: 5,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        // controller: _addressController,
                        decoration: const InputDecoration(
                            labelText: 'Address',
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
                            return 'Address must contain at least 3 characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            address = value;
                            // bodyTempList.add(bodyTemp);
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                      ),
                    ),
//================================= 'City' code here ===========================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _cityController,
                        decoration: const InputDecoration(
                            labelText: 'City',
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
                            return 'Invalid City Name..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'City cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            city = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            city = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//============================ 'Country' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _countryController,
                        decoration: const InputDecoration(
                            labelText: 'Country',
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
                            return 'Invalid Country Name..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Country cannot contain special characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            country = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            country = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//============================ 'Region' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _regionController,
                        decoration: const InputDecoration(
                            labelText: 'Region',
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
                            return 'Invalid Region..!';
                          } else if (value
                              .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                            return 'Region cannot contain special characters..!';
                          } else if (!value.contains(RegExp(
                              r"^[asia | Asia | africa | Africa | antarctica | Antarctica | europe | Europe | north america | North america | north America | North America | south america | South america | south America | South America | australia | Australia]"))) {
                            return 'Region is Invalid..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            region = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            region = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//============================ 'Postal/PIN Code' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // controller: _postalCodeController,
                        decoration: const InputDecoration(
                            labelText: 'Postal/PIN Code',
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
                              value.length < 6 ||
                              value.length > 6 ||
                              value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                            return 'Invalid Postal/PIN Code..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            postalCode = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            postalCode = value;
                          });
                        },
                      ),
                    ),
//============================ 'Reports To' code here ===============================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: TextFormField(
                        // controller: _reportToController,
                        decoration: const InputDecoration(
                            labelText: "Whom did you want to reports to..?",
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
                            reportTo = value.capitalizeAllWord();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            reportTo = value.capitalizeAllWord();
                          });
                        },
                      ),
                    ),
//============================= "Description" Selection code here... =======================
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: TextFormField(
                        //minLines: 5,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        // controller: _descriptionController,
                        decoration: const InputDecoration(
                            labelText: 'Description',
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
                            return 'Description must contain at least 3 characters..!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            description = value;
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
        /* Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const AddUpdateUserPage(
                    list: list,
                    index: index,
                  )),
        ); */
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
  ) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _ADD_USER_ACTION;
      map["firstname"] = firstName;
      map["lastname"] = lastName;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("addUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateUser(
    String userId,
    String firstName,
    String lastName,
  ) async {
    try {
      // var map = new Map<String, dynamic>();
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_USER_ACTION;
      map["user_id"] = userId;
      map["firstname"] = firstName;
      map["lastname"] = lastName;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("updateUser >> Response:: ${response.body}");
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

  Users({
    required this.userId,
    required this.firstName,
    required this.lastName,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'] as String,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
    );
  }
}
