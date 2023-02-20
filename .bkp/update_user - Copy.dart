// ignore_for_file: constant_identifier_names, avoid_unnecessary_containers, prefer_typing_uninitialized_variables
// import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import '../users.dart';
import 'package:crm/admin/users.dart';

/* class UpdateUserPage extends StatefulWidget {
  //final User? user;
  final List list;
  final int index;

  //const UpdateUserPage({Key? key}) : super(key: key);
  const UpdateUserPage({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  UpdateUserPageState createState() => UpdateUserPageState();
}

class UpdateUserPageState extends State<UpdateUserPage> {
  // This is  for form validations
  //final formKey = GlobalKey<FormState>();

  bool editMode = false;

  // This is for text onChange
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  //TextEditingController ageController;

  editUser() {
    if (editMode) {
      var url = 'http://localhost/crm/update_user.php';
      http.post(Uri.parse(url), body: {
        'id': widget.list[widget.index]['id'],
        //'id': widget.user.id.toString(),
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
      });
    } else {
      var url = 'http://localhost/crm/update_user.php';
      http.post(Uri.parse(url), body: {
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
      });
    }
  }

  @override
  void initState() {
    if (widget.index != null) {
      editMode = true;

      firstnameController.text = widget.list[widget.index]['firstname'];
      lastnameController.text = widget.list[widget.index]['lastname'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Data'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: firstnameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: lastnameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              //style: ElevatedButton.styleFrom(color: Colors.amber),
              //color: Colors.amber,
              child: Text(editMode ? 'Update' : 'Save'),
              onPressed: () {
                editUser();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
 */

class UpdateUserPage extends StatefulWidget {
  // UpdateUserPage() : super();
  const UpdateUserPage({Key? key}) : super(key: key);

  final String title = "Flutter User Table";

  @override
  UpdateUserPageState createState() => UpdateUserPageState();
}

class UpdateUserPageState extends State<UpdateUserPage> {
  late User selectedUser;
  late List<User> users;

  late TextEditingController _firstNameController;
  late bool _isUpdating;
  late TextEditingController _lastNameController;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  showSnackBar(context, message) {
    /* _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    ); */
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

//Method to Update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _updateUser(User user) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating User...');
    Services.updateUser(
            user.userId, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _isUpdating = false;
      }
      //_clearValues();
    });
  }

  _deleteUser(User user) {
    _showProgress('Deleting User...');
    /* Services.deleteUser(
            user.userId, _firstNameController.text, _lastNameController.text) */
    Services.deleteUser(
            user.userId, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        //_isUpdating = false;
        UsersPage(context);
      }
      //_clearValues();
    });
  }

  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

//UI
  @override
  Widget build(BuildContext context) {
    var user;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(_titleProgress), actions: <Widget>[
        IconButton(
            // onPressed: _updateUser(users.userId),
            onPressed: () {
              _updateUser(user);
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            // onPressed: _deleteUser(user.userId),
            onPressed: () {
              _deleteUser(user);
            },
            icon: const Icon(Icons.delete)),
      ]),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _firstNameController,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'First Name'),
                )),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _firstNameController,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Last Name'),
                )),
//Add an Update Button and a Cancel Button.
//Show these buttons only when updating the USER.
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlinedButton(
                          onPressed: () {
                            _updateUser(user.userId);
                          },
                          child: const Text('Update')),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _isUpdating = false;
                            });
                            _clearValues();
                          },
                          child: const Text('Cancel'))
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class Services {
  static const ROOT = 'http://localhost/crm/update.php';

  static const _DELETE_EMP_ACTION = 'DELETE_USER';
  static const _UPDATE_EMP_ACTION = 'UPDATE_USER';

//Method to UPDATE an USER//
  static Future<String> updateUser(
      int userId, String firstName, String lastName) async {
    try {
      // var map = Map<String, dynamic>();
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_EMP_ACTION;
      map['firstname'] = firstName;
      map['lastname'] = lastName;
      // final response = await http.post(ROOT, body: map);
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint('updateUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

//Method to DELETE an USER//
  static Future<String> deleteUser(
      int userId, String firstName, String lastName) async {
    try {
      // var map = Map<String, dynamic>();
      var map = <String, dynamic>{};
      map['action'] = _DELETE_EMP_ACTION;
      map['user_id'] = userId;
      // final response = await http.post(ROOT, body: map);
      final response = await http.post(Uri.parse(ROOT), body: map);
      debugPrint('deleteUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
