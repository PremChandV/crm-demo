// ignore_for_file: file_names, unnecessary_null_comparison, library_private_types_in_public_api, prefer_is_empty, duplicate_ignore
// import 'dart:async';
// import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class AdminPage extends StatefulWidget {
//   const AdminPage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _AdminPageState createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   PageController page = PageController();
//   SideMenuController sideMenu = SideMenuController();

//   /*List<Option> pages = [
//     Option(0, 'A'),
//     Option(1, 'B'),
//     Option(2, 'C'),
//   ]; */

//   final List<String> items = ['Profile', 'Logout'];
//   String? selectedValue;

//   //final List<String> pageOptions = pages.map((pages) => page.options).toList();
//   //final List<String> items = ['Account', 'Profile', const MyApp(title: '',)];
//   /*final List<String> items = [
//     String(0, 'A'),
//     String(1, 'B'),
//     String(2, 'C'),
//   ]; 
//   late String selectedValue; */

//   @override
//   void initState() {
//     sideMenu.addListener((p0) {
//       page.jumpToPage(p0);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// //============================== Appbar code here... ==============================
//       appBar: AppBar(title: Text(widget.title),
//           actions: <Widget>[
//             DropdownButtonHideUnderline(
//               child: DropdownButton2(
//                 isExpanded: true,
//                 hint: Row(
//                   children: const [
//                     Icon(Icons.account_circle_rounded,
//                         size: 20, color: Colors.white),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Admin',
//                         style: TextStyle(
//                           fontSize: 14,
//                           //fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 items: items
//                     .map((item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ))
//                     .toList(),
//                 //value: selectedValue,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedValue = value as String;
//                     /*if (value == 0) {
//                       setState(() {
//                       });
//                     } */
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.more_vert,
//                 ),
//                 iconSize: 20,
//                 iconEnabledColor: Colors.white,
//                 iconDisabledColor: Colors.grey,
//                 buttonHeight: 50,
//                 buttonWidth: 160,
//                 buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                 buttonElevation: 2,
//                 itemHeight: 40,
//                 itemPadding: const EdgeInsets.only(left: 14, right: 14),
//                 dropdownMaxHeight: 200,
//                 dropdownWidth: 200,
//                 dropdownPadding: null,
//                 dropdownDecoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   color: Colors.white,
//                 ),
//                 dropdownElevation: 8,
//                 scrollbarRadius: const Radius.circular(40),
//                 scrollbarThickness: 6,
//                 scrollbarAlwaysShow: true,
//                 offset: const Offset(-20, 0),
//               ),
//             ),
//           ]),
// //============================== Body code here... ==============================
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SideMenu(
//             //controller: sideMenu,
//             controller: page,
//             style: SideMenuStyle(
//               //showTooltip: false,
//               displayMode: SideMenuDisplayMode.auto,
//               hoverColor: Colors.blue[100],
//               selectedColor: Colors.blue,
//               selectedTitleTextStyle: const TextStyle(color: Colors.white),
//               selectedIconColor: Colors.white,
//               decoration: const BoxDecoration(
//                 color: Colors.black12,
//                 border: Border(
//                   right: BorderSide(
//                     color: Colors.black54,
//                     width: 1.0,
//                   ),
//                 ),
//               ), 
//             ),
//             title: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ConstrainedBox(
//                   constraints: const BoxConstraints(
//                     maxHeight: 150,
//                     maxWidth: 150,
//                   ),
//                   child: Image.asset(
//                     'assets/images/crm_logo.png',
//                   ),
//                 ),
//                 const Divider(
//                   indent: 8.0,
//                   endIndent: 8.0,
//                 ),
//               ],
//             ),
//             footer: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 '_____',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ),
//             items: [
//               SideMenuItem(
//                 priority: 0,
//                 title: 'Dashboard',
//                 onTap: () {
//                   //Navigator.pushReplacementNamed(context, '/AdminPage');
//                   //sideMenu.changePage(const AdminPage(title: 'Dashboard'));
//                   /*Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             const AdminPage(title: 'Admin Page')),
//                   ); */
//                 },
//                 icon: const Icon(Icons.home),
//                 /*badgeContent: const Text(
//                   '3',
//                   style: TextStyle(color: Colors.white),
//                 ), */
//                 tooltipContent: "Dashboard",
//               ),
//               SideMenuItem(
//                 priority: 1,
//                 icon: const Icon(Icons.assignment_ind),
//                 title: 'Users',
//                 //GestureDetector(
//                 onTap: () {
//                   //const UsersPage(title: 'title');
//                   //Navigator.pushReplacementNamed(context, '/UsersPage');
//                   Navigator.restorablePushReplacementNamed(
//                       context, '/UsersPage');
//                   //sideMenu.changePage('/UsersPage');
//                   //setState(() => const AdminUsersPage());
//                   /*Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const UsersPage(title: 'Users'))); */
//                   /*Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const UsersPage(
//                               title: 'Users',
//                             )),
//                   ); */
//                 },
//                 //),
//               ),
//               SideMenuItem(
//                 priority: 2,
//                 title: 'Products',
//                 onTap: () {
//                   // sideMenu.changePage(ProductsPage(
//                   //   title: '',
//                   // ));
//                   Navigator.restorablePushReplacementNamed(
//                       context, '/ProductsPage');
//                 },
//                 icon: const Icon(Icons.ballot),
//               ),
//               SideMenuItem(
//                 priority: 3,
//                 title: 'Clients',
//                 onTap: () {
//                   //sideMenu.changePage(page);
//                   Navigator.restorablePushReplacementNamed(
//                       context, '/ClientsPage');
//                 },
//                 icon: const Icon(Icons.supervisor_account),
//               ),
//               SideMenuItem(
//                 priority: 4,
//                 title: 'Reports',
//                 onTap: (page, _) {
//                   sideMenu.changePage(page);
//                 },
//                 icon: const Icon(Icons.analytics),
//               ),
//               /* SideMenuItem(
//                  priority: 5,
//                  onTap:(page){
//                    sideMenu.changePage(5);
//                  },
//                  icon: const Icon(Icons.image_rounded),
//                ),
//                SideMenuItem(
//                  priority: 6,
//                  title: 'Only Title',
//                  onTap:(page){
//                    sideMenu.changePage(6);
//                  },
//                ), */
//               const SideMenuItem(
//                 priority: 7,
//                 title: 'Payments',
//                 icon: Icon(Icons.credit_card),
//               ),
//             ],
//           ),
//           /*Expanded(
//             child: PageView(
//               controller: page,
//               children: [
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Only Title',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Only Icon',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ), */
//         ],
//       ),
// //======================== 'Copyrights' code stars from here... ====================
//       bottomNavigationBar: const BottomAppBar(
//           color: Colors.grey,
//           child: SizedBox(
//             width: 30.0,
//             height: 30.0,
//             child: Center(
//                 child: Text(
//               "All rights are reserved @SSS - 2022",
//               textAlign: TextAlign.center,
//             )),
//           )),
// //========================= 'Copyrights' code ends here... =========================
//     );
//   }
// }

// class SideMenuController {
//   late int _currentPage;

//   int get currentPage => _currentPage;

//   SideMenuController({int initialPage = 0}) {
//     _currentPage = initialPage;
//   }
//   final _streameController = StreamController<int>.broadcast();

//   Stream<int> get stream => _streameController.stream;

//   void changePage(index) {
//     _currentPage = index;
//     _streameController.sink.add(index);
//   }

//   void dispose() {
//     _streameController.close();
//   }

//   void addListener(void Function(int) listener) {
//     _streameController.stream.listen(listener);
//   }

//   void removeListener(void Function(int) listener) {
//     _streameController.stream.listen(listener).cancel();
//   }
// }

// class Global {
//   static late SideMenuController controller;
//   static late SideMenuStyle style;
//   static DisplayModeNotifier displayModeState =
//       DisplayModeNotifier(SideMenuDisplayMode.auto);
//   static bool showTrailing = true;
//   static List<Function> itemsUpdate = [];
// }

// class DisplayModeNotifier extends ValueNotifier<SideMenuDisplayMode> {
//   DisplayModeNotifier(SideMenuDisplayMode value) : super(value);

//   void change(SideMenuDisplayMode mode) {
//     value = mode;
//     notifyListeners();
//   }
// }
