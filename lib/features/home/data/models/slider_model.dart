class SliderModel {
  String? id;
  String? sliderName;
  String? sliderImage;
  String? sliderUrl;

  SliderModel({
    this.id,
    this.sliderName,
    this.sliderImage,
    this.sliderUrl,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sliderName = json['sliderName'];
    sliderImage = json['sliderImage'];
    sliderUrl = json['sliderUrl'];
  }
}
