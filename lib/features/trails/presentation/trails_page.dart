import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrailsPage extends StatelessWidget {
  const TrailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trilhas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const _MockNotice(),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Flutter Básico'),
              subtitle: const Text('5 níveis disponíveis'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/trail/flutter-basico/level/nivel-01'),
            ),
          ),
        ],
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
              child: Text('Mock: trilhas fixas no front, ainda nao vem do Firestore.'),
            ),
          ],
        ),
      ),
    );
  }
}
