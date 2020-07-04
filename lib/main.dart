import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Rail With PageView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'NavigationRail with PageView'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  bool extended = false;
  PageController pageController=PageController(initialPage: 0);
  int onpageChanged=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                extended = !extended;
              });
            },
            child: NavigationRail(
              extended: extended,
              labelType: NavigationRailLabelType
                  .none, //extended works with this only //NavigationRailLabelType.selected, // NavigationRailLabelType.all, etc,.....
              selectedLabelTextStyle: TextStyle(color: Colors.white),
              selectedIconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.grey[900],
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                  pageController.animateToPage(selectedIndex, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
                });
              },
              destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text("Home"),),
                NavigationRailDestination(
                    icon: Icon(Icons.bookmark_border), label: Text("Bookmark")),
                NavigationRailDestination(
                    icon: Icon(Icons.location_on), label: Text("Location")),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (value){
                setState(() {
                  onpageChanged=value;
                });
              },
              scrollDirection: Axis.horizontal,
              controller: pageController,
              children: <Widget>[
                Container(
                  color: Colors.red[900],
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.pink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
