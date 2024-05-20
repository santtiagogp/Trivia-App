class UrlSetter {
  static String urlSetter(
    int amount,
    int category, 
    String difficulty,
    String type,
    String baseUrl
  ) {

    String url = "$baseUrl&amount=$amount&difficulty=$difficulty";

    if (category >= 9 && category <= 32) {
      url += "&category=$category";
    }

    if (type != "") {
      url += "&type=$type";
    }

    return url;
    
  }
}