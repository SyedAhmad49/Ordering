import 'package:ordering/Models/category.dart';
class CategoriesList
{
  List<Category> categories = [
    Category("https://images.unsplash.com/photo-1546793665-c74683f339c1", 'Salad'),
    Category("https://images.unsplash.com/photo-1516684669134-de6f7c473a2a", 'Chicken'),
    Category("https://images.unsplash.com/photo-1510130387422-82bed34b37e9", 'Fish'),
    Category("https://images.unsplash.com/photo-1598866594230-a7c12756260f", 'Spaghetti'),
    Category("https://images.unsplash.com/photo-1583623025817-d180a2221d0a", 'Sushi'),
    Category("https://images.unsplash.com/photo-1583623025817-d180a2221d0a", 'Steak'),
    Category("https://images.unsplash.com/photo-1582263953546-5a1348a24312", 'Oyster'),
    Category("https://images.unsplash.com/photo-1513104890138-7c749659a591", 'Pizza'),
  ];

  int getLength()
  {
    return categories.length;
  }
  String getUrl(int index)
  {
    return categories[index].url;
  }
  String getName(int index)
  {
    return categories[index].name;
  }
}

