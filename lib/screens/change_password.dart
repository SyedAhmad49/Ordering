import 'package:ordering/files_export.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:delayed_consumer_hud/delayed_consumer_hud.dart';
import '../constants.dart';
import '../validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String id = 'change_password_screen';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var url = Uri.https(
      'ma-auth-apis.azurewebsites.net', '/api/Authenticate/ChangePassword');
  bool isShow = false;
  late String username;
  late String oldPassword;
  late String newPassword;

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

  Future<Login> loginUser(String email, String oldPassword ,String newPassword) async {
    late var data;
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'oldPassword': oldPassword,
        'newPassword':newPassword
      }),
    );
    print(response.body);
    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print('hey from data status code 200 $data');
        String message = data['title'];
        // name = data['user']['firstName'] + ' ' + data['user']['lastName'];
        // token = data['api_key'];
        // username = data['user']['userName'];
        // await setSharedPreferences(token, name, username);
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
        return Login.fromJson(data);
      }
      else {
        data = jsonDecode(response.body);
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
    return Login.fromJson(data);
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
          backgroundColor: Colors.white,
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
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/logo.jpg'),
                            radius: 60,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'Change password',
                            style: ThemeText.kHeading,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Username',
                          style: ThemeText.kHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: TextFormField(
                            validator: kEmailValidator,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            onSaved: (value) {
                              username = value!;
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Enter your username'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Old Password',
                          style: ThemeText.kHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: TextFormField(
                            validator: kPasswordValidator,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            onSaved: (value) {
                              oldPassword = value!;
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Enter your Old Password'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'New Password',
                          style: ThemeText.kHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: TextFormField(
                            validator: kPasswordValidator,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            onSaved: (value) {
                              newPassword = value!;
                            },
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Enter your New Password'),
                          ),
                        ),
                      ),
                      Center(
                        child: RoundedButton(
                          title: 'Change Password',
                          colour: ThemeText.primaryColor,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              this.setState(() {
                                isShow = true;
                              });
                              try {
                                bool internetCheck =
                                await InternetCheck.connectivityChecker();
                                print('internet value is $internetCheck');
                                if (internetCheck == false) {
                                  this.setState(() {
                                    isShow = false;
                                  });

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(internetError);
                                } else {
                                  // await loginUser(email, password).then((
                                  //     result) {
                                  //   print('result before comparison $result');
                                  //   if (result.toString().isNotEmpty) {
                                  //     print('result with 200 comparison $result');
                                  //     setState(() {
                                  //       isShow = false;
                                  //     });
                                  //     // emailToPass = email;
                                  //     _formKey.currentState!.reset();
                                  //     Navigator.pushNamed(
                                  //         context, HomeScreen.id);
                                  //   }
                                  //   else {
                                  //     print('result without 200 $result');
                                  //     this.setState(() {
                                  //       isShow = false;
                                  //     });
                                  //     _formKey.currentState!.reset();
                                  //   }

                                  // print('value of check login is $checkLogin');
                                  // if (checkLogin.toString().isNotEmpty) {
                                  //       // arguments: email);
                                  // } else {
                                  //   });
                                  // }
                                  // });


                                  //other logic for login;
                                  var response = await loginUser(username,oldPassword,newPassword);
                                  if(response.runtimeType==Null) {
                                    print('response is equal to null$response');
                                    setState(() {
                                      isShow = false;
                                    });
                                  }
                                  else
                                  {
                                    print('response is $response');
                                    setState(() {
                                      isShow = false;
                                    });
                                  }
                                }
                              }catch (e)
                              {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                      Center(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.id);
                              },
                              child: Text(
                                'Want to Sign In',
                                style: ThemeText.kSubHeading
                                    .copyWith(color: Colors.green),
                              ))),
                      _divider(),
                      Center(
                        child: RoundedButton(
                          title: 'Sign Up as Seller/Buyer',
                          colour: ThemeText.primaryColor,
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                        ),
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
                thickness: 2,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
