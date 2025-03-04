import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/icons.dart';
import 'package:sisyphus/widgets/typography.dart';

class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: PopupMenuButton(
        offset: const Offset(0, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).appColors.border),
        ),
        elevation: 1,
        color: Theme.of(context).appColors.foreground,
        itemBuilder:
            (context) => [
              PopupMenuItem(
                child: SearchBar(
                  hintText: 'Search',
                  hintStyle: WidgetStatePropertyAll(
                    TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).appColors.grey1,
                    ),
                  ),
                  trailing: [AppIcons.svg(AppIcons.search)],
                  elevation: const WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).appColors.background,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(context).appColors.border,
                      ),
                    ),
                  ),
                ),
              ),
              ...['Exchange', 'Wallets', 'Roqqu Hub', 'Logout'].map(
                (e) => PopupMenuItem(
                  child: AppText(e, size: 16, weight: FontWeight.w500),
                ),
              ),
            ],
        child: AppIcons.svg(AppIcons.menu),
      ),
    );
  }
}
