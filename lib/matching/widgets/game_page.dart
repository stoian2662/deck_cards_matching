import 'package:deck_cards_matching/matching/models/game_view_model.dart';
import 'package:deck_cards_matching/matching/services/items_service.dart';
import 'package:deck_cards_matching/matching/widgets/game_playground.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final ItemsService imageService;

  const GamePage({this.imageService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<GameViewModel>(
        create: (BuildContext context) => GameViewModel(
          imageService: imageService,
        ),
        builder: (context, widget) => widget,
        child: Consumer<GameViewModel>(
          builder: (context, model, _) => Column(
            children: [
              Visibility(
                visible: model.state == GameState.Finished,
                child: Text(
                  'Congratulations!! You completed the game!',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              GamePlayground(
                gameModel: model,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      clipBehavior: Clip.none,
                      autofocus: true,
                      child: Text('Exit'.toUpperCase()),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: model.state == GameState.Finished
                        ? () => model.refresh()
                        : null,
                    clipBehavior: Clip.none,
                    autofocus: true,
                    child: Text('New Game'.toUpperCase()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
