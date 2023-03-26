class Artists {
  String? title;
  String? imgUrl;
  Artists({this.title, this.imgUrl});

  static List<Artists> artistList = [
    Artists(
        title: "Arijit Singh",
        imgUrl:
            "https://static.toiimg.com/photo/msid-91352401/91352401.jpg?30106"),
    Artists(
        title: "Krishn Kumar",
        imgUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/KK_%28125%29.jpg/1200px-KK_%28125%29.jpg"),
    Artists(
        title: "Alka Yagnik",
        imgUrl:
            "https://lyrics.soniyal.com/wp-content/uploads/2020/09/Alka-Yagnik-Singer.jpg"),
    Artists(
        title: "Lata Mangeshkar",
        imgUrl:
            "https://st1.bollywoodlife.com/wp-content/uploads/2021/09/Lata-Mangeshkar-.jpg"),
    Artists(
        title: "Udit Narayan",
        imgUrl:
            "https://s.saregama.tech/image/c/m/7/2b/22/udit-narayan_1624599321.jpg"),
    Artists(
        title: "Manoj Muntashir",
        imgUrl: "https://static.toiimg.com/photo/msid-85678940/85678940.jpg"),
  ];
}
