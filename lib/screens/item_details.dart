import 'package:ordering/database/db_helper.dart';
import 'package:ordering/files_export.dart';

class ItemDetails extends StatefulWidget {
  static String id = "itemdetails";

  const ItemDetails({Key? key}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int count = 1;
  int bottomSheetCounter = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ThemeText.backgroundColor,
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CircleAvatar(
                              backgroundColor: ThemeText.containerColor,
                              radius: MediaQuery.of(context).size.width * 0.07,
                              child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: ThemeText.primaryColor,
                                  size:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushNamed(context, CartScreen.id);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.15,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1546793665-c74683f339c1')),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.2,
                            right: MediaQuery.of(context).size.width * 0.17,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundColor: ThemeText.buttonColor,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      var cartItem = Cart(
                                          url:
                                              "https://images.unsplash.com/photo-1516684669134-de6f7c473a2a",
                                          name: "Ali Hassan",
                                          price: 100,
                                          quantity: count,
                                          dateTime: '${DateTime.now()}');
                                      print(cartItem);
                                      var dbHelper = DBHelper();
                                      dbHelper.saveCart(cartItem);
                                      _showSnackBar();
                                    })),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // border: Border.all(color: ThemeText.primaryColor)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: ThemeText.containerColor,
                              // boxShadow: B
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (count > 1) {
                                        count--;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '$count',
                                  style: ThemeText.kHeading,
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      count++;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Egg Salad',
                              style: ThemeText.kBigHeading,
                            ),
                            Text('\$ 35', style: ThemeText.kBigHeading)
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Chip(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    '250 Gram',
                                    style: ThemeText.kSubHeading,
                                  ),
                                ),
                                backgroundColor: ThemeText.backgroundColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Chip(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    '320 Kcal',
                                    style: ThemeText.kSubHeading,
                                  ),
                                ),
                                backgroundColor: ThemeText.backgroundColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Chip(
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    '15 mint',
                                    style: ThemeText.kSubHeading,
                                  ),
                                ),
                                backgroundColor: ThemeText.backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Details',
                          style: ThemeText.kBigHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'It is very tasty however you want but still we will distribute with you in full flavours by default',
                          style: ThemeText.kSubHeading,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Ingredients',
                          style: ThemeText.kBigHeading,
                        ),
                      ),
                      SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: ThemeText.containerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add,
                                          size: 35,
                                        ),
                                      ))),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: ThemeText.containerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add,
                                          size: 35,
                                        ),
                                      ))),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: ThemeText.containerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add,
                                          size: 35,
                                        ),
                                      ))),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: ThemeText.containerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add,
                                          size: 35,
                                        ),
                                      ))),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  _settingModalBottomSheet(context);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: ThemeText.containerColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.add,
                                        size: 35,
                                      ),
                                    )),
                              )),
                            ],
                          )),
                    ]),
              ),
            )));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        // isScrollControlled: true,
        builder: (BuildContext bc) {
          return SafeArea(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState
                  /*You can rename this!*/) {
                return Container(
                  // height: MediaQuery.of(context).size.height*0.7,
                  decoration: BoxDecoration(
                      color: ThemeText.backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(
                            20,
                          ))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Add Topings',
                          style: ThemeText.kHeading,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: ListView.builder(
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            height: 60,
                                            width: 40,
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                                color: ThemeText.containerColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                "https://images.unsplash.com/photo-1546793665-c74683f339c1",
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Fruit',
                                              style: ThemeText.kSubHeading,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('15\$',
                                                style: ThemeText.kSubHeading),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color:
                                                      ThemeText.containerColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 25,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    if (bottomSheetCounter >
                                                        0) {
                                                      bottomSheetCounter--;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '$bottomSheetCounter',
                                              style: ThemeText.kHeading,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color:
                                                      ThemeText.containerColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.add,
                                                  size: 25,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    bottomSheetCounter++;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '45\$',
                                    style: ThemeText.kHeading,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: RoundedButton(
                                    title: "Add to Cart",
                                    colour: ThemeText.buttonColor,
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  void _showSnackBar() {
    final addToCart = SnackBar(
      content: GestureDetector(
        onTap:()
        {

        },
        child: GestureDetector(
          onTap: (){Navigator.pushNamed(context, CartScreen.id);},
          child: RichText(
            text: TextSpan(
              text:
              '\$ $count Items added to Cart ',
              style: ThemeText.kSubHeading,
              children: <TextSpan>[
                TextSpan(
                    text:
                    ' View Cart',
                    style: ThemeText.kSubHeading
                        .copyWith(
                        color: Colors.white,decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black,
      margin: EdgeInsets.all(30.0),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(addToCart);
  }
}
// Text(
// '$count Items Added to Cart',
// style: ThemeText.kSubHeading,
// ),