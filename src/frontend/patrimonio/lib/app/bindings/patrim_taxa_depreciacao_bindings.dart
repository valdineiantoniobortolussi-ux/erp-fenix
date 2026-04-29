import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_taxa_depreciacao_controller.dart';
import 'package:patrimonio/app/data/provider/api/patrim_taxa_depreciacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_taxa_depreciacao_drift_provider.dart';
import 'package:patrimonio/app/data/repository/patrim_taxa_depreciacao_repository.dart';

class PatrimTaxaDepreciacaoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PatrimTaxaDepreciacaoController>(() => PatrimTaxaDepreciacaoController(
					patrimTaxaDepreciacaoRepository:
							PatrimTaxaDepreciacaoRepository(patrimTaxaDepreciacaoApiProvider: PatrimTaxaDepreciacaoApiProvider(), patrimTaxaDepreciacaoDriftProvider: PatrimTaxaDepreciacaoDriftProvider()))),
		];
	}
}
