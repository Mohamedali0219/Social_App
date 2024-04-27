class PostModel {
  String? name;
  String? uId;
  String? image;
  String? iamgePost;
  String? dateTime;
  String? text;

  PostModel(
      {this.name,
      this.uId,
      this.image,
      this.dateTime,
      this.text,
      this.iamgePost});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    iamgePost = json['iamgePost'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uId': uId,
      'iamgePost': iamgePost,
      'image': image,
    };
  }
}
