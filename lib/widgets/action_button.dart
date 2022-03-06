import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.label,
    required this.icon,
    this.state = ActionButtonState.standard,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final ActionButtonState state;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var onPrimary = theme.colorScheme.onPrimary;
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: AnimatedContainer(
        duration: kdAnimation,
        decoration: BoxDecoration(
          color: state == ActionButtonState.error
              ? theme.colorScheme.errorContainer
              : (state == ActionButtonState.completed)
                  ? theme.colorScheme.tertiary
                  : theme.primaryColor,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        height: 60,
        alignment: Alignment.center,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(kBorderRadius),
            child: SizedBox.expand(
              child: Align(
                alignment: Alignment.center,
                child: (state == ActionButtonState.standard)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            color: theme.colorScheme.onPrimary,
                          ),
                          const SizedBox(width: kDefaultPadding),
                          Text(
                            label,
                            style: theme.textTheme.titleLarge!
                                .copyWith(color: theme.colorScheme.onPrimary),
                          ),
                        ],
                      )
                    : (state == ActionButtonState.error
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error,
                                color: theme.colorScheme.onErrorContainer,
                              ),
                              const SizedBox(width: kDefaultPadding),
                              Text(
                                'Fehler',
                                style: theme.textTheme.titleLarge!.copyWith(
                                    color: theme.colorScheme.onErrorContainer),
                              ),
                            ],
                          )
                        : (state == ActionButtonState.completed
                            ? Icon(
                                Icons.check,
                                color: theme.colorScheme.onTertiary,
                              )
                            : CircularProgressIndicator(
                                color: onPrimary,
                              ))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ActionButtonState { standard, loading, error, completed }
