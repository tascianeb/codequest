import 'package:flutter/material.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({
    required this.trailId,
    required this.levelId,
    super.key,
  });

  final String trailId;
  final String levelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nível')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Trilha: $trailId'),
            const SizedBox(height: 8),
            Text('Nível: $levelId'),
            const SizedBox(height: 16),
            const Text('Tela base pronta para renderizar atividades.'),
          ],
        ),
      ),
    );
  }
}
