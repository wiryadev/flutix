part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Ticket ticket;

  @override
  void initState() {
    super.initState();

    ticket = widget.ticket;
  }

  @override
  Widget build(BuildContext context) {
    int total = 26500 * ticket.seats.length;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSeatPage(ticket));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    // note: BACK BUTTON
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 20,
                            left: defaultMargin,
                          ),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToSelectSeatPage(ticket));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) {
                        User user = (userState as UserLoaded).user;

                        return Column(
                          children: <Widget>[
                            // note: PAGE TITLE
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: Text(
                                "Checkout\nMovie",
                                style: blackTextFont.copyWith(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // note: MOVIE DESCRIPTION
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 90,
                                  margin: EdgeInsets.only(
                                    left: defaultMargin,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        imageBaseUrl +
                                            'w342' +
                                            widget
                                                .ticket.movieDetail.posterPath,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          70 -
                                          20,
                                      child: Text(
                                        ticket.movieDetail.title,
                                        style: blackTextFont.copyWith(
                                          fontSize: 18,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          70 -
                                          20,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      child: Text(
                                        ticket.movieDetail.genresAndLanguage,
                                        style: greyTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    RatingStars(
                                      voteAverage:
                                          ticket.movieDetail.voteAverage,
                                      color: accentColor3,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: defaultMargin,
                                ),
                                child: Divider(
                                  color: disabledColor,
                                  thickness: 1,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Order ID",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    ticket.bookingCode,
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Cinema",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text(
                                      ticket.theatre.name,
                                      textAlign: TextAlign.end,
                                      style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Date & Time",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    ticket.time.dateAndTime,
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Seat Numbers",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text(
                                      ticket.seatsInString,
                                      textAlign: TextAlign.end,
                                      style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Price",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "IDR 25.000 x ${ticket.seats.length}",
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Fee",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "IDR 1.500 x ${ticket.seats.length}",
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Total",
                                      style: greyTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                      symbol: 'IDR ',
                                    ).format(total),
                                    style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                                vertical: 20,
                              ),
                              child: Divider(
                                color: Color(0xFFE4E4E4),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Your Wallet",
                                    style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                      symbol: 'IDR ',
                                    ).format(user.balance),
                                    style: whiteNumberFont.copyWith(
                                      color: user.balance >= total
                                          ? accentColor4
                                          : errorColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 48,
                              margin: EdgeInsets.only(
                                top: 36,
                                bottom: 48,
                              ),
                              child: RaisedButton(
                                color: user.balance >= total
                                    ? accentColor4
                                    : mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  user.balance >= total
                                      ? "Checkout Now"
                                      : "Top Up My Wallet",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  if (user.balance >= total) {
                                    FlutixTransaction transaction =
                                        FlutixTransaction(
                                      userId: user.id,
                                      title: ticket.movieDetail.title,
                                      subtitle: ticket.theatre.name,
                                      time: DateTime.now(),
                                      amount: -total,
                                      picture: ticket.movieDetail.posterPath,
                                    );

                                    context.bloc<PageBloc>().add(
                                          GoToSuccessPage(
                                            ticket.copyWith(
                                              totalPrice: total,
                                            ),
                                            transaction,
                                          ),
                                        );
                                  } else {
                                    // # Uang tidak cukup
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
