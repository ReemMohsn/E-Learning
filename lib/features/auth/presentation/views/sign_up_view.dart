import 'package:e_learning/core/themes/app_color.dart';
import 'package:e_learning/core/common/utils/app_validator.dart';
import 'package:e_learning/core/extensions/snack_bar_context_extension.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_state.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/auth_page_header.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/auth_social_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _obscurePassword = ValueNotifier<bool>(true);
  void _submit() {
    final cubit = context.read<AuthCubit>();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    cubit.signUp(
      fullName: _name.text,
      email: _email.text,
      password: _password.text,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      if (state is SignUpLoading) {
        context.showLoadingDialog();
      } else if (state is SignUpSuccess) {
        Navigator.of(context, rootNavigator: true).pop();
        context.showSuccessSnackBar(state.message);
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else if (state is SignUpFailure) {
        Navigator.of(context, rootNavigator: true).pop();
        context.showErrorSnackBar(state.errorMessage);
      }
    },
    child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              AuthPageHeader(isSignUp: true),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 454),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 40, 32, 64),
                    child: AutofillGroup(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Full Name',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _name,
                              textCapitalization: TextCapitalization.words,
                              autofillHints: const [AutofillHints.name],
                              validator: AppValidator.fullName,
                              decoration: const InputDecoration(
                                hintText: 'Enter your full name',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'Email',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              validator: AppValidator.email,
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.mail_outline, size: 20),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'Password',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ValueListenableBuilder<bool>(
                              valueListenable: _obscurePassword,
                              builder: (context, obscurePassword, child) =>
                                  TextFormField(
                                    controller: _password,
                                    obscureText: obscurePassword,
                                    validator: AppValidator.password,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [
                                      AutofillHints.newPassword,
                                    ],
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    onFieldSubmitted: (_) => _submit(),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        size: 20,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            _obscurePassword.value =
                                                !obscurePassword,
                                        tooltip: obscurePassword
                                            ? 'Show password'
                                            : 'Hide password',
                                        icon: Icon(
                                          obscurePassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: _submit,
                              child: const Text('Sign Up'),
                            ),
                            const SizedBox(height: 28),
                            const AuthSocialOptions(isSignUp: true),
                            const SizedBox(height: 48),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF647899),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(
                                    context,
                                  ).pushReplacementNamed(Routes.login),
                                  child: const Text('Log In'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
