import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class AudioDevice {
  final int id;
  final String name;
  final String type;
  final bool isSink;
  final bool isSource;

  AudioDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.isSink,
    required this.isSource,
  });

  factory AudioDevice.fromMap(Map<Object?, Object?> map) {
    return AudioDevice(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      isSink: map['isSink'] as bool,
      isSource: map['isSource'] as bool,
    );
  }
}

class AudioEngine {
  static const MethodChannel _methodChannel = MethodChannel(
    'com.example.audiotest/audio',
  );
  static const EventChannel _amplitudeEventChannel = EventChannel(
    'com.example.audiotest/amplitude',
  );

  static Stream<Map<dynamic, dynamic>>? _amplitudeStream;

  static Future<List<AudioDevice>> getAudioDevices(bool isOutput) async {
    try {
      final List<dynamic> devices = await _methodChannel.invokeMethod(
        'getAudioDevices',
        {'isOutput': isOutput},
      );
      return devices
          .map((m) => AudioDevice.fromMap(m as Map<Object?, Object?>))
          .toList();
    } catch (e) {
      debugPrint("Failed to get audio devices: $e");
      return [];
    }
  }

  static Future<Map<String, Map<String, int>>>
  getAudioAttributesOptions() async {
    try {
      final Map<Object?, Object?> result = await _methodChannel.invokeMethod(
        'getAudioAttributesOptions',
      );

      Map<String, Map<String, int>> typedResult = {};
      result.forEach((key, value) {
        if (key is String && value is Map) {
          Map<String, int> innerMap = {};
          value.forEach((k, v) {
            if (k is String && v is int) {
              innerMap[k] = v;
            }
          });
          typedResult[key] = innerMap;
        }
      });
      return typedResult;
    } on PlatformException catch (e) {
      debugPrint("Failed to get audio attributes options: '${e.message}'.");
      return {"usages": {}, "contentTypes": {}, "flags": {}};
    }
  }

  static Future<Map<String, int>> getAudioSourceOptions() async {
    try {
      final Map<Object?, Object?> result = await _methodChannel.invokeMethod(
        'getAudioSourceOptions',
      );

      Map<String, int> typedResult = {};
      result.forEach((key, value) {
        if (key is String && value is int) {
          typedResult[key] = value;
        }
      });
      return typedResult;
    } on PlatformException catch (e) {
      debugPrint("Failed to get audio source options: '${e.message}'.");
      return {};
    }
  }

  static Future<void> startPlayback({
    required int instanceId,
    required int sampleRate,
    required int channelConfig,
    required int audioFormat,
    required int usage,
    required int contentType,
    required int flags,
    int? preferredDeviceId,
    String? filePath,
  }) async {
    try {
      await _methodChannel.invokeMethod('startPlayback', {
        'instanceId': instanceId,
        'sampleRate': sampleRate,
        'channelConfig': channelConfig,
        'audioFormat': audioFormat,
        'usage': usage,
        'contentType': contentType,
        'flags': flags,
        'preferredDeviceId': preferredDeviceId,
        'filePath': filePath,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to start playback: '${e.message}'.");
    }
  }

  static Future<void> stopPlayback(int instanceId) async {
    try {
      await _methodChannel.invokeMethod('stopPlayback', {
        'instanceId': instanceId,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to stop playback: '${e.message}'.");
    }
  }

  static Future<void> pausePlayback(int instanceId) async {
    try {
      await _methodChannel.invokeMethod('pausePlayback', {
        'instanceId': instanceId,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to pause playback: '${e.message}'.");
    }
  }

  static Future<void> resumePlayback(int instanceId) async {
    try {
      await _methodChannel.invokeMethod('resumePlayback', {
        'instanceId': instanceId,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to resume playback: '${e.message}'.");
    }
  }

  static Future<void> startRecording({
    required int instanceId,
    required int sampleRate,
    required int channelConfig,
    required int audioFormat,
    required int audioSource,
    int? preferredDeviceId,
  }) async {
    try {
      await _methodChannel.invokeMethod('startRecording', {
        'instanceId': instanceId,
        'sampleRate': sampleRate,
        'channelConfig': channelConfig,
        'audioFormat': audioFormat,
        'audioSource': audioSource,
        'preferredDeviceId': preferredDeviceId,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to start recording: '${e.message}'.");
    }
  }

  static Future<void> stopRecording(int instanceId) async {
    try {
      await _methodChannel.invokeMethod('stopRecording', {
        'instanceId': instanceId,
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to stop recording: '${e.message}'.");
    }
  }

  static Stream<Map<dynamic, dynamic>> get amplitudeStream {
    _amplitudeStream ??= _amplitudeEventChannel.receiveBroadcastStream().map(
      (event) => event as Map<dynamic, dynamic>,
    );
    return _amplitudeStream!;
  }
}
