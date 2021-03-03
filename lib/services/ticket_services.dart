part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieId': ticket.movieDetail.id ?? '',
      'userId': id ?? '',
      'theatreName': ticket.theatre.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userId'] == userId);

    List<Ticket> tickets = [];

    for (var document in documents) {
      MovieDetail movieDetail =
          await MovieServices.getDetail(document.data['movieId']);
      tickets.add(
        Ticket(
          movieDetail,
          Theatre(document.data['theatreName']),
          DateTime.fromMillisecondsSinceEpoch(document.data['time']),
          document.data['bookingCode'],
          document.data['seats'].toString().split(','),
          document.data['name'],
          document.data['totalPrice'],
        ),
      );
    }

    return tickets;
  }
}
