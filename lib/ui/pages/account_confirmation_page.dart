part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  RegistrationData registrationData;
  bool isSigningUp;

  @override
  void initState() {
    super.initState();
    registrationData = widget.registrationData;
    isSigningUp = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToPreferencePage(registrationData));
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
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                      bottom: 96,
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
                            'Confirm\nNew Account',
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
                    width: 156,
                    height: 156,
                    margin: EdgeInsets.only(
                      bottom: defaultMargin,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: (registrationData.profilePicture == null)
                            ? AssetImage('assets/user_pic.png')
                            : FileImage(registrationData.profilePicture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Welcome',
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${registrationData.name}',
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 108,
                  ),
                  (isSigningUp)
                      ? SpinKitFadingCircle(
                          color: accentColor4,
                          size: 48,
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 48,
                          child: RaisedButton(
                            color: accentColor4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Create My Account',
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  registrationData.profilePicture;

                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                registrationData.email,
                                registrationData.password,
                                registrationData.name,
                                registrationData.selectedGenres,
                                registrationData.selectedLanguage,
                              );

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: errorColor,
                                  message: result.message,
                                ).show(context);
                              }
                            },
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
