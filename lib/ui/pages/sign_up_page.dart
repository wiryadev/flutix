part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    File profilePicture = widget.registrationData.profilePicture;

    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(
              primaryColor: accentColor1,
            ),
          ),
        );

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: defaultMargin,
                    ),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            'Create\nNew Account',
                            style: blackTextFont.copyWith(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 96,
                    height: 108,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 96,
                          width: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: (profilePicture == null)
                                  ? AssetImage('assets/user_pic.png')
                                  : FileImage(profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (profilePicture == null) {
                                widget.registrationData.profilePicture =
                                    await getImage();
                              } else {
                                widget.registrationData.profilePicture = null;
                              }

                              setState(() {});
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage((profilePicture == null)
                                      ? 'assets/btn_add_photo.png'
                                      : 'assets/btn_del_photo.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Full Name',
                      hintText: 'Full Name',
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  TextField(
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.arrow_forward),
                    backgroundColor: mainColor,
                    onPressed: () {
                      if (!((nameController.text.trim() != '') &&
                          (emailController.text.trim() != '') &&
                          (passwordController.text.trim()) != '' &&
                          (retypePasswordController.text.trim() != ''))) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: errorColor,
                          message: 'Please fill all the fields',
                        )..show(context);
                      } else if (passwordController.text !=
                          retypePasswordController.text) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: errorColor,
                          message: 'Mismatch password and confirm password',
                        )..show(context);
                      } else if (passwordController.text.length < 6) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: errorColor,
                          message: 'Password must be at least 6 character',
                        )..show(context);
                      } else if (!EmailValidator.validate(
                          emailController.text.trim())) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: errorColor,
                          message: 'Invalid email address',
                        )..show(context);
                      } else {
                        widget.registrationData.name = nameController.text;
                        widget.registrationData.email = emailController.text;
                        widget.registrationData.password =
                            passwordController.text;

                        context
                            .bloc<PageBloc>()
                            .add(GoToPreferencePage(widget.registrationData));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
