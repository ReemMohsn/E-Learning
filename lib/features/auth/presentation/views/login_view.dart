import 'package:e_learning/core/extensions/snack_bar_context_extension.dart';
import 'package:e_learning/core/themes/app_color.dart';
import 'package:e_learning/core/common/utils/app_validator.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_state.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/auth_page_header.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/auth_social_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _obscurePassword = ValueNotifier<bool>(true);

  void _submit() {
    final cubit = context.read<AuthCubit>();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    cubit.signIn(email: _email.text, password: _password.text);
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      if (state is LoginLoading) {
        context.showLoadingDialog();
      } else if (state is LoginSuccess) {
        Navigator.of(context, rootNavigator: true).pop();
        context.showSuccessSnackBar(state.message);
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
      } else if (state is LoginFailure) {
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
              AuthPageHeader(isSignUp: false),
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
                                    validator: AppValidator.requiredField,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [
                                      AutofillHints.password,
                                    ],
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    onFieldSubmitted: (_) => _submit(),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
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
                            const SizedBox(height: 8),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll(
                                    AppColor.hint,
                                  ),
                                  padding: WidgetStatePropertyAll(
                                    EdgeInsets.zero,
                                  ),
                                  textStyle: WidgetStatePropertyAll(
                                    TextStyle(fontSize: 14),
                                  ),
                                ),
                                child: Text('Forgot password?'),
                              ),
                            ),
                            const SizedBox(height: 22),
                            ElevatedButton(
                              onPressed: _submit,
                              child: const Text('Login'),
                            ),
                            const SizedBox(height: 20),
                            const AuthSocialOptions(),
                            const SizedBox(height: 76),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF647899),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(
                                    context,
                                  ).pushReplacementNamed(Routes.signUp),
                                  child: const Text('Sign up'),
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
