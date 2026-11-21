import 'dart:io';

// Các giá trị cấu hình của app.
// Đổi khi build bằng: flutter run --dart-define=API_BASE_URL=https://.../api/v1
class Env {
  static const _apiFromDefine = String.fromEnvironment('API_BASE_URL');

  // Địa chỉ API. Không truyền thì dùng API chạy trên máy mình:
  // - máy ảo Android gọi máy tính qua 10.0.2.2
  // - máy ảo iOS gọi thẳng localhost
  static String get apiBaseUrl {
    if (_apiFromDefine.isNotEmpty) return _apiFromDefine;
    if (Platform.isAndroid) return 'http://10.0.2.2:3000/api/v1';
    return 'http://localhost:3000/api/v1';
  }

  // phiên bản app, gửi lên API để kiểm tra có bắt cập nhật không
  static const appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );
}
