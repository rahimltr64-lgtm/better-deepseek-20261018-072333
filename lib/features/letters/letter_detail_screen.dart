import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/data/arabic_letters.dart';
import '../../core/services/tts_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_card.dart';
import '../progress/progress_controller.dart';

class LetterDetailScreen extends StatefulWidget {
  const LetterDetailScreen({super.key, this.startIndex = 0});

  final int startIndex;

  @override
  State<LetterDetailScreen> createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {
  late final PageController _pageController =
      PageController(initialPage: widget.startIndex);

  late int _index = widget.startIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _speak(ArabicLetter letter) {
    TtsService.instance.speak('${letter.name}، ${letter.word}');
  }

  @override
  Widget build(BuildContext context) {
    final ProgressController progress = context.watch<ProgressController>();
    final ArabicLetter current = arabicLetters[_index];
    final bool learned = progress.isLetterLearned(current.letter);
    final Color color = AppColors.letters[_index % AppColors.letters.length];

    return Scaffold(
      appBar: AppBar(title: Text('حرف ${current.letter}')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: arabicLetters.length,
              onPageChanged: (int value) => setState(() => _index = value),
              itemBuilder: (BuildContext context, int index) {
                final ArabicLetter item = arabicLetters[index];
                final Color itemColor =
                    AppColors.letters[index % AppColors.letters.length];
                return _LetterPage(
                  letter: item,
                  color: itemColor,
                  onSpeak: () => _speak(item),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 
