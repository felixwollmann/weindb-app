import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';

class ExpandableBase extends StatelessWidget {
  // final WeinbauerModel weinbauer;
  final String title;
  final String subtitle;
  final IconData icon;

  final List<Widget> children;

  const ExpandableBase({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: kDefaultPadding, left: kDefaultPadding),
      child: Theme(
        data: Theme.of(context).copyWith(
            dividerColor: Theme.of(context).cardColor,
            dividerTheme: Theme.of(context)
                .dividerTheme
                .copyWith(thickness: 0, color: Colors.transparent)),
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            // trailing: trailing,
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Icon(icon),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.topLeft,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding, right: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // State<ExpandableBase> createState() => _ExpandableBaseState();

}

// class _ExpandableBaseState extends State<ExpandableBase> {
//   bool isExpanded = false;

 
// }
