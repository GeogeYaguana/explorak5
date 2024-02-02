class HttpResponse {
  final dynamic data;
  final HttpError error;

  HttpResponse(this.data, this.error);

  static HttpResponse success(dynamic data) => HttpResponse(data, null);
  static HttpResponse fail(
          {int statusCode, String message, dynamic data, dynamic headers}) =>
      HttpResponse(
          null,
          HttpError(
              headers: headers,
              statusCode: statusCode,
              message: message,
              data: data));
}

class HttpError {
  final int statusCode;
  final String message;
  final dynamic data;
  final dynamic headers;

  HttpError({this.statusCode, this.message, this.data, this.headers});
}
