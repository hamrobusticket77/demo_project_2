import 'package:krishi_hub/feature/project/model/seed_category_model.dart';
import 'package:krishi_hub/feature/project/model/sub_category_model.dart';

class DemandDetailsParamModel {
  final SeedCategoryModel seedCategory;
  final SubCategoryModel seed;
  final int demandQuantity;
  DemandDetailsParamModel({
    required this.seedCategory,
    required this.seed,
    required this.demandQuantity,
  });

  DemandDetailsParamModel copyWith({
    SeedCategoryModel? seedCategory,
    SubCategoryModel? seed,
    int? demandQuantity,
  }) {
    return DemandDetailsParamModel(
      seedCategory: seedCategory ?? this.seedCategory,
      seed: seed ?? this.seed,
      demandQuantity: demandQuantity ?? this.demandQuantity,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'seedCategory': seedCategory.toMap(),
      'seed': seed.toMap(),
      'quantity': demandQuantity,
    };
  }

  Map<String, dynamic> toJsonForPost() {
    return <String, dynamic>{
      'seedCategory': seedCategory.id,
      'seed': seed.id,
      'quantity': demandQuantity,
    };
  }

  factory DemandDetailsParamModel.fromJson(Map<String, dynamic> map) {
    return DemandDetailsParamModel(
      seedCategory: SeedCategoryModel.fromMap(map['seedCategory'] ?? {}),
      seed: SubCategoryModel.fromMap(map['seed'] ?? {}),
      demandQuantity: map['quantity'] ?? 0,
    );
  }

  @override
  bool operator ==(covariant DemandDetailsParamModel other) {
    if (identical(this, other)) return true;

    return other.seedCategory == seedCategory &&
        other.seed == seed &&
        other.demandQuantity == demandQuantity;
  }

  @override
  int get hashCode =>
      seedCategory.hashCode ^ seed.hashCode ^ demandQuantity.hashCode;
}
