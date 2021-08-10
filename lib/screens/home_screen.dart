import 'package:ordering/files_export.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedMenuItem = 0;
  CategoriesList categoriesList = new CategoriesList();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      _showMyDialog(); // Action to perform on back pressed
      return false;
    },
    child:SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeText.backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: ThemeText.primaryColor,
        //   title: Text('Home', style: ThemeText.kBigHeading),
        //   actions: [
        //     Icon(Icons.notifications_active),
        //     Padding(
        //       padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        //       child: Icon(
        //         Icons.shopping_cart,
        //       ),
        //     ),
        //   ],
        // ),
        drawer: MyDrawer(),
        body: Container(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                          !isSearching?IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ), onPressed: () { _scaffoldKey.currentState!.openDrawer(); },
                          ):IconButton(
                            icon: Icon(
                              Icons.search,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ), onPressed: () {

                          },
                          ),
                      !isSearching
                          ?  Text('Menu', style: ThemeText.kHeading)
                          : Expanded(
                            child: TextField(
                                onChanged: (value) {
                                  _filterCountries(value);
                                },
                                style: ThemeText.kSubHeading,
                                decoration: InputDecoration(
                                    hintText: "Search Categories Here",
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                          ),
                      !isSearching?IconButton(
                        icon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ), onPressed: () {setState(() {
                        this.isSearching = true;
                      }); },
                      ):IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ), onPressed: () {  setState(() {
                        this.isSearching = false;
                        });},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      physics: ScrollPhysics(),
                      itemCount: categoriesList.getLength(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pushNamed(context, MenuDetails.id);
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              color: ThemeText.containerColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(categoriesList.getUrl(index),
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.09,
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    categoriesList.getName(index),
                                    style: ThemeText.kSubHeading,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    ),);
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You Sure you want to exit'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
  void _filterCountries(String value) {}
// Widget buildCategory(int index) {
//
// }

}
