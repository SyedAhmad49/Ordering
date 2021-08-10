import 'package:flutter/material.dart';
import 'package:ordering/database/db_helper.dart';
import 'package:ordering/files_export.dart';
import 'package:collection/collection.dart';

class CartScreen extends StatefulWidget {
  static String id = 'Cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  int count = 1;
  int listCount = 0;
  int counter = 0;
  var dbHelper = DBHelper();
  double price = 0.0;
  int loop = 0;
  List<Cart> totalPrice = [];

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeText.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: ThemeText.containerColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  topRight: Radius.circular(
                    20,
                  ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Your Order',
                  style: ThemeText.kBigHeading
                      .copyWith(color: ThemeText.primaryColor),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder<List<Cart>>(
                future: getCartData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    totalPrice = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: snapshot.data.length == 0
                              ? Center(
                                  child: Text(
                                    'Cart is Empty',
                                    style: ThemeText.kBigHeading,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    // price = 0;
                                    // price = snapshot.data[index].price*snapshot.data[index].quantity;
                                    // totalPrice = [];
                                    // print('price before entering into list $price');
                                    // totalPrice.add(price);
                                    return Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: CircleAvatar(
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  backgroundImage: NetworkImage(
                                                      snapshot
                                                          .data![index].url)),
                                            ),
                                            Positioned(
                                              top: 5,
                                              right: 30,
                                              child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      Color(0xffFE6262),
                                                  child: GestureDetector(
                                                      child: Icon(
                                                        Icons.add,
                                                        color: ThemeText
                                                            .primaryColor,
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          addQuantity(
                                                              snapshot
                                                                  .data[index]
                                                                  .name);
                                                        });
                                                      })),
                                            ),
                                            Positioned(
                                              top: 40,
                                              right: 5,
                                              child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      ThemeText.backgroundColor,
                                                  child: GestureDetector(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: ThemeText
                                                            .primaryColor,
                                                      ),
                                                      onTap: () {
                                                        if(snapshot.data[index].quantity>1) {
                                                          setState(() {
                                                            removeQuantity(
                                                                snapshot
                                                                    .data[index]
                                                                    .name);
                                                          });
                                                        }
                                                        else
                                                          {
                                                            _showSnackBar();
                                                            deleteItem(snapshot
                                                              .data[index]
                                                              .name);
                                                          setState(() {
                                                            List.from(
                                                                snapshot.data)
                                                              ..removeAt(index);

                                                          });
                                                        }
                                                      })),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data[index].name,
                                          style: ThemeText.kSubHeading
                                              .copyWith(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                '\$ ${snapshot.data[index].price} ',
                                            style: ThemeText.kSubHeading
                                                .copyWith(
                                                    color:
                                                        ThemeText.priceColor),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'x ${snapshot.data[index].quantity}',
                                                  style: ThemeText.kSubHeading
                                                      .copyWith(
                                                          color: Colors.white)),
                                              TextSpan(
                                                  text:
                                                      '= ${snapshot.data[index].price * snapshot.data[index].quantity}',
                                                  style: ThemeText.kSubHeading
                                                      .copyWith(
                                                          color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ),
                        Text(
                          'Total',
                          style: ThemeText.kHeading,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${snapshot.data.length} items',
                          style: ThemeText.kSubHeading,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new Text(
                          '\$ $totalAmount',
                          style: ThemeText.kHeading
                              .copyWith(color: ThemeText.priceColor),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.hasError}');
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading... ',
                          style: ThemeText.kHeading,
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                },
              ),
              RoundedButton(
                title: 'Confirm Order',
                colour: Color(0xffFF7C65),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    ));
  }
  void _showSnackBar() {
    final addToCart = SnackBar(
      content: Text(
        'Item removed from Cart',
        style: ThemeText.kSubHeading,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(30.0),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(addToCart);
  }

  double get totalAmount {
    var total = 0.0;
    totalPrice.forEach((Cart) {
      total += Cart.price * Cart.quantity;
      print('hello from total $total');
    });
    return total;
  }

  Future<List<Cart>> getCartData() async {
    List<Cart> lst = [];
    try {
      print('Calling getCartData');
      var dbHelper = DBHelper();
      return await dbHelper.getCartItems();
    } catch (e) {
      print('exception $e');
      return lst;
    }
  }

  Future deleteItem(String name) async {
    var dbHelper = DBHelper();
    return await dbHelper.deleteCart(name);
  }

  Future removeQuantity(String name) async {
    var dbHelper = DBHelper();
    return await dbHelper.removeQuantity(name);
  }
  Future addQuantity(String name) async {
    var dbHelper = DBHelper();
    return await dbHelper.addQuantity(name);
  }
}

//commented Data
// Text(
//   '\$ ${snapshot.data[index].price} * ${snapshot.data[index].quantity}',
//   style: ThemeText.kSubHeading.copyWith(
//       color: ThemeText.priceColor),
// ),
// @override
// void initState() {
//   super.initState();
//   getCartData();
// }
// Future getCount() async
// {
//   var dbHelper = DBHelper();
//   counter = await dbHelper.getCount();
//   return counter;
// }

// Stack(
//   children: [
//     Center(
//       child: CircleAvatar(
//           radius: MediaQuery.of(context).size.height * 0.1,
//           backgroundImage: NetworkImage(
//               'https://images.unsplash.com/photo-1546793665-c74683f339c1')),
//     ),
//     Positioned(
//       top: MediaQuery.of(context).size.height * 0.02,
//       right: MediaQuery.of(context).size.width * 0.3,
//       child: CircleAvatar(
//           radius: 20,
//           backgroundColor: ThemeText.buttonColor,
//           child: IconButton(
//               icon: Icon(
//                 Icons.add,
//                 size: 20,
//                 color: Colors.white,
//               ),
//               onPressed: () {})),
//     ),
//     Positioned(
//       top: MediaQuery.of(context).size.height * 0.08,
//       right: MediaQuery.of(context).size.width * 0.26,
//       child: CircleAvatar(
//           radius: 20,
//           backgroundColor: ThemeText.backgroundColor,
//           child: IconButton(
//               icon: Icon(
//                 Icons.cancel_outlined,
//                 size: 20,
//                 color: Colors.white,
//               ),
//               onPressed: () {})),
//     ),
//   ],
// ),
// SizedBox(height: 20,),

// Dismissible(
// key: ValueKey(snapshot.data[index].name),
// direction: DismissDirection.endToStart,
// onDismissed: (direction) {
// deleteItem(snapshot.data[index].name);
// },
// child:
// Positioned(
//   top: 40,
//   right: 5,
//   child: CircleAvatar(
//       radius: 15,
//       backgroundColor:
//           ThemeText.backgroundColor,
//       child: GestureDetector(
//           child: Icon(
//             Icons.close_outlined,
//             color: ThemeText
//                 .primaryColor,
//           ),
//           onTap: () {
//             deleteItem(snapshot
//                 .data[index].name);
//             setState(() {
//               List.from(
//                   snapshot.data)
//                 ..removeAt(index);
//             });
//           })),
// ),
