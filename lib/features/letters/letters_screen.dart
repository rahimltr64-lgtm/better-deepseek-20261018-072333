import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/data/arabic_letters.dart';
import '../../core/theme/app_colors.dart';
import '../progress/progress_controller.dart';
import 'letter_detail_screen.dart';

class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressController progress = context.watch<ProgressController>();

    return Scaffold(
      appBar: AppBar(title: const Text('الحروف العربية')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '${progress.learnedLetters.length} من ${arabicLetters.length}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Spacer(),
                    const Text('اضغط على أي حرف 👆',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress.lettersProgress,
                    minHeight: 10,
                    backgroundColor: AppColors.primary.withOpacity(0.12),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              itemCount: arabicLetters.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (BuildContext context, int index) {
                final ArabicLetter letter = arabicLetters[index];
                final Color color =
                    AppColors.letters[index % AppColors.letters.length];
                final bool learned =
                    progress.isLetterLearned(letter.letter);

                return _LetterTile(
                  letter: letter.letter,
                  color: color,
                  learned: learned,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          LetterDetailScreen(startIndex: index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LetterTile extends StatelessWidget {
  const _LetterTile({
    required this.letter,
    required this.color,
    required this.learned,
    required this.onTap,
  });

  final String letter;
  final Color color;
  final bool learned;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: learned ? color : color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: learned ? color : color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: learned ? Colors.white : color,
                ),
              ),
            ),
            if (learned)
              const Positioned(
                top: 6,
                left: 8,
                child: Text(
                  '✓',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
