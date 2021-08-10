import 'package:ordering/Models/Cart.dart';
import 'package:ordering/database/db_helper.dart';
import 'package:ordering/files_export.dart';

class MenuDetails extends StatefulWidget {
  static String id = "Menu Details";

  const MenuDetails({Key? key}) : super(key: key);

  @override
  _MenuDetailsState createState() => _MenuDetailsState();
}

class _MenuDetailsState extends State<MenuDetails>
    with SingleTickerProviderStateMixin {
  final addToCart = SnackBar(
    content: Text('Added To Cart Successfully...'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(30.0),
    behavior: SnackBarBehavior.floating,
  );
  bool isSearching = false;
  late TabController _tabController;
  List<Widget> list = [
    Tab(
        icon: Text(
      'Popular',
      style: ThemeText.kSubHeading,
    )),
    Tab(
        icon: Text(
      'All Menu',
      style: ThemeText.kSubHeading,
    )),
    Tab(
        icon: Text(
      'Discount',
      style: ThemeText.kSubHeading,
    )),
  ];

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar _getTabBar() {
    return TabBar(
      tabs: list,
      controller: _tabController,
      indicatorColor: ThemeText.primaryColor,
    );
  }

  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: [populars(), allMenu(), discount()],
      controller: _tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeText.backgroundColor,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !isSearching
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.search,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            onPressed: () {},
                          ),
                    !isSearching
                        ? Text('Salad', style: ThemeText.kHeading)
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
                    !isSearching
                        ? IconButton(
                            icon: Icon(
                              Icons.search,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            onPressed: () {
                              setState(() {
                                this.isSearching = true;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.cancel_outlined,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            onPressed: () {
                              setState(() {
                                this.isSearching = false;
                              });
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _getTabBar(),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: _getTabBarView(list),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget populars() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Hello and welcome to the kapul sharma show1',style: ThemeText.kSubHeading)],
    );
  }

  Widget allMenu() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ItemDetails.id);
              },
              child: Container(
                color: ThemeText.containerColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1546793665-c74683f339c1')),
                      ),
                      Column(
                        children: [
                          Text(
                            'Fruit',
                            style: ThemeText.kSubHeading,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('15\$', style: ThemeText.kSubHeading),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          var cartItem = Cart(url:"https://images.unsplash.com/photo-1516684669134-de6f7c473a2a",name: "Salad",price: 100,quantity: 8,dateTime: '${DateTime.now()}');
                          print(cartItem);
                          var dbHelper = DBHelper();
                          dbHelper.saveCart(cartItem);
                          _showSnackBar();
                          },
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget discount() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Hello and welcome to the kapil sharma show3',style: ThemeText.kSubHeading,)],
    );
  }
  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(addToCart);
  }
  void _filterCountries(String value) {}
}
