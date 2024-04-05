
import '../model/organization_model.dart';

class AllOrginazationRepository {
  final Map<String, OrganizationStructureModel> _organization = {};
  Map<String, OrganizationStructureModel> get getOrganizationStructure => _organization;

  addAll(Map<String, OrganizationStructureModel> other) {
    _organization.addAll(other);
  }

}
