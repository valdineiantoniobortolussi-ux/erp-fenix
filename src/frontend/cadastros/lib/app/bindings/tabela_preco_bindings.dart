import 'package:get/get.dart';
import 'package:cadastros/app/controller/tabela_preco_controller.dart';
import 'package:cadastros/app/data/provider/api/tabela_preco_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/tabela_preco_drift_provider.dart';
import 'package:cadastros/app/data/repository/tabela_preco_repository.dart';

class TabelaPrecoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TabelaPrecoController>(() => TabelaPrecoController(
					tabelaPrecoRepository:
							TabelaPrecoRepository(tabelaPrecoApiProvider: TabelaPrecoApiProvider(), tabelaPrecoDriftProvider: TabelaPrecoDriftProvider()))),
		];
	}
}
