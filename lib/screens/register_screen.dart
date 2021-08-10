import 'package:ordering/files_export.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../validator.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String url =
      'https://vvm-mx-dev-auth-api.azurewebsites.net/api/Authenticate/Register';
  late String username;
  late String email;
  late String password;
  bool isShow = false;
  final registerSuccess = SnackBar(
    content: Text('Registered Successfully...'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(30.0),
    behavior: SnackBarBehavior.floating,
  );

  final registerFailed = SnackBar(
    content: Text('Registration Failed...'),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(30.0),
    behavior: SnackBarBehavior.floating,
  );
  int index = 0;
  final _formKey = GlobalKey<FormState>();

  // final _formKey2 = GlobalKey<FormState>();

  Future<Register> registerUser(
      String username,
      String accountType,
      String phoneNumber) async {
    print("username $username");
    print("account type $accountType");
    print("phonenumber $phoneNumber");
    late var data;
    var url = Uri.https(
        'ma-auth-apis.azurewebsites.net', '/api/Authenticate/Register');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': username,
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    try {
      if (response.statusCode == 200) {
        data = await jsonDecode(response.body);
        print('hey data from status code 200 $data');
        ScaffoldMessenger.of(context).showSnackBar(registerSuccess);
        return Register.fromJson(data);
      } else {
        data = await jsonDecode(response.body);
        print('hey data from status code other than 200 $data');
        final snackBar = SnackBar(
          content: Text(
            '${data['message']}',
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
      print(e);
    }
    return Register.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return SafeArea(
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
                      child: Text('Sign Up',style: ThemeText.kBigHeading.copyWith(color: ThemeText.primaryColor),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Material(
                        elevation: 10.0,color: ThemeText.containerColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextFormField(
                          validator: kEmailValidator,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          onEditingComplete: () => node.nextFocus(),
                          onSaved: (value) {
                            username = value!;
                          },
                          decoration: kTextFieldInputDecoration.copyWith(
                              hintText: 'Username'),
                        ),
                      ),
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
                    RoundedButton(
                      title: 'Register',
                      colour: ThemeText.primaryColor,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database
                          this.setState(() {
                            isShow = true;
                          });
                          try {
                            await registerUser(
                                username,
                                email,
                                password,)
                                .then((result) {
                              print('result before comparison $result');
                              if (result != null) {
                                print('result from 200 $result');
                                setState(() {
                                  isShow = false;
                                });
                                // _formKey.currentState!.reset();
                                Navigator.pushNamed(
                                    context, LoginScreen.id);
                              } else {
                                print('result from other than 200 $result');
                                setState(() {
                                  isShow = false;
                                });
                                // _formKey.currentState!.reset();
                              }
                            });
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    ),
                    Center(
                      child: Row(
                        children: [
                          Expanded(flex:2,
                            child: Text('Already have an Account ?',style: ThemeText.kSubHeading,),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.id);
                              },
                              child: Text(
                                'Sign in',
                                style: ThemeText.kSubHeading,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

// @override
// void dispose() {
// _firstName.dispose();
// _lastName.dispose();
// _email.dispose();
// _password.dispose();
// _phoneNumber.dispose();
// _companyName.dispose();
//
// super.dispose();
// }
}
