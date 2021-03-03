part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(),
          builder: (_, snapshot) =>
              (snapshot.connectionState == ConnectionState.done)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.only(bottom: 70),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ticket == null
                                    ? "assets/top_up_done.png"
                                    : "assets/ticket_done.png",
                              ),
                            ),
                          ),
                        ),
                        Text(
                          (ticket == null) ? "Emmm Yummy!" : "Happy Watching!",
                          style: blackTextFont.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          (ticket == null)
                              ? "You have successfully\ntop up the wallet"
                              : "You have successfully\nbought the ticket",
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 48,
                          margin: EdgeInsets.only(
                            top: 70,
                            bottom: 36,
                          ),
                          child: RaisedButton(
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              (ticket == null) ? "My Wallet" : "My Tickets",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Discover new movie? ",
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToMainPage());
                              },
                              child: Text(
                                "Back to Home",
                                style: purpleTextFont,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        color: mainColor,
                        size: 48,
                      ),
                    ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userId));

    await TransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp() async {}
}
