import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:music_app/app/models/home_music_response.dart';

import 'getx_audio_handler.dart';
import 'getx_playlist_repository.dart';

class GetXPlayerController extends GetxController {
  // Events: Calls coming from the UI
  Future<GetXPlayerController> init() async {
    await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
    return this;
  }

  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ''.obs;
  final currentSongArtNotifier = ''.obs;
  final playlistNotifier = <MediaItem>[].obs;
  final progressNotifier = ProgressModel.zero().obs;
  final repeatButtonNotifier = RepeatState.off.obs;
  final playButtonNotifier = ButtonState.paused.obs;
  final isFirstSongNotifier = true.obs;
  final isLastSongNotifier = true.obs;
  final isCloseNotifier = true.obs;
  final isShuffleModeEnabledNotifier = false.obs;
  final latestRelease = <LatestRelease>[].obs;
  final featuredArtists = <FeaturedArtist>[].obs;
  final playlists = <Playlist>[].obs;

  final _audioHandler = Get.find<GetXAudioHandler>().audioHandler;

  Future<void> _loadPlaylist() async {
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response = await songRepository.fetchInitialPlaylist();
    if (response.statusCode == 200) {
      var result = homeMusicResponseFromJson(response.bodyString ?? "");
      if (result.code == 200) {
        latestRelease.value = result.data!.latestRelease ?? [];
        featuredArtists.value = result.data!.featuredArtists ?? [];
        playlists.value = result.data!.playlists ?? [];
      }
    }
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
        currentSongArtNotifier.value = '';
      } else {
        playlistNotifier.value = playlist;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else if (processingState == AudioProcessingState.idle) {
        playButtonNotifier.value = ButtonState.idle;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressModel(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressModel(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressModel(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      currentSongArtNotifier.value = mediaItem?.artUri.toString() ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() {
    _audioHandler.play();
    isCloseNotifier.value = false;
  }

  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);
  void forwordSeek10Sec() {
    _audioHandler.seek(Duration(
        seconds: _audioHandler.playbackState.value.position.inSeconds + 10));
  }

  void backwordSeek10Sec() {
    if (_audioHandler.playbackState.value.position >
        const Duration(seconds: 10)) {
      _audioHandler.seek(Duration(
          seconds: _audioHandler.playbackState.value.position.inSeconds - 10));
    } else {
      _audioHandler.seek(const Duration(seconds: 0));
    }
  }

  void previous() => _audioHandler.skipToPrevious();

  void next() => _audioHandler.skipToNext();

  void repeat() {
    _nextRepeatState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void _nextRepeatState() {
    final next =
        (repeatButtonNotifier.value.index + 1) % RepeatState.values.length;
    repeatButtonNotifier.value = RepeatState.values[next];
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  Future<void> add(mediaItem) async {
    _audioHandler.addQueueItems(mediaItem);
    play();
  }

  Future<void> removeLastItemFromIndex() async {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    await _audioHandler.removeQueueItemAt(lastIndex);
  }

  Future<void> clearPlaylist() async {
    final lastIndex = _audioHandler.queue.value.length - 1;

    for (int i = 0; i <= lastIndex; i++) {
      await removeLastItemFromIndex();
    }
  }

  @override
  void dispose() {
    _audioHandler.customAction('dispose');
    super.dispose();
  }

  void stop() {
    _audioHandler.stop();
    //playButtonNotifier.value = ButtonState.idle;
  }
}

class ProgressModel {
  final Duration current;
  final Duration buffered;
  final Duration total;

  const ProgressModel({
    required this.current,
    required this.buffered,
    required this.total,
  });

  ProgressModel.zero()
      : current = Duration.zero,
        buffered = Duration.zero,
        total = Duration.zero;
}

enum RepeatState {
  off,
  repeatSong,
  repeatPlaylist,
}

enum ButtonState {
  paused,
  playing,
  loading,
  idle,
}
