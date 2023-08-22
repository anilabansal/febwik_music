import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_app/app/models/home_music_response.dart';
import 'package:music_app/app/models/view_more.dart';
import '../models/artist.dart';
import 'getx_audio_handler.dart';
import 'getx_playlist_repository.dart';

class GetXPlayerController extends GetxController {
  // Events: Calls coming from the UI
  Future<GetXPlayerController> init() async {
    print('step 1 init');
    _loadPlaylist();
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
  final currentSongArtistNotifier = ''.obs;
  final currentSongArtNotifier = ''.obs;
  final currentSongIdNotifier = ''.obs;
  final isFavouriteSong = 1.obs;
  final playlistNotifier = <MediaItem>[].obs;
  final progressNotifier = ProgressModel
      .zero()
      .obs;
  final repeatButtonNotifier = RepeatState.off.obs;
  final playButtonNotifier = ButtonState.paused.obs;
  final isFirstSongNotifier = true.obs;
  final isLastSongNotifier = true.obs;
  final isCloseNotifier = true.obs;
  final isShuffleModeEnabledNotifier = false.obs;
  final latestRelease = <LatestRelease>[].obs;
  final featuredArtists = <FeaturedArtist>[].obs;
  final playlists = <Playlist>[].obs;
  final trending = <LatestRelease>[].obs;
  final artist = <Artists>[].obs;
  final artistPageData = ArtistData().obs;
  final artistSongList = <Songs>[].obs;
  final viewMoreData = ViewMoreData().obs;
  final viewMoreSongList = <ViewMoreSongs>[].obs;
  var isLoading = true.obs;
  var isArtistLoading = true.obs;
  var viewMoreIsLoading = true.obs;
  var selectedSong = ''.obs;
  final _audioHandler = Get
      .find<GetXAudioHandler>()
      .audioHandler;
  int homeDestinationIndex = 0;
  var isPlayListLoading = true.obs;
  var createdPlayList = <Songs>[].obs;
  ///Todo:to check create playlist validation
  var textError = false.obs;

  ///TODO: load playlist api call
  Future<void> _loadPlaylist() async {
    print('step 2 _loadPlaylist');
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response = await songRepository.fetchInitialPlaylist();
    if (response.statusCode == 200) {
      isLoading.value = false;
      var result = homeMusicResponseFromJson(response.bodyString ?? "");
      if (result.code == 200) {
        latestRelease.value = result.data!.latestRelease ?? [];
        featuredArtists.value = result.data!.featuredArtists ?? [];
        playlists.value = result.data!.playlists ?? [];
        trending.value = result.data!.tranding ?? [];
        print("latestRelease --->$latestRelease");
        print("latestRelease12345 --->$playlists");
      }
    }
  }

  ///TODO: artist detail api call
  Future<bool> loadArtistDetailApiCall(index, page) async {
    print("artist--------->");
    // isArtistLoading.value = true;
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response =
    await songRepository.getArtistDetailSongList(index, page);

    if (response.statusCode == 200) {
      print("success api call");
      isArtistLoading.value = false;
      print("result--->${response.bodyString}");
      var result = artistPageFromJson(response.bodyString ?? "");
      artistPageData.value = result.data!;
      artistSongList.addAll(result.data!.songs!);
      print("initialArtistSongs${artistSongList.length}");

      return true;
    }
    return false;
  }

  ///TODO: view more button api call
  Future<bool> loadViewMoreApiCall(slug, page) async {
    print("artist--------->");
    // isArtistLoading.value = true;
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response = await songRepository.getViewMoreList(slug, page);
    if (response.statusCode == 200) {
      print("success api call");
      viewMoreIsLoading.value = false;
      print("result--->${response.bodyString}");
      var result = ViewMoreDateFromJson(response.bodyString ?? "");
      // if(result.data!=null){
      // viewMoreData.value = result.data! ;
      viewMoreSongList.addAll(result.data!);
      print("initialViewSongs${viewMoreSongList.length}");
      print("initialViewFirstSongs${viewMoreSongList[0].thumbnail128}");
      return true;
    }
    return false;
  }

  ///Todo: artist page update status of like and  unlike
  updateLikeUnlikeSongs(index) {
    if (artistSongList[index].isFavourite == 1) {
      artistSongList[index].isFavourite = 0;
    } else if (artistSongList[index].isFavourite == 0) {
      artistSongList[index].isFavourite = 1;
    }
    update();
  }

  ///Todo: view more page update status of like and  unlike
  updateViewMoreLikeUnlikeSongs(index) {
    if (viewMoreSongList[index].isFavourite == 1) {
      viewMoreSongList[index].isFavourite = 0;
    } else if (viewMoreSongList[index].isFavourite == 0) {
      viewMoreSongList[index].isFavourite = 1;
    }
    update();
  }



  ///TODO:like unlike of songs API
  Future<bool> likeUnlikeSongsApiCall(body) async {
    print("artist--------->");
    // isArtistLoading.value = true;
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response = await songRepository.likeUnlikeSongs(body);
    if (response.statusCode == 200) {
      print("success api call");

      return true;
    }
    return false;
  }

  ///Todo: add to playlist
  Future<bool> addToPlaylist(body) async {
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response = await songRepository.addToPlayList(body);
    if (response.statusCode == 200) {
      print("success api call");
      Map<String, dynamic> jsonResponse = response.body;
      print("body ---> ${response.body}");
      if (jsonResponse['status'] == 1) {
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          textColor: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.back();
        Get.back();
      }
      else {
        Fluttertoast.showToast(
          msg: jsonResponse["message"],
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
    return false;
  }

  void updateMediaItemLikeSong() {
    if (isFavouriteSong.value == 1) {
      isFavouriteSong.value = 0;
    } else if (isFavouriteSong.value == 0) {
      isFavouriteSong.value = 1;
    }
    update();
  }

  ///TODO: get playlist
  Future<bool> getPlayListApiCall() async {
    isPlayListLoading.value = true;
    final songRepository = Get.find<GetXDemoPlaylist>();
    Response response = await songRepository.getPlayList();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.body;
      print("body ---> ${response.body}");
      print("list data -->${jsonResponse["data"]}");
      if (jsonResponse["status"] == 1) {
        createdPlayList.value =
            List<Songs>.from(jsonResponse["data"].map((e) =>
                Songs.fromJson(e)));

      }

    isPlayListLoading.value = false;
    createdPlayList.forEach((element) {
    print("list name ${element.name}");
    });
  }


  return false;
}

void _listenToChangesInPlaylist() {
  print('step 3 _listenToChangesInPlaylist');

  _audioHandler.queue.listen((playlist) {
    print("playlistmedia6567576576--->$playlist");
    if (playlist.isEmpty) {
      playlistNotifier.value = [];
      currentSongTitleNotifier.value = '';
      currentSongArtNotifier.value = '';
      currentSongArtistNotifier.value = '';
      currentSongIdNotifier.value = '';
      isFavouriteSong.value = 0;
    } else {
      playlistNotifier.value = playlist;
      printSongsName1(playlistNotifier);
      print("isNotEmpty--->$playlistNotifier");
    }
    _updateSkipButtons();
  });
  print("playist--->$playlistNotifier");
}

void _listenToPlaybackState() {
  print('step 4 _listenToPlaybackState');
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
  print('step 5 _listenToCurrentPosition');
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
  print('step 6 _listenToBufferPosition');
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
  print('step 7 _listenToTimeDuration');
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
  print('step 8 _listenToChangeSong');
  _audioHandler.mediaItem.listen((mediaItem) {
    currentSongTitleNotifier.value = mediaItem?.title ?? '';
    currentSongArtNotifier.value = mediaItem?.artUri.toString() ?? '';
    currentSongArtistNotifier.value = mediaItem?.artist.toString() ?? '';
    currentSongIdNotifier.value = mediaItem?.id.toString() ?? '';
    isFavouriteSong.value = mediaItem?.extras!["isFavourite"] ?? 0;

    print("artist value---->${currentSongIdNotifier.value}");
    print("title --->${currentSongTitleNotifier.value}");
    _updateSkipButtons();
  });
}

void _updateSkipButtons() {
  print('step 9 _updateToskipBitton');
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
  print('step 10 play');
  _audioHandler.play();
  isCloseNotifier.value = false;
}

void pause() => _audioHandler.pause();

void seek(Duration position) => _audioHandler.seek(position);

void forwardSeek10Sec() {
  print('step 11 skip10secforward');
  _audioHandler.seek(Duration(
      seconds: _audioHandler.playbackState.value.position.inSeconds + 10));
}

void backwardSeek10Sec() {
  print('step12 skip10secBackward');
  if (_audioHandler.playbackState.value.position >
      const Duration(seconds: 10)) {
    _audioHandler.seek(Duration(
        seconds: _audioHandler.playbackState.value.position.inSeconds - 10));
  } else {
    _audioHandler.seek(const Duration(seconds: 0));
  }
}

void previous() => _audioHandler.skipToPrevious();

void next() {
  print("is liked12 next---${isFavouriteSong.value}");
  _audioHandler.skipToNext();
}

void startFromStarting() => _audioHandler.skipToQueueItem(0);

void startFromEnd() =>
    _audioHandler.skipToQueueItem(_audioHandler.queue.value.length - 1);

void repeat() {
  print('step12 repeat');
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
  print('step13 nextRepeat');
  final next =
      (repeatButtonNotifier.value.index + 1) % RepeatState.values.length;
  repeatButtonNotifier.value = RepeatState.values[next];
}

void shuffle() {
  print('step14 shuffle');
  final enable = !isShuffleModeEnabledNotifier.value;
  isShuffleModeEnabledNotifier.value = enable;
  if (enable) {
    _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
  } else {
    _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
  }
}

void add(mediaItem,
    index,) async {
  await _audioHandler.stop();
  print('list new1');
  printSongsName1(_audioHandler.queue.value);
  print('media item');
  printSongsName1(mediaItem);
  _audioHandler.addQueueItems(mediaItem);
  _audioHandler.skipToQueueItem(index);
  play();
}

Future<void> removeLastItemFromIndex() async {
  final lastIndex = _audioHandler.queue.value.length - 1;
  if (lastIndex < 0) return;
  await _audioHandler.removeQueueItemAt(lastIndex);
}

Future<void> clearPlaylist() async {
  // final lastIndex = _audioHandler.queue.value.length - 1;
  // print("lastIndex--->${lastIndex}");
  // for (int i = 0; i < playlistNotifier.value.length; i++) {
  //   await removeLastItemFromIndex();
  //   // await _audioHandler.removeQueueItemAt(i);
  // }

  print('playlistNotifier');
  print(playlistNotifier);
  playlistNotifier.value = [];
  print("playlistNotifier.value--->$playlistNotifier");
  print("currentSongArtNotifier.value-->${currentSongArtNotifier.value}");
  print('list 1');
  printSongsName1(_audioHandler.queue.value);
  _audioHandler.queue.value.clear();
  artist.clear();

  update();

  print('list 2');
  printSongsName1(_audioHandler.queue.value);
  print(_audioHandler.queue.value.isEmpty);
  print('Current Length - ${_audioHandler.queue.value.length}');
  print('playlist Length - ${playlistNotifier.length}');
}

void printSongsName1(list) {
  list.forEach((item) {
    print(item.title);
  });
}

void printSongsName(list) {
  list.forEach((item) {
    print(item.name);
  });
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

stopSongs() {
  _audioHandler.stop();
  _audioHandler.customAction('dispose');
}}

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
