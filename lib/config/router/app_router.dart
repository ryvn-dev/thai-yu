import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/lessons/presentation/screens/lesson_detail_screen.dart';
import '../../features/lessons/presentation/screens/lesson_list_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/quiz/presentation/screens/quiz_screen.dart';
import '../../features/vocabulary/presentation/screens/vocabulary_screen.dart';
import '../../shared/widgets/app_scaffold.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      // Auth routes (no bottom nav)
      GoRoute(
        path: '/auth/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Main app with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/lessons',
            name: 'lessons',
            builder: (context, state) => const LessonListScreen(),
            routes: [
              GoRoute(
                path: ':lessonId',
                name: 'lessonDetail',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => LessonDetailScreen(
                  lessonId: state.pathParameters['lessonId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/vocabulary',
            name: 'vocabulary',
            builder: (context, state) => const VocabularyScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Full-screen routes (above shell)
      GoRoute(
        path: '/quiz/:lessonId',
        name: 'quiz',
        builder: (context, state) => QuizScreen(
          lessonId: state.pathParameters['lessonId']!,
        ),
      ),
    ],
  );
}
