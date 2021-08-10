class Cart{

  late String url;
  late String name;
  late double price;
  late int quantity;
  late String dateTime;

  Cart({required this.url, required this.name,required this.price,required this.quantity,required this.dateTime});

  Cart.fromMap(Map map) {
    url = map[url];
    name = map[name];
    price = map[price];
    quantity = map[quantity];
    dateTime = map[dateTime];
  }

}