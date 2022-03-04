class ListOnboardings {
  final List<Onboarding> onboardings;
  ListOnboardings({
    required this.onboardings,
  });

  factory ListOnboardings.fromJson(List<dynamic> json) => ListOnboardings(
        onboardings: (json as List<dynamic>)
            .map((e) => Onboarding.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(ListOnboardings instance) => <String, dynamic>{
        "onboardings": instance.onboardings.map((e) => e.toJson(e)).toList(),
      };

  @override
  String toString() => 'ListOnboardings { onboardings: $onboardings }';
}

class Onboarding {
  final String title;
  final String subTitle;
  final String description;

  Onboarding({
    required this.title,
    required this.subTitle,
    required this.description,
  });

  factory Onboarding.fromJson(Map<String, dynamic> json) => Onboarding(
        title: json["title"] as String,
        subTitle: json["subtitle"] as String,
        description: json["description"] as String,
      );

  Map<String, dynamic> toJson(Onboarding instance) => <String, dynamic>{
        "title": instance.title,
        "subTitle": instance.subTitle,
        "description": instance.description,
      };

  @override
  String toString() =>
      'Onboarding { title: $title, subTitle: $subTitle, description: $description }';
}
