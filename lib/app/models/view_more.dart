
import 'dart:convert';

ViewMoreData ViewMoreDateFromJson(String str) =>
    ViewMoreData.fromJson(json.decode(str));

class ViewMoreData {
  List<ViewMoreSongs>? data;

  ViewMoreData({this.data});

  ViewMoreData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ViewMoreSongs>[];
      json['data'].forEach((v) {
        data!.add( ViewMoreSongs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewMoreSongs {
  int? id;
  String? name;
  String? songSlug;
  String? tagName;
  String? songFile;
  String? thumbnail128;
  String? thumbnail320;
  List<SongArtists>? artists;
  int? isFavourite;

  ViewMoreSongs(
      {this.id,
        this.name,
        this.songSlug,
        this.tagName,
        this.songFile,
        this.thumbnail128,
        this.thumbnail320,
        this.artists,
        this.isFavourite});

  ViewMoreSongs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    songSlug = json['song_slug'];
    tagName = json['tag_name'];
    songFile = json['song_file'];
    thumbnail128 = json['thumbnail_128'];
    thumbnail320 = json['thumbnail_320'];
    if (json['artists'] != null) {
      artists = <SongArtists>[];
      json['artists'].forEach((v) {
        artists!.add( SongArtists.fromJson(v));
      });
    }
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['song_slug'] = this.songSlug;
    data['tag_name'] = this.tagName;
    data['song_file'] = this.songFile;
    data['thumbnail_128'] = this.thumbnail128;
    data['thumbnail_320'] = this.thumbnail320;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    data['is_favourite'] = this.isFavourite;
    return data;
  }
}

class SongArtists {
  String? name;
  String? slug;
  int? id;

  SongArtists({this.name, this.slug, this.id});

  SongArtists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['id'] = this.id;
    return data;
  }
}