// import 'package:flutter_vibrate/flutter_vibrate.dart';

abstract class IVibrate {
  void vibe();
}

class Vibrator implements IVibrate {
  @override
  void vibe() async {
    // bool canVibrate = await Vibrate.canVibrate;
    // if (canVibrate) {
    //   Vibrate.feedback(FeedbackType.impact);
    // }
  }
}

class DummyVibrator implements IVibrate {
  @override
  void vibe() async {}
}
