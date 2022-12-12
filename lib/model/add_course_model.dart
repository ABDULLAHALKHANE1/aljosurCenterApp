class AddCourseModel {
  String? nameCourse;
  String? description;
  String? countSession;
  String? countHours;
  String? dateCourse;
  String? linkCourseZoom;
  String? image;
  String? state;
  String? priceCourse;

  AddCourseModel(
      {this.nameCourse,
        this.countSession,
        this.countHours,
        this.linkCourseZoom,
        this.dateCourse,
        this.image,
        this.state,
        this.priceCourse,
        this.description});

  AddCourseModel.fromJson(Map<String, dynamic> json) {

    nameCourse = json['nameCourse'];
    description = json['description'];
    countSession = json['countSession'];
    linkCourseZoom = json['linkCourseZoom'];
    dateCourse = json['dateCourse'];
    countHours=json['countHours'];
    priceCourse=json['priceCourse'];
    image = json['image'];
    state = json['state'];

  }

  Map<String, dynamic> toMap() {
    return {
      'nameCourse': nameCourse,
      'description': description,
      'linkCourseZoom':linkCourseZoom,
      'countSession': countSession,
      'countHours': countHours,
      'dateCourse': dateCourse,
      'priceCourse': priceCourse,
      'image': image,
      'state': state,
    };
  }
}
