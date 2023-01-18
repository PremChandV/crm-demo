// ignore_for_file: file_names
/*import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
//library flutter_sidebar;
import 'dart:math' show min;
//import 'users.dart';

class AdminPage extends StatefulWidget {
  AdminPage(
      {Key key,
      this.lastname,
      String username,
      this.tabs,
      this.onTabChanged,
      this.activeTabIndices})
      : super(key: key);
  final String lastname;

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> tabs;
  final void Function(String) onTabChanged;
  final List<int> activeTabIndices;

  // const Sidebar({
  //   Key key,
  //   @required this.tabs,
  //   this.onTabChanged,
  //   this.activeTabIndices,
  // }) : super(key: key);

  //Sidebar.fromJson({
  AdminPage.fromJson({
    Key key,
    @required this.tabs,
    this.onTabChanged,
    this.activeTabIndices,
    this.lastname,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SidebarState createState() => _SidebarState();
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: const Text("Admin - Inbox  (Welcome Admin)"),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    //backgroundColor: canvasColor,
                    //title: Text(_getTitleByIndex(_controller.selectedIndex)),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            drawer: SidebarX(controller: _controller),
            body: Row(
                /*children: [
                if (!isSmallScreen) SidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _Screens(
                      controller: _controller,
                    ),
                  ),
                ),
              ], */
                ),
          );
        },
      ),

      /*appBar: AppBar(
        title: const Text("Admin - Inbox  (Welcome Admin)"),
      ),
      body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ), */
    );
  }
}

/*class SidebarX extends StatelessWidget {
  const SidebarX({
    //Key? key,
    Key key,
    //required SidebarXController controller,
    SidebarXController controller,
    SidebarXTheme extendedTheme,
    Divider footerDivider,
    SizedBox Function(dynamic context, dynamic extended) headerBuilder,
    List<SidebarXItem> items,
    SidebarXTheme theme,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/avatar.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorites',
        ),
        const SidebarXItem(
          iconWidget: FlutterLogo(size: 20),
          label: 'Flutter',
        ),
      ],
    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    //Key? key,
    Key key,
    //required this.controller,
    this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [BoxShadow()],
                ),
              ),
            );
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

Object _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return const AdminUsersPage();
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1); */

/*class Sidebar extends StatefulWidget {
  

  @override
  _SidebarState createState() => _SidebarState();
} */

class _SidebarState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  static const double _maxSidebarWidth = 300;
  double _sidebarWidth = _maxSidebarWidth;
  List<int> activeTabIndices;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (activeTabIndices == null) {
        final newActiveTabData = _getFirstTabIndex(widget.tabs, []);
        List<int> newActiveTabIndices = newActiveTabData[0];
        String tabId = newActiveTabData[1];
        //if (newActiveTabIndices.length > 0) {
        if (newActiveTabIndices.isNotEmpty) {
          setActiveTabIndices(newActiveTabIndices);
          if (widget.onTabChanged != null) widget.onTabChanged(tabId);
        }
      }
    });
  }

  List<Object> _getFirstTabIndex(
      List<Map<String, dynamic>> tabs, List<int> indices) {
    String tabId;
    //if (tabs.length > 0) {
    if (tabs.isNotEmpty) {
      Map<String, dynamic> firstTab = tabs[0];
      tabId = firstTab['id'] ?? firstTab['title'];
      indices.add(0);

      if (firstTab['children'] != null) {
        final tabData = _getFirstTabIndex(firstTab['children'], indices);
        indices = tabData[0];
        tabId = tabData[1];
      }
    }
    return [indices, tabId];
  }

  void setActiveTabIndices(List<int> newIndices) {
    setState(() {
      activeTabIndices = newIndices;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _sidebarWidth = min(mediaQuery.size.width * 0.7, _maxSidebarWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      width: _sidebarWidth,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Container(color: Theme.of(context).primaryColor),
          ),
          Expanded(
            child: Material(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => SidebarItem(
                  widget.tabs[index],
                  widget.onTabChanged,
                  activeTabIndices,
                  setActiveTabIndices,
                  index: index,
                ),
                itemCount: widget.tabs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final void Function(String) onTabChanged;
  final List<int> activeTabIndices;
  final void Function(List<int> newIndices) setActiveTabIndices;
  final int index;
  final List<int> indices;

  const SidebarItem(
    this.data,
    this.onTabChanged,
    this.activeTabIndices,
    this.setActiveTabIndices, {
    Key key,
    this.index,
    this.indices,
  })  : assert(
          (index == null && indices != null) ||
              (index != null && indices == null),
          'Exactly one parameter out of [index, indices] has to be provided',
        ),
        super(key: key);

  bool _indicesMatch(List<int> a, List<int> b) {
    for (int i = 0; i < min(a.length, b.length); i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Widget _buildTiles(Map<String, dynamic> root) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _indices = indices ?? [index];
    if (root['children'] == null) {
      return ListTile(
        selected: activeTabIndices != null &&
            _indicesMatch(_indices, activeTabIndices),
        contentPadding:
            EdgeInsets.only(left: 16.0 + 20.0 * (_indices.length - 1)),
        title: Text(root['title']),
        onTap: () {
          setActiveTabIndices(_indices);
          if (onTabChanged != null) onTabChanged(root['id'] ?? root['title']);
        },
      );
    }

    List<Widget> children = [];
    for (int i = 0; i < root['children'].length; i++) {
      Map<String, dynamic> item = root['children'][i];
      final itemIndices = [..._indices, i];
      children.add(
        SidebarItem(
          item,
          onTabChanged,
          activeTabIndices,
          setActiveTabIndices,
          indices: itemIndices,
        ),
      );
    }

    return CustomExpansionTile(
      tilePadding: EdgeInsets.only(
        left: 16.0 + 20.0 * (_indices.length - 1),
        right: 12.0,
      ),
      selected:
          activeTabIndices != null && _indicesMatch(_indices, activeTabIndices),
      title: Text(root['title']),
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(data);
  }
}

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key key,
    this.leading,
    @required this.title,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.selected,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
  })  : assert(initiallyExpanded != null),
        assert(maintainState != null),
        assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        ),
        super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Widget trailing;
  final bool selected;
  final bool initiallyExpanded;
  final bool maintainState;
  final EdgeInsetsGeometry tilePadding;
  final Alignment expandedAlignment;
  final CrossAxisAlignment expandedCrossAxisAlignment;
  final EdgeInsetsGeometry childrenPadding;

  @override
  // ignore: library_private_types_in_public_api
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  static const _expansionDuration = Duration(milliseconds: 200);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: _expansionDuration, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged(_isExpanded);
    }
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            selected: widget.selected ?? false,
            onTap: _handleTap,
            contentPadding: widget.tilePadding,
            leading: widget.leading,
            title: widget.title,
            subtitle: widget.subtitle,
            trailing: widget.trailing ??
                RotationTransition(
                  turns: _iconTurns,
                  child: const Icon(Icons.expand_more),
                ),
          ),
          ClipRect(
            child: Align(
              alignment: widget.expandedAlignment ?? Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
        offstage: closed,
        child: TickerMode(
          enabled: !closed,
          child: Padding(
            padding: widget.childrenPadding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: widget.expandedCrossAxisAlignment ??
                  CrossAxisAlignment.center,
              children: widget.children,
            ),
          ),
        ));

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
} */
