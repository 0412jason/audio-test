# AudioTest

AudioTest is a comprehensive Flutter application designed for advanced audio testing and debugging on Android devices. It provides fine-grained control over Android's native audio APIs (`AudioTrack`, `AudioRecord`, `AudioManager`), allowing developers to test various audio configurations, routing, and concurrent audio scenarios.

## Features

*   **Playback Testing**:
    *   Test audio playback with customizable sample rates, channel configurations, and audio formats.
    *   Control `AudioAttributes` such as Usage, Content Type, and Flags.
    *   Select specific output devices or allow default routing.
    *   Real-time amplitude and waveform visualization.
*   **Record Testing**:
    *   Test audio recording with configurable sample rates, channels, and formats.
    *   Select specific `MediaRecorder.AudioSource` inputs.
    *   Save recordings locally and visualize input amplitude.
*   **VoIP Testing**:
    *   Simulate full-duplex VoIP communication scenarios.
    *   Configure communication devices and audio mode (`MODE_IN_COMMUNICATION`).
    *   Real-time tracking of active audio devices.
*   **Multi-Test Environment**:
    *   Run multiple audio instances concurrently using a split-view grid.
    *   Mix and match playback, recording, and VoIP tasks in a single view to test concurrent audio behaviors and focus management.

## Project Architecture

The project seamlessly integrates a highly responsive Flutter UI with a robust native Android backend.

### Flutter (Dart)
*   **`lib/pages/`**: Contains the main feature screens (`playback_page.dart`, `record_page.dart`, `voip_page.dart`, `multi_test_page.dart`).
*   **`lib/widgets/`**: Reusable UI components for audio configuration (`audio_config_fields.dart`), split views (`split_view_layout.dart`), and real-time visualization (`waveform_display.dart`).
*   **`lib/audio_engine.dart`**: The core Dart interface that communicates with the native Android layer via `MethodChannel` and `EventChannel`s.

### Android Native (Kotlin)
*   **`MainActivity.kt`**: Handles the Flutter engine initialization and registers channels.
*   **`AudioPlaybackManager.kt`**: Manages `AudioTrack` lifecycles, offload execution, and amplitude calculations.
*   **`AudioRecordingManager.kt`**: Manages `AudioRecord` lifecycles, permission checks, and file saving.
*   **`AudioDeviceManager.kt` / `AudioInfoHelper.kt`**: Helpers to enumerate devices and map Android's Audio Attributes integer constants.

## Requirements
*   Android device or emulator (Android API 23+ recommended, some features like Offload require newer API levels).
*   Microphone permissions are required for the recording and VoIP features.

## TODO
*   **Compress Offload**: Currently disabled due to a known bug. Needs investigation and fix to be fully supported.
*   **MMAP Support**: Plan to gradually add and support `mmap` (Memory-Mapped I/O) settings for audio operations.
