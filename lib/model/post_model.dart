class Post {
  String? name;
  String? content;
  String? img_url;

  Post({this.name, this.content, this.img_url});

  Post.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        content = json['content'],
        img_url = json['img_url'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'content': content, 'img_url': img_url};
}
