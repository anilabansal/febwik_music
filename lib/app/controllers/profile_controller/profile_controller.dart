import 'package:get/get.dart';
import '../../models/artist.dart';
import '../../player/getx_playlist_repository.dart';

class ProfileController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    likeSongsApiCall();
  }


  ///TODO: favourite songs list

  var likeSongs = <Songs>[].obs;
  var playListSongs = <Songs>[].obs;
  var isLikeSongsLoading = true.obs;
  var isPlayListSongLoading = true.obs;


///TODO: like songs list api call
  Future<bool> likeSongsApiCall() async {
    Response response =
        await Get.find<GetXDemoPlaylist>().likeSongsListApiCall();
    if (response.statusCode == 200) {
      isLikeSongsLoading.value = false;
      Map<String, dynamic> jsonResponse = response.body;
      if (jsonResponse['status'] == 1) {
        if (jsonResponse['data'] != null) {
          print("songs list --> ${jsonResponse['data']}");
          likeSongs.value = List<Songs>.from(
              jsonResponse['data'].map((x) => Songs.fromJson(x)));
        }
        return true;
      }
    }
    return false;
  }

  ///TODO: playlist songs api call
Future<bool> playListSongApiCall(playListName) async{
    Response response = await Get.find<GetXDemoPlaylist>().playListSongs(playListName);
    if(response.statusCode==200){
      isPlayListSongLoading.value = false;
      Map<String, dynamic> jsonResponse = response.body;
      if (jsonResponse['data'] != null) {
        print("songs list --> ${jsonResponse['data']}");
        playListSongs.value = List<Songs>.from(
            jsonResponse['data'].map((x) => Songs.fromJson(x)));
      }
    }
    return false;
}


///TODO: playlist songs like unlike
  updateViewMoreLikeUnlikeSongs(index) {
    if (playListSongs[index].isFavourite == 1) {
      playListSongs[index].isFavourite = 0;
    } else if (playListSongs[index].isFavourite == 0) {
      playListSongs[index].isFavourite = 1;
    }
    update();
  }


}
