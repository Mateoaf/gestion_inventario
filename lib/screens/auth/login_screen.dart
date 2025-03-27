import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return SignInScreen(
      providers: providers,
      actions: [
        AuthStateChangeAction<UserCreated>((context, state) {
          Navigator.pushReplacementNamed(context, '/profile');
        }),
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, '/profile');
        }),
        AuthStateChangeAction<AuthFailed>((context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.exception.toString()}')),
          );
        }),
      ],
    );
  }
}

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ProfileScreen(
              providers: providers,
              actions: [
                SignedOutAction((context) {
                  Navigator.pushReplacementNamed(context, '/sign-in');
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Ir al menú principal'),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}
