import 'package:e_learning/core/themes/app_theme.dart';
import 'package:e_learning/features/main_home/data/models/navigation_item_model.dart';
import 'package:flutter/material.dart';

class MainHomeBottomNavigationBar extends StatelessWidget {
  const MainHomeBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final int currentIndex;
  final List<NavigationItemModel> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.bottomNavigationBarTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      elevation: theme.appBarTheme.elevation ?? 0,
      shadowColor: theme.appBarTheme.shadowColor,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            FocusScope.of(context).unfocus();
            onTap(index);
          },
          items: items
              .map(
                (item) => BottomNavigationBarItem(
                  label: item.label,
                  icon: Icon(item.icon),
                  activeIcon: Icon(item.selectedIcon),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}
