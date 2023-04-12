class Image_Modal {
  final String Image;

  Image_Modal({required this.Image});

  factory Image_Modal.fromMap({required Map data}) {
    return Image_Modal(Image: data["largeImageURL"]);
  }
}