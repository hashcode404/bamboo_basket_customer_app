// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddNewUserAddressRequestModel {
  final String? addressTitle;
  final String? firstName;
  final String? lastName;
  final String? line1;
  final String? line2;
  final String? town;
  final String? postcode;
  final String? county;
  final String? landmark;
  AddNewUserAddressRequestModel({
    this.addressTitle,
    this.firstName,
    this.lastName,
    this.line1,
    this.line2,
    this.town,
    this.postcode,
    this.county,
    this.landmark,
  });

  AddNewUserAddressRequestModel copyWith({
    String? addressTitle,
    String? firstName,
    String? lastName,
    String? line1,
    String? line2,
    String? town,
    String? postcode,
    String? county,
    String? landmark,
  }) {
    return AddNewUserAddressRequestModel(
      addressTitle: addressTitle ?? this.addressTitle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      town: town ?? this.town,
      postcode: postcode ?? this.postcode,
      county: county ?? this.county,
      landmark: landmark ?? this.landmark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressTitle': addressTitle,
      'firstName': firstName,
      'lastName': lastName,
      'line1': line1,
      'line2': line2,
      'town': town,
      'postcode': postcode,
      'county': county,
      'landmark': landmark,
    };
  }

  factory AddNewUserAddressRequestModel.fromMap(Map<String, dynamic> map) {
    return AddNewUserAddressRequestModel(
      addressTitle: map['addressTitle'] != null ? map['addressTitle'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      line1: map['line1'] != null ? map['line1'] as String : null,
      line2: map['line2'] != null ? map['line2'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      county: map['county'] != null ? map['county'] as String : null,
      landmark: map['landmark'] != null ? map['landmark'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddNewUserAddressRequestModel.fromJson(String source) => AddNewUserAddressRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddNewUserAddressRequestModel(addressTitle: $addressTitle, firstName: $firstName, lastName: $lastName, line1: $line1, line2: $line2, town: $town, postcode: $postcode, county: $county, landmark: $landmark)';
  }

  @override
  bool operator ==(covariant AddNewUserAddressRequestModel other) {
    if (identical(this, other)) return true;

    return
      other.addressTitle == addressTitle &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.line1 == line1 &&
          other.line2 == line2 &&
          other.town == town &&
          other.postcode == postcode &&
          other.county == county &&
          other.landmark == landmark;
  }

  @override
  int get hashCode {
    return addressTitle.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    line1.hashCode ^
    line2.hashCode ^
    town.hashCode ^
    postcode.hashCode ^
    county.hashCode ^
    landmark.hashCode;
  }
}

