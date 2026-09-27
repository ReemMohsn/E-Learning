import 'package:e_learning/core/common/utils/app_validator.dart';
import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/extensions/snack_bar_context_extension.dart';
import 'package:e_learning/features/Profile/data/models/profile_model.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_cubit.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profile});

  final ProfileModel profile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _obscurePassword = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.fullName);
    _emailController = TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    context.read<ProfileCubit>().updateProfile(
      fullName: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text.trim().isEmpty
          ? null
          : _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.editProfile)),
      body: SafeArea(
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdating) {
              context.showLoadingDialog(false);
            } else if (state is ProfileUpdateSuccess) {
              Navigator.of(context, rootNavigator: true).pop();
              context.showSuccessSnackBar(AppStrings.profileUpdated);
              Navigator.pop(context, true);
            } else if (state is ProfileFailure) {
              Navigator.of(context, rootNavigator: true).pop();
              context.showErrorSnackBar(state.message);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.fullName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        validator: AppValidator.fullName,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: AppStrings.enterFullName,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.email,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        validator: AppValidator.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: AppStrings.enterEmail,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.newPassword,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscurePassword,
                        builder: (context, obscure, child) => TextFormField(
                          controller: _passwordController,
                          obscureText: obscure,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _save(),
                          validator: (value) {
                            if (value == null || value.isEmpty) return null;
                            return AppValidator.password(value);
                          },
                          decoration: InputDecoration(
                            hintText: AppStrings.leavePasswordEmpty,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  _obscurePassword.value = !obscure,
                              icon: Icon(
                                obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      FilledButton(
                        onPressed: _save,
                        child: const Text(AppStrings.saveChanges),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
