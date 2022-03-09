import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.label,
    required this.icon,
    this.state = ActionButtonState.standard,
    required this.onTap,
    this.isFilled = false,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final ActionButtonState state;
  final void Function() onTap;

  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var onPrimary = theme.colorScheme.onPrimary;
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 0),
      child: AnimatedContainer(
        duration: kdAnimation,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: state == ActionButtonState.error
              ? theme.colorScheme.errorContainer
              : (state == ActionButtonState.completed)
                  ? theme.colorScheme.tertiary
                  : (isFilled || state != ActionButtonState.standard
                      ? theme.primaryColor
                      : theme.colorScheme.surface),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          border: (!isFilled && state == ActionButtonState.standard)
              ? Border.all(
                  color: theme.primaryColor,
                  width: 4,
                )
              : null,
        ),
        height: 60,
        alignment: Alignment.center,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            child: SizedBox.expand(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: (state == ActionButtonState.standard)
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              color: isFilled
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            Text(
                              label,
                              style: theme.textTheme.titleLarge!.copyWith(
                                  color: isFilled
                                      ? theme.colorScheme.onPrimary
                                      : theme.colorScheme.onSurface),
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
                                      color:
                                          theme.colorScheme.onErrorContainer),
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
      ),
    );
  }
}

enum ActionButtonState { standard, loading, error, completed }
