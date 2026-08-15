import 'dart:io';

import 'package:image/image.dart' as img;

/// Crops the VectorStock footer off the owner-supplied mark and writes
/// the square PNG used for the launcher and in-app logo.
void main(List<String> args) {
  if (args.length < 2) {
    stderr.writeln('usage: dart run tool/prepare_icon.dart <src> <dest>');
    exit(64);
  }
  final source = File(args[0]);
  final dest = File(args[1]);
  final decoded = img.decodeImage(source.readAsBytesSync());
  if (decoded == null) {
    stderr.writeln('Could not read ${source.path}');
    exit(1);
  }

  // The supplied file has a VectorStock line along the bottom edge.
  final usableHeight = (decoded.height * 0.90).round();
  var cropped = img.copyCrop(
    decoded,
    x: 0,
    y: 0,
    width: decoded.width,
    height: usableHeight,
  );
  final side = cropped.width < cropped.height ? cropped.width : cropped.height;
  cropped = img.copyCrop(
    cropped,
    x: ((cropped.width - side) / 2).round(),
    y: 0,
    width: side,
    height: side,
  );
  final out = img.copyResize(
    cropped,
    width: 1024,
    height: 1024,
    interpolation: img.Interpolation.cubic,
  );
  dest.parent.createSync(recursive: true);
  dest.writeAsBytesSync(img.encodePng(out));
  stdout.writeln('Wrote ${dest.path} (${out.width}x${out.height})');
}
