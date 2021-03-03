part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(
              primaryColor: accentColor2,
            ),
          ),
        );
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      child: Image.asset("assets/logo.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text(
                        "Welcome Back,\nExplorer",
                        style: blackTextFont.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Email Addres",
                        hintText: "Email Address",
                      ),
                      onChanged: (email) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(email);
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Password",
                        hintText: "Password",
                      ),
                      onChanged: (password) {
                        setState(() {
                          isPasswordValid = password.length >= 6;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Forgot Password? ",
                          style: greyTextFont.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Get Now",
                          style: purpleTextFont.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        margin: EdgeInsets.only(
                          top: 40,
                          bottom: 30,
                        ),
                        child: isSigningIn
                            ? SpinKitFadingCircle(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                backgroundColor:
                                    (isEmailValid && isPasswordValid)
                                        ? mainColor
                                        : disabledColor,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: (isEmailValid && isPasswordValid)
                                      ? Colors.white
                                      : accentColor3,
                                ),
                                onPressed: (isEmailValid && isPasswordValid)
                                    ? () async {
                                        setState(() {
                                          isSigningIn = true;
                                        });

                                        SignInSignUpResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        if (result.user == null) {
                                          setState(() {
                                            isSigningIn = false;
                                          });

                                          Flushbar(
                                            duration: Duration(seconds: 4),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: errorColor,
                                            message: result.message,
                                          )..show(context);
                                        }
                                      }
                                    : null,
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Start Fresh Now? ",
                          style: greyTextFont.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: purpleTextFont,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
