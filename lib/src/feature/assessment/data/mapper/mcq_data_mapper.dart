import '../../domain/entities/mcq_data_entity.dart';
import '../models/mcq_data_model.dart';

abstract class McqDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _McqDataModelToEntityMapper
    extends McqDataMapper<McqDataModel, McqDataEntity> {
  @override
  McqDataModel fromEntityToModel(McqDataEntity entity) {
    return McqDataModel(
        type: entity.type,
        id: entity.id,
        question: entity.question,
        option1: entity.option1,
        option2: entity.option2,
        option3: entity.option3,
        option4: entity.option4,
        mark: entity.mark,
        isOption1Selected: entity.isOption1Selected,
        isOption2Selected: entity.isOption2Selected,
        isOption3Selected: entity.isOption3Selected,
        isOption4Selected: entity.isOption4Selected);
  }

  @override
  McqDataEntity toEntityFromModel(McqDataModel model) {
    return McqDataEntity(
        type: model.type,
        id: model.id,
        question: model.question,
        option1: model.option1,
        option2: model.option2,
        option3: model.option3,
        option4: model.option4,
        mark: model.mark,
        isOption1Selected: model.isOption1Selected,
        isOption2Selected: model.isOption2Selected,
        isOption3Selected: model.isOption3Selected,
        isOption4Selected: model.isOption4Selected);
  }
}

extension McqDataModelExt on McqDataModel {
  McqDataEntity get toMcqDataEntity =>
      _McqDataModelToEntityMapper().toEntityFromModel(this);
}

extension McqDataEntityExt on McqDataEntity {
  McqDataModel get toMcqDataModel =>
      _McqDataModelToEntityMapper().fromEntityToModel(this);
}
