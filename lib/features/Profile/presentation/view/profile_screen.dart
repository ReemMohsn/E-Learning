import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/extensions/snack_bar_context_extension.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/features/Profile/presentation/view/widgets/profile_header.dart';
import 'package:e_learning/features/Profile/presentation/view/widgets/profile_menu_item.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_cubit.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_state.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _openEditProfile(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();
    final profile = cubit.profile;
    if (profile == null) return;
    final updated = await Navigator.of(
      context,
    ).pushNamed(Routes.editProfile, arguments: profile);
    if (updated == true && context.mounted) {
      cubit.getProfile();
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.logOut),
        content: const Text(AppStrings.confirmLogOut),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(AppStrings.logOut),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<AuthCubit>().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutLoading) {
          context.showLoadingDialog(false);
        } else if (state is SignOutSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          context.showSuccessSnackBar(state.message);
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(Routes.login, (_) => false);
        } else if (state is SignOutFailure) {
          Navigator.of(context, rootNavigator: true).pop();
          context.showErrorSnackBar(state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.profile)),
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileInitial || state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.message, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: cubit.getProfile,
                          child: const Text(AppStrings.tryAgain),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is! ProfileSuccess) {
                return const SizedBox.shrink();
              }
              final profile = state.profile;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileHeader(
                          name: profile.fullName,
                          email: profile.email,
                        ),
                        const SizedBox(height: 28),
                        Text(
                          AppStrings.accountSettings,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        ProfileMenuItem(
                          icon: Icons.person_outline,
                          title: AppStrings.editProfile,
                          onTap: () => _openEditProfile(context),
                        ),
                        ProfileMenuItem(
                          icon: Icons.lock_outline,
                          title: AppStrings.changePassword,
                          onTap: () => _openEditProfile(context),
                        ),
                        const SizedBox(height: 32),
                        OutlinedButton.icon(
                          onPressed: () => _confirmSignOut(context),
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text(AppStrings.logOut),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.error,
                            minimumSize: const Size.fromHeight(54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
