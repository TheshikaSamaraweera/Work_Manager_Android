class UnboardingContent{
  String image;
  String title;
  String description;
  UnboardingContent(
  {
    required this.description,required this.image, required this.title});
}
List<UnboardingContent> contents=[
  UnboardingContent(description: 'pic your food from menue\n  more than 35 times',
      image: "images/screen1.png",
      title: 'Select from out\n  Best menu'),

  UnboardingContent(description: 'you can pay cash or\n  e money',
      image: "images/screen2.png",
      title: 'easy and online payment'),

  UnboardingContent(description: 'deliver your food\n  non stop',
      image: "images/screen3.png",
      title: 'quick delivery'),
];