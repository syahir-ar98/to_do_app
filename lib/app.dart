import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/pages/landing/landing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/services/providers.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do App',
      home: AuthenticationWrapper(),
    );
  }
}

/// Authenticate user
class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userAsync = ref.watch(authStateProvider);
    return _userAsync.when(
      data: (data) => data != null ? const HomePage() : const LandingPage(),
      error: (e, st) => const Center(child: Text('Error Occured!')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
