/* // ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import '../users.dart';

class UpdateUserPage extends StatefulWidget {
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
} */

/*   // Http post request
  Future editUser() async {
    return await http.post(
      Uri.parse("http://localhost/crm/update_user.php"),
      body: {
        //"id": widget.user.id.toString(),
        "firstname": firstnameController.text,
        "lastname": lastnameController.text
      },
    );
  }

  void _onConfirm(context) async {
    await editUser();
  }

  @override
  void initState() {
    firstnameController = TextEditingController(text: widget.user?.firstName);
    lastnameController = TextEditingController(text: widget.user?.lastName);
    //ageController = TextEditingController(text: widget.user.age.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blueGrey,
            //textColor: Colors.white,
          ),
          onPressed: () {
            _onConfirm(context);
          },
          child: const Text(
            'CONFIRM',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: appForm(
              formKey: formKey,
              firstnameController: firstnameController,
              lastnameController: lastnameController,
              //ageController: ageController,
            ),
          ),
        ),
      ),
    );
  }

  appForm(
      {required GlobalKey<FormState> formKey,
      required TextEditingController firstnameController,
      required TextEditingController lastnameController}) {}
}
 */