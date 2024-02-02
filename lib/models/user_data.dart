class UserData {
  final String token;
  final String username;
  final String refreshToken;
  final int expiresIn;
  final String avatar;

  UserData(
      {this.token,
      this.username,
      this.refreshToken,
      this.expiresIn,
      this.avatar});

  static UserData fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['access_token'],
      username: json['user']['name'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
      avatar: json['user_image'],
    );
  }
}
