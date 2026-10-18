import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/menu_card.dart';
import '../letters/letters_screen.dart';
import '../numbers/numbers_screen.dart';
import '../progress/progress_controller.dart';
import '../progress/progress_screen.dart';
import '../quiz/quiz_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressController progress = context.watch<ProgressController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'أهلاً بك 👋',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'هيا نتعلّم شيئاً جديداً اليوم!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const SettingsScreen(),
                      ),
                    ),
                    iconSize: 28,
                    icon: const Icon(Icons.settings_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _StarsBanner(
                stars: progress.stars,
                letters: progress.learnedLetters.length,
                totalLetters: progress.totalLetters,
              ),
              const SizedBox(height: 26),
              Text(
                'ماذا نتعلّم اليوم؟',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.92,
                children: <Widget>[
                  MenuCard(
                    emoji: '🔤',
                    title: 'الحروف',
                    subtitle: '٢٨ حرفاً عربياً',
                    colors: const <Color>[
                      Color(0xFF7C5CFF),
                      Color(0xFF5B3FD9),
                    ],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const LettersScreen(),
                      ),
                    ),
                  ),
                  MenuCard(
                    emoji: '🔢',
                    title: 'الأرقام',
                    subtitle: 'من ٠ إلى ١٠',
                    colors: const <Color>[
                      Color(0xFF17C3B2),
                      Color(0xFF0E8C7F),
                    ],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const NumbersScreen(),
                      ),
                    ),
                  ),
                  MenuCard(
                    emoji: '🎯',
                    title: 'الاختبار',
                    subtitle: 'العب واجمع النجوم',
                    colors: const <Color>[
                      Color(0xFFFF8C42),
                      Color(0xFFE86A1C),
                    ],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const QuizScreen(),
                      ),
                    ),
                  ),
                  MenuCard(
                    emoji: '🏆',
                    title: 'تقدّمي',
                    subtitle: 'شاهد ما تعلّمته',
                    colors: const <Color>[
                      Color(0xFFFF4D8D),
                      Color(0xFFD62E6B),
                    ],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ProgressScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppCard(
                child: Row(
                  children: <Widget>[
                    const Text('💡', style: TextStyle(fontSize: 30)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'نصيحة: خصّص خمس دقائق يومياً للتعلّم، سترى الفرق سريعاً!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarsBanner extends StatelessWidget {
  const _StarsBanner({
    required this.stars,
    required this.letters,
    required this.totalLetters,
  });

  final int stars;
  final int letters;
  final int totalLetters;

  @override
  Widget build(BuildContext context) {
    final double ratio = totalLetters == 0 ? 0 : letters / totalLetters;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFFB020), Color(0xFFFF8C42)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('⭐', style: TextStyle(fontSize: 30)),
              const SizedBox(width: 10),
              Text(
                '$stars نجمة',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'تعلّمت $letters من $totalLetters حرفاً',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.95),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 9,
              backgroundColor: Colors.white.withOpacity(0.35),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
