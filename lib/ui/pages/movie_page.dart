part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        /// Header
        Container(
          padding: EdgeInsets.fromLTRB(
            defaultMargin,
            defaultMargin,
            defaultMargin,
            32,
          ),
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((imageUrl) {
                    imageFileToUpload = null;
                    context.bloc<UserBloc>().add(
                          UpdateData(
                            profilePicture: imageUrl,
                          ),
                        );
                  });
                }
                String url = userState.user.profilePicture;
                return Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF5F558B),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          SpinKitFadingCircle(
                            color: accentColor2,
                            size: 48,
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: (url == ""
                                    ? AssetImage("assets/user_pic.png")
                                    : NetworkImage(url)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (2 * defaultMargin) -
                              48 -
                              (2 * 6) -
                              16,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            decimalDigits: 0,
                            symbol: 'IDR ',
                          ).format(userState.user.balance),
                          style: yellowNumberFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),

        /// Now Playing
        Container(
          margin: EdgeInsets.fromLTRB(
            defaultMargin,
            32,
            defaultMargin,
            16,
          ),
          child: Text(
            'Now Playing',
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// Now Playing Movie Card
        SizedBox(
          height: 148,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(0, 10);
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right:
                          (index == (movies.length - 1)) ? defaultMargin : 16,
                    ),
                    child: MovieCard(
                      movies[index],
                      onTap: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToMovieDetailPage(movies[index]));
                        return;
                      },
                    ),
                  ),
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 48,
                );
              }
            },
          ),
        ),

        /// Browse Movie
        Container(
          margin: EdgeInsets.fromLTRB(
            defaultMargin,
            32,
            defaultMargin,
            16,
          ),
          child: Text(
            'Browse Movie',
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// Browse Movie Genre Card
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              var selectedGenres = userState.user.selectedGenres;
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    selectedGenres.length,
                    (index) => BrowseButton(selectedGenres[index]),
                  ),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 48,
              );
            }
          },
        ),

        /// Coming Soon
        Container(
          margin: EdgeInsets.fromLTRB(
            defaultMargin,
            32,
            defaultMargin,
            16,
          ),
          child: Text(
            'Coming Soon',
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// Coming Soon Movie Card
        SizedBox(
          height: 148,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(10);
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right:
                          (index == (movies.length - 1)) ? defaultMargin : 16,
                    ),
                    child: ComingSoonCard(movies[index]),
                  ),
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 48,
                );
              }
            },
          ),
        ),

        /// Get Lucky Day
        Container(
          margin: EdgeInsets.fromLTRB(
            defaultMargin,
            32,
            defaultMargin,
            16,
          ),
          child: Text(
            'Get Lucky Day',
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// Promo Card
        Column(
          children: dummyPromos
              .map(
                (promo) => Padding(
                  padding: EdgeInsets.fromLTRB(
                    defaultMargin,
                    0,
                    defaultMargin,
                    16,
                  ),
                  child: PromoCard(promo),
                ),
              )
              .toList(),
        ),

        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
