import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({ Key? key, this.icon, this.onTap, this.title }) : super(key: key);

  final Widget? icon;
  final void Function()? onTap;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        title: title,
        textColor: Theme.of(context).colorScheme.onPrimaryContainer,
        iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
        leading: icon,
        onTap: onTap,
      ),
    );
  }
}