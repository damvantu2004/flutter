class UserProfile {
  String id;
  String? name;
  String? email;
  String? avatarPath;
  List<String>? favories;
  List<String>? carts;
  UserProfile({this.id = "", this.name = "", this.email = "", this.avatarPath = null, this.favories = null, this.carts = null});
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "avatar": avatarPath
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> data, String id) {
    return UserProfile(
      id: id,
      name: data['name'],
      email: data['email'],
      avatarPath: data['avatar'],
      favories: List<String>.from(data["favories"] ?? []),
      carts: List<String>.from(data["carts"] ?? []),
    );
  }

  bool checkFavories(String idProduct) {
    for (int i = 0; i < (favories ?? []).length; i++) {
      if (favories![i] == idProduct) return true;
    }
    return false;
  }

  bool checkCart(String idProduct) {
    for (int i = 0; i < (carts ?? []).length; i++) {
      if (carts![i] == idProduct) return true;
    }
    return false;
  }
}
