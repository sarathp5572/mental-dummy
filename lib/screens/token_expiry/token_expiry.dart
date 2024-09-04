


class TokenManager {
  static bool _isTokenExpired = false;
  static bool get isTokenExpired => _isTokenExpired;

  static bool _isErrorMessage = false;
  static bool get isErrorMessage => _isErrorMessage;

  static checkTokenExpiry() {
    if (isTokenExpired) {
      _isTokenExpired = true;
    } else {
      _isTokenExpired = false;
    }
    return _isTokenExpired;
  }

  static void setError(bool isError) {
    _isErrorMessage = isError;
  }

  static void setTokenStatus(bool isValue) {
    _isTokenExpired = isValue;
  }

}

