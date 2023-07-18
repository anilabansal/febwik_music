class LoginDetail {
  int? status;
  String? message;
  int? id;
  String? accessToken;
  String? tokenType;
  String? expiresAt;

  LoginDetail(
      {this.status,
        this.message,
        this.id,
        this.accessToken,
        this.tokenType,
        this.expiresAt});

  LoginDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id'] = this.id;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    return data;
  }
}