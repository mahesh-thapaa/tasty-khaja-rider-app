class InfoModels {
  final String name;
  final String organization;
  final String address;
  final String phoneNumber;
  final String status;
  final String date;

  InfoModels({
    required this.name,
    required this.organization,
    required this.address,
    required this.phoneNumber,
    this.status = 'New',
    this.date = '7/13/2026',
  });
}
