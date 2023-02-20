// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, file_names
import 'dart:async';
import 'dart:convert';
import '../admin_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  AddUserPageState createState() => AddUserPageState();
}

class AddUserPageState extends State<AddUserPage> {
  var appBarHeight = AppBar().preferredSize.height;

  String address = "";
  String alterMobile = "";
  String birthDate = "";
  String city = "";
  String country = "";
  String description = "";
  String email = "";
  String extension = "";
  String firstName = "";
  String gender = "";
  String job = "";
  String joinDate = "";
  String lastName = "";
  String mobile = "";
  String pass = "";
  String photo = "";
  String postalCode = "";
  String region = "";
  String reportTo = "";

  //Create the (Global) Keys
  final GlobalKey<FormState> _formKey = GlobalKey();

  PageController page = PageController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController psw = TextEditingController();

  bool _passwordVisible = true;

//================================= 'Send Data' API ===============================
  Future/*<UsersPage>*/ senddata() async {
    var response = await http
        .post(Uri.parse("http://localhost/crm/user_register.php"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    }, body: {
      "firstname": firstName /*.text.toString()*/,
      "lastname": lastName /*.text.toString()*/,
      "job_role": job,
      "email": email,
      "password": pass,
      "gender": gender,
      "extension": extension,
      "mobile": mobile,
      "alter_mobile": alterMobile,
      "birth_date": birthDate,
      "join_date": joinDate,
      "photo": photo,
      "address": address,
      "city": city,
      "country": country,
      "region": region,
      "postal_code": postalCode,
      "report_to": reportTo,
      "description": description,
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
          /* content: SingleChildScrollView(
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
      setState(() {});
    } else {
      setState(() {});
    }
    return const AddUserPage(
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
          content: SingleChildScrollView(
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
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//============================== Appbar code here... ==============================
        appBar: AppBar(title: const Text("Users Page"), actions: <Widget>[
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
//Second Scaffold
        body: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Add User",
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
//================================== "First Name" Text Field Code... ========================
                          TextFormField(
                            controller: firstNameController,
                            decoration: const InputDecoration(
                                labelText: 'First Name',
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
                                return 'First Name must contain at least 3 characters..!';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'First Name cannot contain special characters..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                firstName = value.capitalizeAllWord();
                                // firstNameList.add(firstName);
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                firstName = value.capitalizeAllWord();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//=================================== "Last Name" Text Field Code... =========================
                          TextFormField(
                            controller: lastNameController,
                            decoration: const InputDecoration(
                                labelText: 'Last Name',
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
                          const SizedBox(
                            height: 20,
                          ),
//====================================== "Job Role" Text Field Code... ========================
                          TextFormField(
                            controller: jobController,
                            decoration: const InputDecoration(
                                labelText: 'Job Role',
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
                          const SizedBox(
                            height: 20,
                          ),
//=================================== "Email ID" Text Field Code... =========================
                          TextFormField(
                            controller: emailController,
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
//================================= "Password" Text Field Code... =======================
                          TextFormField(
                            controller: psw,
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
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Gender" Selection Code... ======================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Gender',
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
                                  value.length < 4) {
                                return 'Invalid Gender..!';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'Gender cannot contain special characters..!';
                              } else if (!value.contains(RegExp(
                                  r"^[male | Male | female | Female]"))) {
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
                          const SizedBox(
                            height: 20,
                          ),
//================================ "Mobile Extension" Selection Code... =====================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Mobile Extension',
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
                          const SizedBox(
                            height: 20,
                          ),
//==================================== "Mobile No." Text Field Code... ========================
                          TextFormField(
                            //keyboardType: TextInputType.phone,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Mobile',
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
                          const SizedBox(
                            height: 20,
                          ),
//================================== "Alter Mobile No." Text Field Code... ======================
                          TextFormField(
                            //keyboardType: TextInputType.phone,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Alternate Mobile',
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
                          const SizedBox(
                            height: 20,
                          ),
//===================================== "D.O Birth" Selection code here... =======================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Birth Date',
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
                          const SizedBox(
                            height: 20,
                          ),
//
                          /*TextFormField(
                            //keyboardType: TextInputType.phone,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Date of Birth',
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
                                  value.length < 8 ||
                                  value.length > 8 ||
                                  value.contains(RegExp(r'^[a-zA-Z]'))) {
                                return 'Invalid DOB, Please Enter valid DOB..!';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                birthDate = value;
                                // bodyTempList.add(bodyTemp);
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                birthDate = value;
                              });
                            },
                          ), */
//
                          /*DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Only Date',
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime birthDate) {
                              print(birthDate);
                            },
                          ), */
//
//===================================== "D.O Join" Selection code here... =======================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Join Date',
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
                          const SizedBox(
                            height: 20,
                          ),
//============================= "Address" Selection code here... =======================
                          TextFormField(
                            //minLines: 5,
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
                                // bodyTempList.add(bodyTemp);
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
//================================= 'City' code here ===========================
                          TextFormField(
                            //controller: pass,
                            decoration: const InputDecoration(
                                labelText: 'City',
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
                          const SizedBox(
                            height: 20,
                          ),
//============================ 'Country' code here ===============================
                          TextFormField(
                            //controller: pass,
                            decoration: const InputDecoration(
                                labelText: 'Country',
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
                          const SizedBox(
                            height: 20,
                          ),
//============================ 'Region' code here ===============================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Region',
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
                          const SizedBox(
                            height: 20,
                          ),
//============================ 'Postal/PIN Code' code here ===============================
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Postal/PIN Code',
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
                          const SizedBox(
                            height: 20,
                          ),
//============================ 'Reports To' code here ===============================
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Whom did you want to reports to..?",
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
                          const SizedBox(
                            height: 20,
                          ),
//============================= "Description" Selection code here... =======================
                          TextFormField(
                            //minLines: 5,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                labelText: 'Description',
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
//========================================= Submit Button Code... ===========================
                          const SizedBox(
                            height: 45.0,
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
