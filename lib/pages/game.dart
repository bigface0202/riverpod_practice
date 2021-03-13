import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:riverpod_study/provider/game.dart';

class GameApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(gameProvider);
    // userProviderでgameProviderのstateをウォッチする
    // それぞれの値を個別の変数に入れていくやり方でもよい
    // state = gameProvider.state
    useProvider(gameProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: Text('役職'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                getMasterText(provider),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: createButton(provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton(Game provider) {
    Widget button;
    int count = provider.state;
    print(count);

    // 全員の役職説明が終わったらボタンを消してスタート
    if (count / 2 >= provider.controllers.length) {
      button = Container();
      return button;
    } else {
      button = MaterialButton(
        onPressed: () => {provider.increment()},
        child: Text('イエス'),
        color: Colors.blueAccent,
        textColor: Colors.white,
      );
      return button;
    }
  }

  String getMasterText(Game provider) {
    String text = '';
    int count = provider.state;

    if (count / 2 >= provider.controllers.length) {
      text = 'ゲームスタート';
      return text;
    }
    // 最初に登録名を確認する
    else if (count % 2 == 0) {
      int num = (count / 2).floor();
      text = "あなたは" + provider.controllers[num].text + "ですか?";
      return text;
    }
    // 役職を与える
    else {
      int num = (count / 2).floor();
      text = "あなたの役職は" + provider.positions[num] + "です";
      return text;
    }
  }
}
