class MessageModel {
  String? message;
  String? reciverId;
  String? senderId;
  String? dateTime;

  MessageModel({
    this.message,
    this.reciverId,
    this.senderId,
    this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    message = json['reciverId'];
    message = json['senderId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': message,
      'dateTime': dateTime,
      'text': message,
      'uId': message,
    };
  }
}
