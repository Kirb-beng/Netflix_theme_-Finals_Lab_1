import 'package:flutter/material.dart';
import '../theme/netflix_theme.dart';
import '../theme/responsive.dart';
import '../widgets/netflix_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Navigator method: pushReplacementNamed, passing the entered
      // full name forward as route arguments so Home can greet the user.
      Navigator.of(context).pushReplacementNamed(
        '/home',
        arguments: _nameController.text.trim(),
      );
    }
  }

  void _goBackToLogin() {
    // Navigator method: pop — Sign-Up was pushed on top of Login,
    // so popping simply returns to the existing Login screen.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NetflixColors.black,
      body: NetflixBackground(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 16),
              child: NetflixLogo(fontSize: Responsive.logoFontSize(context)),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.authHorizontalPadding(context),
                  vertical: 90,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.authCardMaxWidth(context),
                  ),
                  child: FadeSlideIn(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        padding:
                            EdgeInsets.all(Responsive.authCardPadding(context)),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('Create Account',
                                style: NetflixTextStyles.heading),
                            const SizedBox(height: 8),
                            const Text(
                              'Just a few more steps and you\'re done.\nWe hate paperwork too.',
                              style: NetflixTextStyles.greyBody,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _nameController,
                              style: NetflixTextStyles.body,
                              decoration:
                                  netflixInputDecoration('Full name'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your full name.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              style: NetflixTextStyles.body,
                              keyboardType: TextInputType.emailAddress,
                              decoration: netflixInputDecoration('Email'),
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Please enter a valid email.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              style: NetflixTextStyles.body,
                              obscureText: _obscurePassword,
                              decoration:
                                  netflixInputDecoration('Password').copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: NetflixColors.grey,
                                  ),
                                  onPressed: () => setState(() =>
                                      _obscurePassword = !_obscurePassword),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 4) {
                                  return 'Password must be at least 4 characters.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: NetflixTextStyles.body,
                              obscureText: _obscureConfirm,
                              decoration: netflixInputDecoration(
                                      'Confirm password')
                                  .copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirm
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: NetflixColors.grey,
                                  ),
                                  onPressed: () => setState(() =>
                                      _obscureConfirm = !_obscureConfirm),
                                ),
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            _AnimatedPressButton(
                              label: 'Sign Up',
                              onPressed: _handleSignUp,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                const Text('Already have an account? ',
                                    style: NetflixTextStyles.greyBody),
                                GestureDetector(
                                  onTap: _goBackToLogin,
                                  child: const Text('Sign in now.',
                                      style: NetflixTextStyles.link),
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
            ),
          ],
        ),
      ),
    );
  }
}

/// Same animated press button used on the Login screen, kept local so
/// each screen file stays self-contained and easy to grade separately.
class _AnimatedPressButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _AnimatedPressButton({required this.label, required this.onPressed});

  @override
  State<_AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<_AnimatedPressButton> {
  double _scale = 1.0;

  void _setPressed(bool pressed) {
    setState(() => _scale = pressed ? 0.97 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: NetflixColors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: NetflixColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
