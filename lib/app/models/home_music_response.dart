import 'dart:convert';

HomeMusicResponse homeMusicResponseFromJson(String str) =>
    HomeMusicResponse.fromJson(json.decode(str));

class HomeMusicResponse {
  HomeMusicResponse({
    this.data,
    this.status,
    this.code,
    this.message,
  });

  Data? data;
  int? status;
  int? code;
  String? message;

  factory HomeMusicResponse.fromJson(Map<String, dynamic> json) =>
      HomeMusicResponse(
        data: json["data"] == null ? Data() : Data.fromJson(json["data"]),
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );
}

class Data {
  Data({
    this.latestRelease,
    this.featuredArtists,
    this.playlists,
  });

  List<LatestRelease>? latestRelease;
  List<FeaturedArtist>? featuredArtists;
  List<Playlist>? playlists;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        latestRelease: json["latest_release"] == null
            ? []
            : List<LatestRelease>.from(
                json["latest_release"].map((x) => LatestRelease.fromJson(x))),
        featuredArtists: json["featured_artists"] == null
            ? []
            : List<FeaturedArtist>.from(json["featured_artists"]
                .map((x) => FeaturedArtist.fromJson(x))),
        playlists: json["playlists"] == null
            ? []
            : List<Playlist>.from(
                json["playlists"].map((x) => Playlist.fromJson(x))),
      );
}

class FeaturedArtist {
  FeaturedArtist({
    this.id,
    this.name,
    this.email,
    this.contactNo,
    this.gender,
    this.emailVerifiedAt,
    this.approved,
    this.verified,
    this.verifiedAt,
    this.verificationToken,
    this.firebaseUid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.roleId,
  });

  int? id;
  String? name;
  String? email;
  String? contactNo;
  String? gender;
  String? emailVerifiedAt;
  int? approved;
  int? verified;
  String? verifiedAt;
  String? verificationToken;
  String? firebaseUid;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  int? roleId;

  factory FeaturedArtist.fromJson(Map<String, dynamic> json) => FeaturedArtist(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        contactNo: json["contact_no"],
        gender: json["gender"],
        emailVerifiedAt: json["email_verified_at"],
        approved: json["approved"],
        verified: json["verified"],
        verifiedAt: json["verified_at"],
        verificationToken: json["verification_token"],
        firebaseUid: json["firebase_uid"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        userId: json["user_id"],
        roleId: json["role_id"],
      );
}

class LatestRelease {
  LatestRelease({
    this.id,
    this.name,
    this.songSlug,
    this.songFile,
    this.thumbnail128,
    this.thumbnail320,
    this.isFavourite,
  });

  int? id;
  String? name;
  String? songSlug;
  String? songFile;
  String? thumbnail128;
  String? thumbnail320;
  int? isFavourite;

  factory LatestRelease.fromJson(Map<String, dynamic> json) => LatestRelease(
        id: json["id"],
        name: json["name"],
        songSlug: json["song_slug"],
        songFile: json["song_file"],
        thumbnail128: json["thumbnail_128"],
        thumbnail320: json["thumbnail_320"],
        isFavourite: json["is_favourite"],
      );
}

class Playlist {
  Playlist({
    this.name,
    this.slug,
    this.id,
    this.playlists,
  });

  String? name;
  String? slug;
  int? id;
  List<LatestRelease>? playlists;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        name: json["name"],
        slug: json["slug"],
        id: json["id"],
        playlists: json["value"] == null
            ? []
            : List<LatestRelease>.from(
                json["value"].map((x) => LatestRelease.fromJson(x))),
      );
}
