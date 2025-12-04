enum PostType {
  image,
  video;

  static PostType translate(String value) {
    switch (value) {
      case 'image':
        return image;
      default:
        return video;
    }
  }

  @override
  toString() {
    switch (this) {
      case image:
        return 'Imagem';
      default:
        return 'Video';
    }
  }
}
