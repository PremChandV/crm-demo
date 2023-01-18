// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required String title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _passwordVisible = false;

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  String msg = '';
//
//============================= 'Login API' code STARTS here ========================
  Future _login() async {
    var response =
        await http.post(Uri.parse("http://localhost/crm/login.php"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    }, body: {
      "email": user.text,
      "password": pass.text,
    });

    //var datauser = json.decode(response.body);
    var datauser = jsonDecode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Failed, Please check your Login Details..!";
      });
    } else {
      if (datauser[0]['job_role'] == 'Admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['job_role'] == 'Manager') {
        Navigator.pushReplacementNamed(context, '/ManagerPage');
      } else if (datauser[0]['job_role'] == 'Sales Manager') {
        Navigator.pushReplacementNamed(context, '/ManagerPage');
      } else if (datauser[0]['job_role'] == 'Executive') {
        Navigator.pushReplacementNamed(context, '/ManagerPage');
      } else if (datauser[0]['job_role'] == 'Sales Executive') {
        Navigator.pushReplacementNamed(context, '/ManagerPage');
      }
      setState(() {
        // ignore: unused_local_variable, prefer_adjacent_string_concatenation
        var username = datauser[0]['firstname' + 'lastname'];
      });
    }
    return datauser;
  }

//============================= 'Login API' code ENDS here ========================
//
  @override
  Widget build(BuildContext context) {
    //MediaQueryData deviceInfo = MediaQuery.of(context);

    return Scaffold(
//============================== 'AppBar' Code STARTS from here ==================================
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
//============================== 'Body' Part Code STARTS from here ==================================
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Container(
          //decoration: const BoxDecoration(color: Colors.black12),
          margin:
              const EdgeInsets.symmetric(horizontal: 520.0, vertical: 100.0),
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 3.0,
                    offset: Offset(0.5, 0.5))
              ]),
//============================== 'Login' Heading Code ==================================
          child: Center(
            child: Column(
              children: <Widget>[
                //const Padding(padding: EdgeInsets.only(top: 30.0)),
                const Text(
                  'Login',
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(-1.0, 1.0),
                          blurRadius: 2.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                      color: Colors.blue,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(top: 40.0)),
          //============================== 'Email ID' field ==================================
                TextFormField(
                  controller: user,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black54)),
                    labelText: "Username",
                    /* labelStyle: const TextStyle(
                      color: Colors.grey,
                    ), */
                    hintText: "Enter Email Id here",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black45,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black87,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                ),
          //============================== 'Password' field ==================================
                TextFormField(
                  controller: pass,
                  //obscureText: true,
                  obscureText:
                      !_passwordVisible, //This will obscure text dynamically
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.black54)),
                    labelText: "Password",
                    hintText: "Enter Password here",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black45,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black87,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                ),
          //============================== 'Login' Button code ==================================
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 18.0),
                  ),
                  onPressed: () {
                    _login();
                  },
                  child: const Text("Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 30.0),
                Text(
                  msg,
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
//============================== 'Copyrights' code STARTS here ==================================
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
//============================== 'Copyrights' code ENDS here ==================================
    );
  }
}

/*Widget _passwordWidget() {
    return TextField(
  key: Key('password-input'),
  textInputAction: TextInputAction.done,
  keyboardType: TextInputType.visiblePassword,
  controller: pass,
  autofocus: false,
  obscureText: _passVisibility,

  decoration: InputDecoration(
      labelText: //your labelText
      //hintText: //your hintText
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.amber,
        ),
      ),
      suffixIcon: IconButton(
        icon: _passVisibility
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
        onPressed: () {
          _passVisibility = !_passVisibility;

          setState(() {});
        },
      )),
  );
} */
