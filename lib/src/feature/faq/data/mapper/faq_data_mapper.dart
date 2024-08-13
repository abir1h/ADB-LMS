import '../../domain/entities/faq_data_entity.dart';
import '../models/faq_data_model.dart';

abstract class FaqDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _FaqDataModelToEntityMapper
    extends FaqDataMapper<FaqDataModel, FaqDataEntity> {
  @override
  FaqDataModel fromEntityToModel(FaqDataEntity entity) {
    return FaqDataModel(
        id: entity.id, question: entity.question, answer: entity.answer);
  }

  @override
  FaqDataEntity toEntityFromModel(FaqDataModel model) {
    return FaqDataEntity(
        id: model.id, question: model.question, answer: model.answer);
  }
}

extension FaqDataModelExt on FaqDataModel {
  FaqDataEntity get toFaqDataEntity =>
      _FaqDataModelToEntityMapper().toEntityFromModel(this);
}

extension FaqDataEntityExt on FaqDataEntity {
  FaqDataModel get toFaqDataModel =>
      _FaqDataModelToEntityMapper().fromEntityToModel(this);
}
