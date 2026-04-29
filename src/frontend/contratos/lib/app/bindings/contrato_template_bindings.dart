import 'package:get/get.dart';
import 'package:contratos/app/controller/contrato_template_controller.dart';
import 'package:contratos/app/data/provider/api/contrato_template_api_provider.dart';
import 'package:contratos/app/data/provider/drift/contrato_template_drift_provider.dart';
import 'package:contratos/app/data/repository/contrato_template_repository.dart';

class ContratoTemplateBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContratoTemplateController>(() => ContratoTemplateController(
					contratoTemplateRepository:
							ContratoTemplateRepository(contratoTemplateApiProvider: ContratoTemplateApiProvider(), contratoTemplateDriftProvider: ContratoTemplateDriftProvider()))),
		];
	}
}
