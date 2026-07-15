import 'package:flutter/material.dart';
import 'package:rider/models/leeds_models/info_models.dart';

class LeadFormController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final organizationController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  InfoModels? submit() {
    if (!formKey.currentState!.validate()) return null;

    return InfoModels(
      clientName: nameController.text.trim(),
      organization: organizationController.text.trim(),
      address: addressController.text.trim(),
      phoneNumber: phoneController.text.trim(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    organizationController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
