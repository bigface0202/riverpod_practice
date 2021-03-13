import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../provider/game.dart';
import '../pages/game.dart';

class StartApp extends HookWidget {
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(gameProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('ワンナイト人狼'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: createPlayerWidgets(),
              ),
              MaterialButton(
                onPressed: () => {
                  start(
                    context,
                    provider,
                  ),
                },
                child: Text('スタート'),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void start(BuildContext context, Game provider) {
    // provider.controllersに登録した名前を渡す
    provider.controllers = controllers;
    // 役職のシャッフル
    provider.shufflePositions();
    // ゲーム開始へ移動
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameApp(),
      ),
    );
  }

  List<Widget> createPlayerWidgets() {
    List<Widget> players = [];
    for (int i = 0; i < 4; i++) {
      players.add(Padding(
        padding: EdgeInsets.all(20),
        child: TextFormField(
          controller: controllers[i],
          decoration: const InputDecoration(
            hintText: '参加者のの名前',
          ),
        ),
      ));
    }
    return players;
  }
}
