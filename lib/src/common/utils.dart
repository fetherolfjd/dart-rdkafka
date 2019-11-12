import 'dart:ffi';

import 'dart:io';

String _getPath(String name, {String path}) {
  path ??= '';

  if (Platform.isLinux) {
    return path + 'lib' + name + '.so';
  } else {
    throw Exception('Platform ${Platform.operatingSystem} not supported');
  }
}

DynamicLibrary openLibraryForPlatform(String name, {String path}) {
  String fullPath = _getPath(name, path: path);
  return DynamicLibrary.open(fullPath);
}
