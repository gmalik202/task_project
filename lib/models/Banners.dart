class Banners{
  final String Banner3;
  Banners({
    this.Banner3
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      Banner3: json["Banner3"]
    );
  }
}