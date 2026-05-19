import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar para trilhas',
          onPressed: () => context.go('/home/trails'),
        ),
        title: const Text('Nivel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _MockNotice(),
            const SizedBox(height: 16),
            Text('Trilha: $trailId'),
            const SizedBox(height: 8),
            Text('Nivel: $levelId'),
            const SizedBox(height: 16),
            const Text('Tela base pronta para renderizar atividades.'),
          ],
        ),
      ),
    );
  }
}

class _MockNotice extends StatelessWidget {
  const _MockNotice();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Icon(Icons.info_outline),
            SizedBox(width: 8),
            Expanded(
              child: Text('Mock: tela de nivel ainda nao carrega atividades do Firestore.'),
            ),
          ],
        ),
      ),
    );
  }
}
