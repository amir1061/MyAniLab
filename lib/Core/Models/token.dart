import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class Token {
  late String _accessToken;
  late String _refreshToken;
  late String _tokenType;
  late int _expiresIn;

  Token(
    this._accessToken,
    this._refreshToken,
    this._tokenType,
    this._expiresIn,
  );
  String get token => '$_tokenType $_accessToken';
  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  String get tokenType => _tokenType;
  int get expiresIn => _expiresIn;

  set accessToken(String accessToken) {
    _accessToken = accessToken;
    const FlutterSecureStorage().write(key: 'accessToken', value: _accessToken);
  }

  set refreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    const FlutterSecureStorage()
        .write(key: 'refreshToken', value: _refreshToken);
  }

  set tokenType(String tokenType) {
    _tokenType = tokenType;
    const FlutterSecureStorage().write(key: 'tokenType', value: _tokenType);
  }

  set expiresIn(int expiresIn) {
    _expiresIn = expiresIn;
    const FlutterSecureStorage().write(
      key: 'expiresIn',
      value: _expiresIn.toString(),
    );
  }

  Token.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refresh_token'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    GetIt.I.registerSingleton<Token>(this);
  }

  static Future<Token?> fromStorage() async {
    const _storage = FlutterSecureStorage();
    final at = await _storage.read(key: 'accessToken');
    final rt = await _storage.read(key: 'refreshToken');
    final tt = await _storage.read(key: 'tokenType');
    final ei = await _storage.read(key: 'expiresIn');
    if (at != null && rt != null && tt != null && ei != null) {
      final t = Token(at, rt, tt, int.parse(ei));
      GetIt.I.registerSingleton<Token>(t);
      return t;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': _refreshToken,
      'access_token': _accessToken,
      'token_type': _tokenType,
      'expires_in': _expiresIn,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
