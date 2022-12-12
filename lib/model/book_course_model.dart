class BookCourseModel {
  String? nameUser;
  String? uIdUser;
  String? imageCourse;
  String? nameCourse;
  String? image;
  String? state;
  String? uIdCourse;

  BookCourseModel(
      {this.nameUser,
        this.nameCourse,
        this.state,
        this.imageCourse,
        this.image,
        this.uIdCourse,
        this.uIdUser});

  BookCourseModel.fromJson(Map<String, dynamic> json) {
    uIdUser = json['uIdUser'];
    nameUser = json['nameUser'];
    state = json['state'];
    imageCourse = json['imageCourse'];
    image = json['image'];
    nameCourse = json['nameCourse'];
    uIdCourse = json['uIdCourse'];

  }

  Map<String, dynamic> toMap() {
    return {
      'nameCourse': nameCourse,
      'state': state,
      'imageCourse': imageCourse,
      'nameUser': nameUser,
      'image': image,
      'uIdUser': uIdUser,
      'uIdCourse': uIdCourse,
    };
  }
}
