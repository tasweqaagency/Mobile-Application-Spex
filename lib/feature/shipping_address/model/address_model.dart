class AddressModel {
  final String id;
  final String title;
  final String fullName;
  final String streetAddress;
  final String buildingApt;
  final String city;
  final String phoneNumber;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.fullName,
    required this.streetAddress,
    required this.buildingApt,
    required this.city,
    required this.phoneNumber,
    this.isDefault = false,
  });

  AddressModel copyWith({
    String? id,
    String? title,
    String? fullName,
    String? streetAddress,
    String? buildingApt,
    String? city,
    String? phoneNumber,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      fullName: fullName ?? this.fullName,
      streetAddress: streetAddress ?? this.streetAddress,
      buildingApt: buildingApt ?? this.buildingApt,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
