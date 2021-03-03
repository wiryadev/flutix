part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavIndex = 0;
    pageController = PageController(initialPage: bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: bgColor,
            ),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavIndex = index;
              });
            },
            children: <Widget>[
              MoviePage(),
              Center(
                child: Text('My Tickets'),
              ),
            ],
          ),
          createCustomBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 48,
              width: 48,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                backgroundColor: accentColor2,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    MdiIcons.walletPlus,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createCustomBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClipper(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: BottomNavigationBar(
            // backgroundColor: Colors.transparent,
            selectedItemColor: mainColor,
            unselectedItemColor: unselectedColor,
            currentIndex: bottomNavIndex,
            onTap: (index) {
              setState(() {
                bottomNavIndex = index;
                pageController.jumpToPage(bottomNavIndex);
              });
            },
            items: [
              BottomNavigationBarItem(
                title: Text(
                  'New Movies',
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  height: 20,
                  child: Image.asset(
                    (bottomNavIndex == 0)
                        ? 'assets/ic_movie.png'
                        : 'assets/ic_movie_grey.png',
                  ),
                ),
              ),
              BottomNavigationBarItem(
                title: Text(
                  'My Tickets',
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  height: 24,
                  child: Image.asset(
                    (bottomNavIndex == 1)
                        ? 'assets/ic_tickets.png'
                        : 'assets/ic_tickets_grey.png',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 32, 0);
    path.quadraticBezierTo(size.width / 2 - 32, 36, size.width / 2, 36);
    path.quadraticBezierTo(size.width / 2 + 32, 36, size.width / 2 + 32, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
