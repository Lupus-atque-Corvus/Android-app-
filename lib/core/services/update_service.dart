import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class UpdateInfo {
  const UpdateInfo({
    required this.latestVersion,
    required this.releaseNotes,
    required this.apkDownloadUrl,
  });
  final String latestVersion;
  final String releaseNotes;
  final String apkDownloadUrl;
}

class UpdateService {
  static const _apiUrl =
      'https://api.github.com/repos/Lupus-atque-Corvus/Android-app-/releases/latest';

  static Future<UpdateInfo?> checkForUpdate() async {
    try {
      final info = await PackageInfo.fromPlatform();
      final response = await http
          .get(
            Uri.parse(_apiUrl),
            headers: {'Accept': 'application/vnd.github.v3+json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final tag = (data['tag_name'] as String? ?? '').replaceFirst('v', '');

      if (!_isNewer(tag, info.version)) return null;

      final assets = (data['assets'] as List<dynamic>?) ?? [];
      final apkAsset = assets
          .cast<Map<String, dynamic>>()
          .where((a) => (a['name'] as String?) == 'app-arm64-v8a-release.apk')
          .firstOrNull;

      if (apkAsset == null) return null;

      return UpdateInfo(
        latestVersion: tag,
        releaseNotes: data['body'] as String? ?? '',
        apkDownloadUrl: apkAsset['browser_download_url'] as String,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<void> downloadAndInstall(
    String url,
    void Function(double?) onProgress,
  ) async {
    final dir = await getTemporaryDirectory();
    final apkFile = File('${dir.path}/traum_update.apk');

    final client = http.Client();
    try {
      final req = http.Request('GET', Uri.parse(url));
      final resp = await client.send(req);
      final total = resp.contentLength;
      int received = 0;
      final sink = apkFile.openWrite();
      await for (final chunk in resp.stream) {
        sink.add(chunk);
        received += chunk.length;
        onProgress(total != null ? received / total : null);
      }
      await sink.flush();
      await sink.close();
    } finally {
      client.close();
    }

    await OpenFile.open(apkFile.path);
  }

  static bool _isNewer(String latest, String current) {
    int part(String v, int i) {
      final p = v.split('.');
      return i < p.length ? (int.tryParse(p[i]) ?? 0) : 0;
    }
    for (int i = 0; i < 3; i++) {
      final l = part(latest, i), c = part(current, i);
      if (l > c) return true;
      if (l < c) return false;
    }
    return false;
  }
}
