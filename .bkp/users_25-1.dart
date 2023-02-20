// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, prefer_typing_uninitialized_variables
//import 'dm.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'admin_page.dart';
import 'sub_pages/add_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'sub_pages/update_user.dart';
//import 'sub_pages/update_user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage(
    BuildContext context, {
    Key? key,
    //required String title,
  }) : super(key: key);

  @override
  UsersPageState createState() => UsersPageState();

  /* @override
  _PagingDataGridState createState() => _PagingDataGridState(); */
}

class UsersPageState extends State<UsersPage> {
  bool showLoadingIndicator = true;
  double pageCount = 0;

  var appBarHeight = AppBar().preferredSize.height;

  /* final */ List<User> paginatedDataTable = <User>[];

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  //Create the (Global) Keys
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  // final DataGridController _dataGridController = DataGridController();

  final int rowsPerPage = 0;
  //late UserDataSource _userDataSource;
  UserDataSource? _userDataSource;

  String firstName = "";
  String lastName = "";
  String job = "";
  String email = "";
  String pass = "";
  String gender = "";
  String extension = "";
  String mobile = "";
  String alterMobile = "";
  String birthDate = "";
  String joinDate = "";
  String photo = "";
  String address = "";
  String city = "";
  String country = "";
  String region = "";
  String postalCode = "";
  String reportTo = "";
  String description = "";

  List<GridColumn>? _columns;

  //bool _isSortAsc = true;

  Future<dynamic> generateUserList() async {
    var url = 'http://localhost/crm/get_users.php';
    final response = await http.get(
      Uri.parse(url),
    );
    var list = json.decode(response.body);

    // Convert the JSON to List collection.
    // ignore: no_leading_underscores_for_local_identifiers
    List<User> _users =
        await list.map<User>((json) => User.fromJson(json)).toList();
    _userDataSource = UserDataSource(_users);
    return _users;
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          allowEditing: false,
          columnName: 'user_id',
          width: 120,
          label: Container(
              //padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'User ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          allowEditing: true,
          columnName: 'firstname',
          //width: 120,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'First Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'lastname',
          //width: 120,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Last Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'job_role',
          width: 120,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Job Role',
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'email',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Email ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'password',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'gender',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'extension',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Extension',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'mobile',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Mobile No.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'alter_mobile',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Alternate Mobile No.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'birth_date',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Date of Birth',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'join_date',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Date of Join',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'photo',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'address',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'city',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'City',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'country',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Country',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'region',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Region',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'postal_code',
          width: 125,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Postal Code',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'reports_to',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Report To',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          columnName: 'description',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
    ];
  }

  @override
  void initState() {
    super.initState();
    _columns = getColumns();
  }

//=============================== 'Submit()' function code ==============================
  void submit() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure to submit this data..?'),
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
                      /*msg = "The User is already Existing..!";
                      log('data: $msg'); */
                      //senddata();
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

/*   @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//
//============================== Appbar code here... ==============================
        appBar: AppBar(
            title: const Text("Users Page"),
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
                  /* boxShadow: [
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
                  },
                  tooltipContent: "Dashboard",
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Sales Team',
                  icon: const Icon(Icons.assignment_ind),
                  //GestureDetector(
                  onTap: () {
                    //const UsersPage(title: 'title');
                    Navigator.pushReplacementNamed(context, '/UsersPage');
                  },
                  //),
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Product Management',
                  icon: const Icon(Icons.ballot),
                  onTap: () {
                    //sideMenu.changePage(const UsersPage(title: '',));
                    Navigator.pushReplacementNamed(context, '/ProductsPage');
                  },
                ),
                SideMenuItem(
                  priority: 3,
                  title: 'Client Management',
                  icon: const Icon(Icons.supervisor_account),
                  onTap: () {
                    //sideMenu.changePage(page);
                    Navigator.pushReplacementNamed(context, '/ClientsPage');
                  },
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Report Generation',
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
//====================================== Body Code Here... =============================
          body: SingleChildScrollView(
            child: Padding(
              //padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(left: 320.0, top: 35.0, right: 50.0),
              child: Column(
                children: <Widget>[
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Users View Page",
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
                                    builder: (context) => const AddUserPage(
                                          title: '',
                                        )));
                              },
                              child: const Text("Add User",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const SizedBox(
                              width: 100.0,
                            ),
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
                                /* var list;
                                var index; */
                                /* Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UpdateUserPage(
                                          // index: index, list: list,
                                          // List<GridColumn> getColumns(),
                                          // getColumns[index] List<GridColumn>,
                                          getColumns[index] ["firstname"],
                                        ))); */
                                /* _dataGridController.beginEdit(
                                    RowColumnIndex(3, 2)); //(Row, Column) */
                                debugPrint('Edit Button Clicked');
                              },
                              child: const Text("Update User",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            /* Expanded(
                              child: SfDataGrid(
                                columns: _columns!,
                                source: _userDataSource!,
                              ),
                            ), */
                            //return List<GridColumn> getColumns(),
                            //
                            const SizedBox(
                              width: 100.0,
                            ),
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
                                    builder: (context) => UsersPage(context)));
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
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    height: 500.0,
                    /* constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ), */
                    child: FutureBuilder(
                        future: generateUserList(),
                        builder: (context, data) {
                          if (data.hasData) {
                            //num rowsPerPage;
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(
                                headerColor: Colors.black12,
                              ),
                              child: SfDataGrid(
                                allowPullToRefresh: true,
                                source: _userDataSource!,
                                columns: _columns!,
                                columnWidthMode: ColumnWidthMode.auto,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
                                gridLinesVisibility: GridLinesVisibility.both,
                                allowSorting: true,
                                allowFiltering: true,
                                allowEditing: true,
                                selectionMode: SelectionMode.singleDeselect,
                                navigationMode: GridNavigationMode.cell,
                                editingGestureType:
                                    EditingGestureType.doubleTap,
                                /* footer: Row(
                                    //mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SfDataPager(
                                        delegate: _userDataSource!,
                                        availableRowsPerPage: const <int>[
                                          10,
                                          15,
                                          20,
                                          25
                                        ],
                                        pageCount:
                                            _userDataSource!.users.length /
                                                _rowsPerPage,
                                        onRowsPerPageChanged:
                                            (int? rowsPerPage) {
                                          setState(() {
                                            rowsPerPage = rowsPerPage!;
                                          });
                                        },
                                      ),
                                    ],
                                  ) */
                                //footer: _buildDataPager(context),
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: 0.7,
                            ));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
          /* body: FutureBuilder /* <Object> */ (
              future: generateUserList(),
              builder: (context, data) {
                return data.hasData
                    ? SfDataGrid(
                        source: userDataSource!,
                        columns: _columns!,
                        columnWidthMode: ColumnWidthMode.auto)
                    : const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value: 0.8,
                      ));
              }), */
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

/* @override
Widget build(BuildContext context) {
  return _buildLayoutBuilder();
}

Widget _buildLayoutBuilder() {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
    /* static */ const double dataPagerHeight = 80;
    return Column(
      children: <Widget>[
        SizedBox(
          height: constraint.maxHeight - dataPagerHeight,
          width: constraint.maxWidth,
          /* child: const UsersPage(
              title: '',
            ) */
        ),
        Container(
          height: dataPagerHeight,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.12),
              border: Border(
                  top: BorderSide(
                      width: 0.5,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.12)))),
          //child: Align(child: _buildDataPager()),
        )
      ],
    );
  });
} */

class UserDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = _userDataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'firstname') {
      _userDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'firstname', value: newCellValue);
      users[dataRowIndex].firstName = newCellValue.toString();
    } else if (column.columnName == 'lastname') {
      _userDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'lastname', value: newCellValue);
      users[dataRowIndex].lastName = newCellValue.toString();
    } else if (column.columnName == 'job_role') {
      _userDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'job_role', value: newCellValue);
      users[dataRowIndex].jobRole = newCellValue.toString();
    } else {
      _userDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'extension', value: newCellValue);
      users[dataRowIndex].extension = newCellValue.toString() /* as int */;
    }
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType = column.columnName ==
        'extension' /*  || column.columnName == 'extension' */;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  ///Modifying frm HERE....
  UserDataSource(this.users) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _userDataGridRows = users
        .map<DataGridRow>((u) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'user_id', value: u.userId),
              DataGridCell<String>(columnName: 'firstname', value: u.firstName),
              DataGridCell<String>(columnName: 'lastname', value: u.lastName),
              DataGridCell<String>(columnName: 'job_role', value: u.jobRole),
              DataGridCell<String>(columnName: 'email', value: u.emailId),
              DataGridCell<String>(columnName: 'password', value: u.password),
              DataGridCell<String>(columnName: 'gender', value: u.gender),
              DataGridCell<String>(columnName: 'extension', value: u.extension),
              DataGridCell<int>(columnName: 'mobile', value: u.mobile),
              DataGridCell<int>(columnName: 'alter_mobile', value: u.altMobile),
              DataGridCell<String>(
                  columnName: 'birth_date', value: u.birthDate),
              DataGridCell<String>(columnName: 'join_date', value: u.joinDate),
              DataGridCell<String>(columnName: 'photo', value: u.photo),
              DataGridCell<String>(columnName: 'address', value: u.address),
              DataGridCell<String>(columnName: 'city', value: u.city),
              DataGridCell<String>(columnName: 'country', value: u.country),
              DataGridCell<String>(columnName: 'region', value: u.region),
              DataGridCell<int>(columnName: 'postal_code', value: u.postalCode),
              DataGridCell<String>(columnName: 'report_to', value: u.reportsTo),
              DataGridCell<String>(
                  columnName: 'description', value: u.description),
            ]))
        .toList();
  }

  List<User> users = [];
  List<DataGridRow> _userDataGridRows = [];

  @override
  List<DataGridRow> get rows => _userDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGrid() {
    notifyListeners();
  }
}

class User {
  int userId;
  String firstName;
  String lastName;
  String jobRole;
  String emailId;
  String password;
  String gender;
  String extension;
  int mobile;
  int altMobile;
  String birthDate;
  String joinDate;
  String photo;
  String address;
  String city;
  String country;
  String region;
  int postalCode;
  String reportsTo;
  String description;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.jobRole,
    required this.emailId,
    required this.password,
    required this.gender,
    required this.extension,
    required this.mobile,
    required this.altMobile,
    required this.birthDate,
    required this.joinDate,
    required this.photo,
    required this.address,
    required this.city,
    required this.country,
    required this.region,
    required this.postalCode,
    required this.reportsTo,
    required this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: int.parse(json['user_id']),
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      jobRole: json['job_role'] as String,
      emailId: json['email'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
      extension: json['extension'] as String,
      mobile: int.parse(json['mobile']),
      altMobile: int.parse(json['alter_mobile']),
      birthDate: json['birth_date'] as String,
      joinDate: json['join_date'] as String,
      photo: json['photo'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      region: json['region'] as String,
      postalCode: int.parse(json['postal_code']),
      reportsTo: json['report_to'] as String,
      description: json['description'] as String,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context) /* ; */
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/* class _PagingDataGridState extends UsersPageState {
  int rowsPerPage = 15;
  // Default pager height
  static const double dataPagerHeight = 60;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  /* @override
  late UserDataGridSource _userDataSource; */

/*   @override
  void initState() {
    super.initState();
    isWebOrDesktop = model.isWeb || model.isDesktop;
    orderInfoDataSource =
        OrderInfoDataGridSource(isWebOrDesktop: true, orderDataCount: 300);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isLandscapeInMobileView = !isWebOrDesktop &&
        MediaQuery.of(context).orientation == Orientation.landscape;
  } */

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
          //brightness: model.themeData.colorScheme.brightness,
          //selectedItemColor: model.backgroundColor,
          ),
      child: SfDataPager(
        delegate: _userDataSource,
        availableRowsPerPage: const <int>[15, 20, 25],
        pageCount: _userDataSource.orders.length / rowsPerPage,
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            rowsPerPage = rowsPerPage!;
          });
        },
      ),
    );
  }

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return Column(
        children: <Widget>[
          SizedBox(
              height: constraint.maxHeight - dataPagerHeight,
              width: constraint.maxWidth,
              child: getColumns()),
          Container(
            height: dataPagerHeight,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.12),
                border: Border(
                    top: BorderSide(
                        width: .5,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.12)))),
            child: Align(child: _buildDataPager()),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLayoutBuilder();
  }
}
 */

