import 'package:deck_cards_matching/common/services/settings_service.dart';
import 'package:flutter/widgets.dart';

class SettingsViewModel extends ChangeNotifier {
  bool _isFullScreen;
  double _cardShowFaceUpDurationInMilliseconds;
  final SettingsService settingsService;

  SettingsViewModel({this.settingsService}) {
    this.isFullScreen = SettingsService.IS_FULL_SCREEN_DEFAULT;
    this.cardShowFaceUpDurationInMilliseconds =
        SettingsService.CARD_SHOW_FACE_UP_DURATION_IN_MILLISECONDS_DEFAULT;
    _initModel();
  }

  void _initModel() {
    Future.wait(
      [
        settingsService.isFullScreenEnabled(),
        settingsService.getCardShowFaceUpDurationInMilliseconds(),
      ],
    ).then((results) {
      var isFullScreen = results[0] as bool;
      var cardShowFaceUpDurationInMilliseconds = results[1] as double;

      this.isFullScreen = isFullScreen;
      this.cardShowFaceUpDurationInMilliseconds =
          cardShowFaceUpDurationInMilliseconds;
    });
  }

  bool get isFullScreen => _isFullScreen;
  set isFullScreen(bool value) {
    _isFullScreen = value;

    settingsService.setFullScreen(value).then((value) => notifyListeners());
  }

  double get cardShowFaceUpDurationInMilliseconds =>
      _cardShowFaceUpDurationInMilliseconds;
  set cardShowFaceUpDurationInMilliseconds(double value) {
    _cardShowFaceUpDurationInMilliseconds = value;

    settingsService
        .setCardShowFaceUpDurationInMilliseconds(value)
        .then((value) => notifyListeners());
  }
}
