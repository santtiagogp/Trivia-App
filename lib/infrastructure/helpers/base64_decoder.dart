import 'dart:convert';
import 'dart:typed_data';

class CustomBase64Decoder {
  static String base64Decoder(String encodedTxt) {
    Uint8List uint8list = base64Decode(encodedTxt);
    String text = utf8.decode(uint8list);
    return text;
  }
}