import 'package:ordering/files_export.dart';
import 'package:ordering/screens/home_screen.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late String name;
  final logoutSuccess = SnackBar(
    content: Text('Logged Out Successfully...'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(30.0),
    behavior: SnackBarBehavior.floating,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                    AssetImage('images/icon.png')
                  ),
                ),
              ],
            ),
            Card(
                child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
              leading: Icon(Icons.home),
              title: Text('Home'),
            )),
            Card(
                child: ListTile(
              onTap: () {},
              leading: Icon(Icons.help),
              title: Text('Help'),
            )),
            Card(
                child: ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            )),
            Card(
                child: ListTile(
              onTap: () {
                removeSharedPrefereneces();
                ScaffoldMessenger.of(context).showSnackBar(logoutSuccess);

                //Navigator.pushNamed(context, LoginScreen.id);
                Navigator.pushReplacementNamed(context, LoginScreen.id,
                    result: null);
              },
              leading: Icon(Icons.logout),
              title: Text('log out'),
            )),
          ],
        ),
      ),
    );
  }

  void removeSharedPrefereneces() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    print('name after removing is ${pref.getString('token')}');
  }
}
