import 'package:contratos/app/infra/constants.dart';
import 'package:contratos/app/data/provider/api/contrato_template_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_template_drift_provider.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoTemplateRepository {
  final ContratoTemplateApiProvider contratoTemplateApiProvider;
  final ContratoTemplateDriftProvider contratoTemplateDriftProvider;

  ContratoTemplateRepository({required this.contratoTemplateApiProvider, required this.contratoTemplateDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoTemplateDriftProvider.getList(filter: filter);
    } else {
      return await contratoTemplateApiProvider.getList(filter: filter);
    }
  }

  Future<ContratoTemplateModel?>? save({required ContratoTemplateModel contratoTemplateModel}) async {
    if (contratoTemplateModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contratoTemplateDriftProvider.update(contratoTemplateModel);
      } else {
        return await contratoTemplateApiProvider.update(contratoTemplateModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contratoTemplateDriftProvider.insert(contratoTemplateModel);
      } else {
        return await contratoTemplateApiProvider.insert(contratoTemplateModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contratoTemplateDriftProvider.delete(id) ?? false;
    } else {
      return await contratoTemplateApiProvider.delete(id) ?? false;
    }
  }
}