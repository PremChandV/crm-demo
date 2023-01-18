// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final List<String> items = ['Account', 'Profile', 'Logout'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//============================== Appbar code here... ==============================
      appBar: AppBar(
        title: const Text("Manager"),
        actions: <Widget>[
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
                      'Manager',
                      style: TextStyle(
                        fontSize: 14,
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
                  //selectedValue = value
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
        ],
      ),
//============================== Body code here... ==============================
      body: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 40.0)),
          Center(
              child: Text(
            'Hello $username..!',
            style: const TextStyle(fontSize: 20.0),
          )),
          const Padding(padding: EdgeInsets.only(top: 40.0)),
//
          ElevatedButton(
            child: const Text("Log Out"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyApp(
                          title: "",
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
