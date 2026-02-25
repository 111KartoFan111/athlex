import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo Placeholder
              const SizedBox(height: 48),
              Icon(
                Icons.fitness_center,
                size: 80,
                color: AppColors.neonGreen,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.appTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 48),

              // Inputs
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: l10n.loginEmailHint,
                  prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: l10n.loginPasswordHint,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(l10n.loginForgotPassword),
                ),
              ),
              const SizedBox(height: 48),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to onboarding as part of the flow for demonstration
                  context.go('/onboarding');
                },
                child: Text(l10n.loginButton),
              ),
              const SizedBox(height: 24),

              // Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: AppColors.neonGreen),
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
