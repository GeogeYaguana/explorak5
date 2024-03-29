class Session {
  final String token;
  final String username;
  final String refreshToken;
  final int expiresIn;
  final String avatar;
  final DateTime createdAt;

  Session(
      {this.token,
      this.username,
      this.refreshToken,
      this.expiresIn,
      this.avatar,
      this.createdAt});

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
        token: json['token'],
        username: json['username'],
        refreshToken: json['refreshToken'],
        expiresIn: json['expiresIn'],
        avatar: json['avatar'],
        createdAt: DateTime.parse(json['createdAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      "token": this.token,
      "username": this.username,
      "refreshToken": this.refreshToken,
      "expiresIn": this.expiresIn,
      "avatar": this.avatar,
      "createdAt": this.createdAt.toIso8601String()
    };
  }
}
