import 'dart:ffi';
import 'dart:io';

import 'package:logging/logging.dart';

class Loader {
   static final Logger log = Logger('Loader');

  static const List<String> LNX_DFLT_LIB_LOCS = ['/lib/', '/usr/lib/', '/usr/local/lib/'];
  static const List<String> MAC_DFLT_LIB_LOCS = ['/lib/', '/usr/lib/', '/usr/local/lib/'];
  static const List<String> WIN_DFLT_LIB_LOCS = ['C:/Windows/System32/', 'C:/Windows/SysWOW64/'];

  static DynamicLibrary openLibrary(String name, {String path}) {
    log.fine('Attempting to find and load library $name at path $path');
    String fullPath = _getFullPath(name, path: path);
    log.fine('Calling open for library $fullPath');
    return DynamicLibrary.open(fullPath);
  }

  static String _findFileInDirs(String name, List<String> dirs) {
    return dirs.firstWhere((d) {
      final testFile = File(d+name);
      return testFile.existsSync();
    });
  }

  static String _getFullLibName(String name) {
    if (Platform.isLinux) {
      return 'lib${name}.so';
    } else if (Platform.isMacOS) {
      return 'lib${name}.dylib';
    } else if (Platform.isWindows) {
      return '${name}.dll';
    } else {
      final errMsg = 'Platform ${Platform.operatingSystem} is not supported';
      log.severe(errMsg);
      throw Exception(errMsg);
    }
  }

  static String _getFullPath(String name, {String path}) {
    final fullLibName = _getFullLibName(name);
    if (path == null) {
      if (Platform.isLinux) {
        path = _findFileInDirs(fullLibName, LNX_DFLT_LIB_LOCS);
      } else if (Platform.isMacOS) {
        path = _findFileInDirs(fullLibName, MAC_DFLT_LIB_LOCS);
      } else if (Platform.isWindows) {
        path = _findFileInDirs(fullLibName, WIN_DFLT_LIB_LOCS);
      }
    }
    log.fine('Full path determined to be ${path}${fullLibName}');
    return path + fullLibName;
  }

}
