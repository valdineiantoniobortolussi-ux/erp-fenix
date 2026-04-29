import 'package:get/get.dart';
import 'package:cadastros/app/controller/pessoa_controller.dart';
import 'package:cadastros/app/data/provider/api/pessoa_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/pessoa_drift_provider.dart';
import 'package:cadastros/app/data/repository/pessoa_repository.dart';

class PessoaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<PessoaController>(() => PessoaController(
					pessoaRepository:
							PessoaRepository(pessoaApiProvider: PessoaApiProvider(), pessoaDriftProvider: PessoaDriftProvider()))),
		];
	}
}
