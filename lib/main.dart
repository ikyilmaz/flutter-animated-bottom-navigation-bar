import "package:flutter/material.dart";

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Bottom Navigation Bar',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final List<NavItem> items = [
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
      icon: Icons.settings,
      color: Colors.white,
      title: "Settings",
    ),
  ];

  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeIndex = 0;

  final Curve _curve = Curves.elasticOut;
  final Duration _animationDuration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final tabWidth = size.width / widget.items.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Bottom Navigation Bar'),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Hello World!"),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...widget.items.asMap().entries.map((e) {
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
                              duration: _animationDuration,
                              curve: _curve,
                              top: isActive ? -30 : 15,
                              left: tabWidth / 2 - 10,
                              child: Icon(
                                e.value.icon,
                                color: Colors.white,
                              ),
                            ),
                            AnimatedPositioned(
                              duration: _animationDuration,
                              curve: _curve,
                              width: tabWidth,
                              bottom: isActive ? 15 : -30,
                              child: Text(
                                e.value.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              curve: _curve,
              duration: _animationDuration,
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
