// class Artists {
//   String? title;
//   String? imgUrl;
//   Artists({this.title, this.imgUrl});
//
//   static List<Artists> artistList = [
//     Artists(
//         title: "Arijit Singh",
//         imgUrl:
//             "https://static.toiimg.com/photo/msid-91352401/91352401.jpg?30106"),
//     Artists(
//         title: "Krishn Kumar",
//         imgUrl:
//             "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/KK_%28125%29.jpg/1200px-KK_%28125%29.jpg"),
//     Artists(
//         title: "Alka Yagnik",
//         imgUrl:
//             "https://lyrics.soniyal.com/wp-content/uploads/2020/09/Alka-Yagnik-Singer.jpg"),
//     Artists(
//         title: "Lata Mangeshkar",
//         imgUrl:
//             "https://st1.bollywoodlife.com/wp-content/uploads/2021/09/Lata-Mangeshkar-.jpg"),
//     Artists(
//         title: "Udit Narayan",
//         imgUrl:
//             "https://s.saregama.tech/image/c/m/7/2b/22/udit-narayan_1624599321.jpg"),
//     Artists(
//         title: "Manoj Muntashir",
//         imgUrl: "https://static.toiimg.com/photo/msid-85678940/85678940.jpg"),
//   ];
// }

import 'dart:convert';

import 'home_music_response.dart';

ArtistPage artistPageFromJson(String str) =>
    ArtistPage.fromJson(json.decode(str));

class ArtistPage {
  ArtistData? data;

  ArtistPage({this.data});

  ArtistPage.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  ArtistData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ArtistData {
  Singer? singer;
  List<Songs>? songs;

  ArtistData({this.singer, this.songs});

  ArtistData.fromJson(Map<String, dynamic> json) {
    singer =
    json['singer'] != null ?  Singer.fromJson(json['singer']) : null;
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add( Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.singer != null) {
      data['singer'] = this.singer!.toJson();
    }
    if (this.songs != null) {
      data['songs'] = this.songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Singer {
  String? name;
  String? image;

  Singer({this.name, this.image});

  Singer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Songs {
  int? id;
  String? name;
  String? songSlug;
  String? songFile;
  String? thumbnail128;
  String? thumbnail320;
  int? isFavourite;
  List<Artists>? artists;
  int? selectedIndex;

  Songs(
      {this.id,
        this.name,
        this.songSlug,
        this.songFile,
        this.thumbnail128,
        this.thumbnail320,
        this.isFavourite,
        this.artists,
        this.selectedIndex,
      });

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    songSlug = json['song_slug'];
    songFile = json['song_file'];
    thumbnail128 = json['thumbnail_128'];
    thumbnail320 = json['thumbnail_320'];
    isFavourite = json['is_favourite'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add( Artists.fromJson(v));
      });
    }
    selectedIndex = -1;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['song_slug'] = this.songSlug;
    data['song_file'] = this.songFile;
    data['thumbnail_128'] = this.thumbnail128;
    data['thumbnail_320'] = this.thumbnail320;
    data['is_favourite'] = this.isFavourite;
    return data;
  }
}
