class CommonDropDownType {
  final String type;
  final String en;
  final String ne;

  final String? id;

  const CommonDropDownType({
    this.id,
    required this.type,
    required this.en,
    required this.ne,
  });

  factory CommonDropDownType.all() {
    return const CommonDropDownType(
      type: "",
      en: "All",
      ne: "सबै",
    );
  }

  factory CommonDropDownType.liveStock() {
    return const CommonDropDownType(
      type: "LIVESTOCK",
      en: "Livestock",
      ne: "पशु",
    );
  }

  factory CommonDropDownType.crop() {
    return const CommonDropDownType(
      type: "CROP",
      en: "Agriculture",
      ne: "कृषि",
    );
  }

  // account delete options

  factory CommonDropDownType.noLongerNeedTheService() {
    return const CommonDropDownType(
      type: 'No longer need the service',
      en: 'No longer need the service',
      ne: 'अब सेवा चाहिन्न',
    );
  }
  factory CommonDropDownType.imNotSatisfiedWithTheService() {
    return const CommonDropDownType(
      type: 'I am not satisfied with the service',
      en: 'I am not satisfied with the service',
      ne: 'म सेवाबाट सन्तुष्ट छैन',
    );
  }
  factory CommonDropDownType.imNotSatisfiedWithTheProduct() {
    return const CommonDropDownType(
      type: 'I am not satisfied with the Product',
      en: 'I am not satisfied with the Product',
      ne: 'म उत्पादनबाट सन्तुष्ट छैन',
    );
  }
  factory CommonDropDownType.imNotSatisfiedWithTheUserExperience() {
    return const CommonDropDownType(
      type: 'I am not satisfied with the user experience',
      en: 'I am not satisfied with the user experience',
      ne: 'म उपयोगकर्ता अनुभवबाट सन्तुष्ट छैन',
    );
  }
  factory CommonDropDownType.others() {
    return const CommonDropDownType(
      type: 'Others',
      en: 'Others',
      ne: 'अन्य',
    );
  }
}
