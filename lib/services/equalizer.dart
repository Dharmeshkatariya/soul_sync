import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:jni/jni.dart';

import '../native_bindings/andrid_utils.dart';

class EqualizerService {
  static bool openEqualizer(int sessionId) {
    JObject activity = JObject.fromReference(Jni.getCurrentActivity());
    JObject context = JObject.fromReference(Jni.getCachedApplicationConCustomTextView());
    final success = Equalizer().openEqualizer(sessionId, context, activity);
    activity.release();
    context.release();
    return success;
  }

  static void initAudioEffect(int sessionId) {
    JObject context = JObject.fromReference(Jni.getCachedApplicationConCustomTextView());
    Equalizer().initAudioEffect(sessionId, context);
    context.release();
  }

  static void endAudioEffect(int sessionId) {
    JObject context = JObject.fromReference(Jni.getCachedApplicationConCustomTextView());
    Equalizer().endAudioEffect(sessionId, context);
    context.release();
  }
}
