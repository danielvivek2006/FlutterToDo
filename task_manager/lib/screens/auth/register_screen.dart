import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../../theme/app_colors.dart';
import '../main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final user = ParseUser.createUser(
      _emailController.text.trim(),
      _passwordController.text,
      _emailController.text.trim(),
    );

    try {
      var response = await user.signUp();

      setState(() => _isLoading = false);

      if (response.success) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        if (!mounted) return;
        if (response.error?.code == 202) {
          _showError('Account already exists for this username.');
        } else {
          _showError(response.error?.message ?? 'Registration failed');
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    final isIOS = !kIsWeb && Platform.isIOS;
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isIOS = !kIsWeb && Platform.isIOS;
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: colors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    isIOS ? CupertinoIcons.person_add_solid : Icons.person_add,
                    size: 70,
                    color: colors.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: colors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      filled: true,
                      fillColor: colors.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide(color: colors.inputBorder, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide(color: colors.primary, width: 2),
                      ),
                      prefixIcon: Icon(
                        isIOS ? CupertinoIcons.mail : Icons.email_outlined,
                        color: colors.textSecondary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      filled: true,
                      fillColor: colors.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide(color: colors.inputBorder, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide(color: colors.primary, width: 2),
                      ),
                      prefixIcon: Icon(
                        isIOS ? CupertinoIcons.lock : Icons.lock_outlined,
                        color: colors.textSecondary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? (isIOS ? CupertinoIcons.eye : Icons.visibility_outlined)
                              : (isIOS ? CupertinoIcons.eye_slash : Icons.visibility_off_outlined),
                          color: colors.textSecondary,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be 6+ characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      filled: true,
                      fillColor: colors.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide(color: colors.inputBorder, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        borderSide: BorderSide(color: colors.primary, width: 2),
                      ),
                      prefixIcon: Icon(
                        isIOS ? CupertinoIcons.lock_shield : Icons.lock_outline,
                        color: colors.textSecondary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? (isIOS ? CupertinoIcons.eye : Icons.visibility_outlined)
                              : (isIOS ? CupertinoIcons.eye_slash : Icons.visibility_off_outlined),
                          color: colors.textSecondary,
                        ),
                        onPressed: () {
                          setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(isIOS ? 10 : 12),
                        ),
                        elevation: isIOS ? 0 : 2,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
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