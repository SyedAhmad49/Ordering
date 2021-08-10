import 'package:ordering/files_export.dart';

void main() {
  WidgetsBinding.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mall App',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.red,
          // backgroundColor: Color(0xff77070),
        backgroundColor: ThemeText.backgroundColor,
          iconTheme: IconThemeData(color: Color(0xffFFBD69)),
          // bottomAppBarColor: Color(0xff202040),
          // colorScheme: ColorScheme(
          //   primary: Color(0xffFFBD69),
          //   primaryVariant: Color(0xf69AAFF),
          //   secondary: Color(0xffFFFFF),
          //   secondaryVariant: Color(0xf69AAFF),
          //   surface: Color(0xff707070),
          //   background: Color(0xff707070),
          //   error: Colors.red,
          //   brightness: Brightness.light,
          //   onSecondary: Colors.black,
          //   onSurface: Colors.black,
          //   onError: Colors.red,
          //   onPrimary: Color(0xffFFBD69),
          //   onBackground: Color(0xff707070),
          // ),
          fontFamily: 'Raleway'),
      initialRoute: NavigationScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
        ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
        NavigationScreen.id: (context) => NavigationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        CartScreen.id: (context) => CartScreen(),
        Profile.id: (context) => Profile(),
        MenuDetails.id:(context)=>MenuDetails(),
        ItemDetails.id:(context)=>ItemDetails(),
        LandingPage.id:(context)=>LandingPage()
      },
    );
  }
}
