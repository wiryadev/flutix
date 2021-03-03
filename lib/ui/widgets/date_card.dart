part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final double width;
  final double height;
  final Function onTap;

  DateCard(
    this.date, {
    this.isSelected = false,
    this.width = 72,
    this.height = 96,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? accentColor2 : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : disabledColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              date.shortDayName,
              style: blackTextFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              date.day.toString(),
              style: whiteNumberFont.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
