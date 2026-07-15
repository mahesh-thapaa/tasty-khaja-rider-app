class InfoModels {
  final String? id;
  final String clientName;
  final String? organization;
  final String address;
  final String phoneNumber;
  final String? rider;
  final String? riderName;
  final String status;
  final String? createdAt;

  InfoModels({
    this.id,
    required this.clientName,
    this.organization,
    required this.address,
    required this.phoneNumber,
    this.rider,
    this.riderName,
    this.status = 'New',
    this.createdAt,
  });

  factory InfoModels.fromJson(Map<String, dynamic> json) {
    return InfoModels(
      id: json['_id'] as String?,
      clientName: json['clientName'] as String? ?? '',
      organization: json['organization'] as String?,
      address: json['address'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      rider: json['rider'] as String?,
      riderName: json['riderName'] as String?,
      status: json['status'] as String? ?? 'New',
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'organization': organization,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }
}
