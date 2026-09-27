import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/themes/app_color.dart';
import 'package:e_learning/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.fullName,
    required this.searchController,
    required this.onSearchChanged,
  });

  final String fullName;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const searchBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide.none,
    );

    return Material(
      color: theme.colorScheme.primary,
      elevation: theme.appBarTheme.elevation ?? 0,
      shadowColor: theme.appBarTheme.shadowColor,
      shape: AppTheme.homeHeaderShape,
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppTheme.homeMaxWidth),
            child: Padding(
              padding: AppTheme.homeHeaderPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.homeGreeting(fullName),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.welcomeToAcademy,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: searchController,
                    onChanged: onSearchChanged,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchCourses,
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColor.hint,
                      ),
                      prefixIconColor: AppColor.hint,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: searchBorder,
                      enabledBorder: searchBorder,
                      focusedBorder: searchBorder.copyWith(
                        borderSide: const BorderSide(
                          color: AppColor.navigationInactive,
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: searchController,
                        builder: (context, value, child) {
                          if (value.text.isEmpty)
                            return const SizedBox.shrink();
                          return IconButton(
                            tooltip: AppStrings.clearSearch,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              onSearchChanged('');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
