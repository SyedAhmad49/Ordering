import 'package:ordering/files_export.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:delayed_consumer_hud/delayed_consumer_hud.dart';
import '../constants.dart';
import '../validator.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();
  var url = Uri.https(
      'ma-auth-apis.azurewebsites.net', '/api/Authenticate/login');
  bool isShow = false;
  late String token;
  late String name;
  late String username;

  late SharedPreferences sharedPreferences;
  final internetError = SnackBar(
    content: Text('No Internet connection 😑'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(30.0),
    behavior: SnackBarBehavior.floating,
  );
  final loginSuccess = SnackBar(
    content: Text('LoggedIn Successfully...'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(30.0),
    behavior: SnackBarBehavior.floating,
  );

  void getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.microphone
    ].request();
    print(statuses);
  }

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loginUser(String email, String password) async {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
      }),
    );
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // name = data['user']['firstName'] + ' ' + data['user']['lastName'];
        // token = data['api_key'];
        // username = data['user']['userName'];
        // await setSharedPreferences(token, name, username);
        ScaffoldMessenger.of(context).showSnackBar(loginSuccess);
        // return Login.fromJson(data);
        return data;
      }
      else {
        var data = jsonDecode(response.body);
        print('Hey from data status code other than 200 $data');
        String message = data['title'];
        final snackBar = SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
          margin: EdgeInsets.all(30.0),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    } catch (e) {
      print('exception is $e');
    }
  }

  Future<void> setSharedPreferences(String token, String name,
      String username) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString("token", token);
      sharedPreferences.setString("username", username);
      sharedPreferences.setString("name", name);
      //This is from shared preferences global variable mEmail.Have to change it later on
      var myEmail = sharedPreferences.getString('username');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    // String emailToPass = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () async {
        _showMyDialog(); // Action to perform on back pressed
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ThemeText.backgroundColor,
          body: DelayedHud(
            hud: CircularProgressIndicator(),
            showHud: () => isShow,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30.0, bottom: 20.0),
                          child: Hero(tag:"logo",
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1546793665-c74683f339c1'),
                              radius: MediaQuery.of(context).size.height*0.15,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text('Sign In',style: ThemeText.kBigHeading.copyWith(color: ThemeText.primaryColor),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                        child: Material(
                          elevation: 10.0,color: ThemeText.containerColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextFormField(
                            validator: kEmailValidator,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            onSaved: (value) {
                              email = value!;
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Your Email'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 10.0,color: ThemeText.containerColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextFormField(
                            validator: kPasswordValidator,
                            keyboardType: TextInputType.text,
                            obscuringCharacter: '*',
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            onSaved: (value) {
                              password = value!;
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Your Password'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child: RoundedButton(
                          title: 'Sign In',
                          colour: ThemeText.buttonColor,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              // Scaffold
                              //     .of(context)
                              //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                              this.setState(() {
                                isShow = true;
                              });
                              try {
                                // bool internetCheck = await InternetCheck.connectivityChecker();
                                // print('internet value is $internetCheck');
                                // if(internetCheck==false)
                                // {
                                //   this.setState(() {
                                //     isShow = false;
                                //   });
                                //
                                //   ScaffoldMessenger.of(context).showSnackBar(internetError);
                                // }
                                // else {
                                // await loginUser(email, password).then((value) {
                                //   print('value of value is $value');
                                //   Navigator.pushNamed(context, HomeScreen.id);
                                // });
                                 var checkLogin = await loginUser(
                                      email, password);
                                 if (checkLogin==null) {
                                   this.setState(() {
                                     isShow = false;
                                     _formKey.currentState!.reset();
                                   });
                                  } else {
                                   // emailToPass = email;
                                   Navigator.pushNamed(context, HomeScreen.id,
                                       arguments: email);
                                   setState(() {
                                     isShow = false;
                                   });
                                   _formKey.currentState!.reset();
                                  }
                                // }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:2,
                              child: Text('Don\'t have an Account ?',style: ThemeText.kSubHeading,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.id);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: ThemeText.kSubHeading,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              _divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ForgetPasswordScreen.id);
                              },
                              child: Text(
                                'Forgot Password ?',
                                style: ThemeText.kSubHeading),
                              ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ChangePasswordScreen.id);
                              },
                              child: Text(
                                'Change Password ?',
                                style: ThemeText.kSubHeading,
                              )),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,color: Colors.white,
              ),
            ),
          ),
          Text('or',style: ThemeText.kHeading,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
}
