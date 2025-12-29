import 'package:flutter/material.dart';

enum AuthMode { login, register, forgot }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthMode mode = AuthMode.login;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void handleSubmit() {
    if (mode == AuthMode.forgot) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to ${emailController.text}'),
        ),
      );
      setState(() => mode = AuthMode.login);
    } else {
      // Demo login/register success
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Logo
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                const Text(
                  'SecureHome Alarm System',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Monitor and protect your home',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 32),

                // Card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          mode == AuthMode.login
                              ? 'Sign In'
                              : mode == AuthMode.register
                              ? 'Create Account'
                              : 'Reset Password',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mode == AuthMode.login
                              ? 'Enter your credentials to access your account'
                              : mode == AuthMode.register
                              ? 'Create a new account to get started'
                              : 'Enter your email to receive a reset link',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 20),

                        // Email
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        if (mode != AuthMode.forgot)
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                          ),

                        if (mode == AuthMode.register)
                          const SizedBox(height: 16),

                        // Confirm Password
                        if (mode == AuthMode.register)
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                          ),

                        const SizedBox(height: 20),

                        // Submit Button
                        ElevatedButton(
                          onPressed: handleSubmit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            mode == AuthMode.login
                                ? 'Sign In'
                                : mode == AuthMode.register
                                ? 'Create Account'
                                : 'Send Reset Link',
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Links
                        if (mode == AuthMode.login) ...[
                          TextButton(
                            onPressed: () =>
                                setState(() => mode = AuthMode.forgot),
                            child: const Text('Forgot Password?'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              TextButton(
                                onPressed: () =>
                                    setState(() => mode = AuthMode.register),
                                child: const Text('Sign Up'),
                              ),
                            ],
                          ),
                        ],

                        if (mode == AuthMode.register)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account? '),
                              TextButton(
                                onPressed: () =>
                                    setState(() => mode = AuthMode.login),
                                child: const Text('Sign In'),
                              ),
                            ],
                          ),

                        if (mode == AuthMode.forgot)
                          TextButton(
                            onPressed: () =>
                                setState(() => mode = AuthMode.login),
                            child: const Text('Back to Sign In'),
                          ),

                        const SizedBox(height: 16),

                        // Demo Notice
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            border: Border.all(color: Colors.yellow.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Demo Mode: Enter any email and password to access the system',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
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
}
