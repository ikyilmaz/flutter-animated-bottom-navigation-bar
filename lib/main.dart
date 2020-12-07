import "package:flutter/material.dart";

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Bottom Navigation Bar',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.home,
      color: Colors.white,
      title: "Home",
    ),
    NavItem(
      icon: Icons.add_box_outlined,
      color: Colors.white,
      title: "Add",
    ),
    NavItem(
      icon: Icons.search,
      color: Colors.white,
      title: "Search",
    ),
    NavItem(
      icon: Icons.settings,
      color: Colors.white,
      title: "Settings",
    ),
  ];

  final List<String> dropdownItems = [
    "Day",
    "Night",
    "Day and Night",
    "Midnight"
  ];

  final double _navHeight = 50;

  final Curve _curve = Curves.elasticOut;
  final Duration _animationDuration = Duration(seconds: 1);

  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeIndex = 0;
  String _value = "Day";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final tabWidth = size.width / widget._navItems.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Bottom Navigation Bar'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: DropdownButton(
          icon: Icon(Icons.wb_sunny),
          value: _value,
          items: [
            ...widget.dropdownItems.map(
              (e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ),
            )
          ],
          onChanged: (value) => setState(() => _value = value),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(widget._navHeight / 1.5))),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...widget._navItems.asMap().entries.map((e) {
                  final int index = e.key;
                  final bool isActive = _activeIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeIndex = index;
                        });

                        print("Current Index --> $_activeIndex");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          // border: Border(right: BorderSide(width: 1)),
                        ),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: widget._animationDuration,
                              curve: widget._curve,
                              top: isActive
                                  ? -(widget._navHeight / 2)
                                  : (widget._navHeight / 4),
                              left: tabWidth / 2 - 10,
                              child: Icon(
                                e.value.icon,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .color,
                              ),
                            ),
                            AnimatedPositioned(
                              duration: widget._animationDuration,
                              curve: widget._curve,
                              width: tabWidth,
                              bottom: isActive
                                  ? (widget._navHeight / 4)
                                  : -(widget._navHeight / 2),
                              child: Text(
                                e.value.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .button
                                      .color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
            AnimatedPositioned(
              bottom: -2,
              left: (tabWidth * _activeIndex) + tabWidth / 7,
              child: Container(
                width: tabWidth * 0.7,
                height: 6,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryTextTheme.button.color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              curve: widget._curve,
              duration: widget._animationDuration,
            )
          ],
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final Color color;
  final String title;

  NavItem({@required this.icon, @required this.color, @required this.title});
}
