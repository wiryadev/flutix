part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  final List<String> genres = [
    'Horror',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime',
  ];
  final List<String> languages = [
    'Bahasa',
    'English',
    'Japanese',
    'Korean',
  ];

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = 'English';
  RegistrationData registrationData;

  @override
  void initState() {
    super.initState();
    registrationData = widget.registrationData;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        registrationData.password = '';

        context.bloc<PageBloc>().add(GoToRegistrationPage(registrationData));

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                      bottom: 6,
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                      ),
                      onTap: () {
                        registrationData.password = '';

                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(registrationData));
                      },
                    ),
                  ),
                  Text(
                    'Select Your 4\nFavorite Genres',
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: defaultMargin,
                    runSpacing: defaultMargin,
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    'Movie Language\nYou Prefer',
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLanguageWidgets(context),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Center(
                    child: FloatingActionButton(
                      backgroundColor: mainColor,
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                      onPressed: () {
                        if (selectedGenres.length != 4) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: errorColor,
                            message: 'Please select 4 genres',
                          )..show(context);
                        } else {
                          registrationData.selectedGenres = selectedGenres;
                          registrationData.selectedLanguage = selectedLanguage;

                          context.bloc<PageBloc>().add(
                                GoToAccountConfirmationPage(
                                  registrationData,
                                ),
                              );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (3 * defaultMargin)) / 2;

    return widget.genres
        .map((genre) => SelectableBox(
              genre,
              width: width,
              isSelected: selectedGenres.contains(genre),
              onTap: () {
                onSelectGenre(genre);
              },
            ))
        .toList();
  }

  List<Widget> generateLanguageWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (3 * defaultMargin)) / 2;

    return widget.languages
        .map((language) => SelectableBox(
              language,
              width: width,
              isSelected: selectedLanguage == language,
              onTap: () {
                setState(() {
                  selectedLanguage = language;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
