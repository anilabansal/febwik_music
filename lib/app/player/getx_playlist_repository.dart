import 'package:get/get.dart';
import 'package:music_app/app/services/api.dart';
import 'package:music_app/app/services/api_client.dart';

class GetXDemoPlaylist extends GetxService {
  Future<GetXDemoPlaylist> init() async {
    return this;
  }

  // Future<List<Map<String, String>>> fetchInitialPlaylist(
  //     {int length = 5}) async {
  //   var response = await getHomeSongList();
  //   return List.generate(length, (index) => _nextSong());
  // }
  Future<Response> fetchInitialPlaylist() async {
    return await getHomeSongList();
  }

  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong();
  }

  ///TODO: home list
  Future<Response> getHomeSongList() async {
    return await ApiClient().getRequest(Api.home);
  }

  ///TODO: artist detail
  Future<Response> getArtistDetailSongList(index, page) async {
    return await ApiClient()
        .getRequest("${Api.artistDetailUrl}$index?page=$page");
  }

  ///TODO: view more api call
  Future<Response> getViewMoreList(slug, page) async {
    return await ApiClient().getRequest("${Api.viewMoreUrl}$slug?page=$page");
  }

  ///TODO: login api call
  Future<dynamic> loginApiCall(phoneNumber) async {
    return await ApiClient().getRequest("${Api.loginUrl}$phoneNumber");
  }

  ///TODO: otp verification screen
  Future<dynamic> otpVerification(body) async {
    return await ApiClient().postRequest(Api.otpVerificationUrl, body);
  }

  ///TODO: like unlike songs
  Future<dynamic> likeUnlikeSongs(body) async {
    return await ApiClient().postRequest(Api.addRemoveToFavouriteUrl, body);
  }

  ///Todo: like songs list api call
  Future<dynamic> likeSongsListApiCall() async {
    return await ApiClient().getRequest(Api.addRemoveToFavouriteUrl);
  }

  ///TODO: add to playlist
  Future<dynamic> addToPlayList(body) async {
    return await ApiClient().postRequest(Api.addToPlayList, body);
  }

  ///TODO: get playlist
  Future<dynamic> getPlayList() async {
    return await ApiClient().getRequest(Api.addToPlayList);
  }

  ///TODO: playlist songs list
  Future<dynamic> playListSongs(playListName) async {
    return await ApiClient().getRequest("${Api.playListSongs}$playListName");
  }

  var _songIndex = 0;
  static const _maxSongNumber = 10;

  Map<String, String> _nextSong() {
    _songIndex = (_songIndex % _maxSongNumber) + 1;
    return {
      'id': _songIndex.toString().padLeft(3, '0'),
      'title': 'Song $_songIndex',
      'album': 'SoundHelix',
      'url': musicUrls[_songIndex],
      'artUri': 'https://source.unsplash.com/random/?music&w=200&$_songIndex',
    };
  }
}

const musicUrls = [
  'https://www.gwern.net/docs/ai/music/2020-03-24-gpt2-midi-mknrad.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-15-gpt2-midi-thesessionsabc-2625946.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-15-gpt2-midi-thesessionsabc-19337613.mp3',
  'https://www.gwern.net/docs/ai/music/2019-12-09-gpt2-combinedabc-100samples.mp3',
  'https://www.gwern.net/docs/ai/music/2019-12-04-gpt2-combinedabc-invereshieshouse.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-15-gpt2-midi-pop_mid-ismirlmd_matchedg.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-15-gpt2-midi-lmd_full-ee_214dda09c3020.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-18-gpt2-midi-thesessions-14.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-18-gpt2-midi-popmidi-31.mp3',
  'https://www.gwern.net/docs/ai/music/2020-04-15-gpt2-midi-lmd_full-554f3a38f2676bfe.mp3'
];
