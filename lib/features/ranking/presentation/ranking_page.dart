import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ranking')),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: CircleAvatar(child: Text('1')),
            title: Text('Dev User'),
            subtitle: Text('120 XP'),
            trailing: Icon(Icons.arrow_upward, color: Colors.green),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('2')),
            title: Text('Alice'),
            subtitle: Text('100 XP'),
            trailing: Icon(Icons.remove, color: Colors.grey),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('3')),
            title: Text('Bob'),
            subtitle: Text('90 XP'),
            trailing: Icon(Icons.arrow_downward, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
