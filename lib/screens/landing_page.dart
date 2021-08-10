import 'package:ordering/files_export.dart';

class LandingPage extends StatelessWidget {
  static String id = "Landing Page";

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: ThemeText.backgroundColor,
        body: Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Hero(tag: 'logo',
                child: CircleAvatar(
                    radius:
                    MediaQuery.of(context).size.height * 0.1,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1546793665-c74683f339c1')),
              ),
              SizedBox(height: 20,),
              Text('Ordering',style: ThemeText.kBigHeading,),
              SizedBox(height: 20,),
              Text('Welcome to Food Deleivery',style: ThemeText.kHeading,),
              SizedBox(height: 20,),
              RoundedButton(title: "Sign In",colour: ThemeText.buttonColor,onPressed: (){Navigator.pushNamed(context, LoginScreen.id);},),
              SizedBox(height: 10,),
              RoundedButton(title: "Sign Up",colour: Color(0xff202040),onPressed: (){Navigator.pushNamed(context, RegisterScreen.id);},),

            ],
          ),
        ),
      ),
    )));
  }
}
