import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class IconListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  IconListItem(
      {this.icon = Icons.local_offer,
      required this.text,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle = TextStyle(
      fontSize: 20,
      color: theme.colorScheme.onPrimary,
    );

    Widget row = Padding(
      padding: EdgeInsets.only(right: 10),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 65,
          height: 65,
          child: Icon(
            icon,
            color: theme.colorScheme.onPrimary,
            size: 40,
          ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ],
    ));
    Widget container = Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Ink(
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryVariant,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              // BoxShadow(
              //   offset: Offset(2, 2),
              //   color: Colors.grey[400]!,
              //   blurRadius: 2,
              // )
            ],
          ),
          height: 65,
          child: (onTap != null)
              ? InkWell(
                  onTap: onTap,
                  child: row,
                  borderRadius: BorderRadius.circular(10),
                )
              : row,
        ));

    return container;
    // return (onTap != null) ? InkWell(onTap: onTap, child: container) : container;
    // ? InkWell(
    //     onTap: onTap,
    //     child: container,
    //   )
    // : container,
  }
}
