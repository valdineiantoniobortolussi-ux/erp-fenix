import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_grade_controller.dart';
import 'package:estoque/app/data/provider/api/estoque_grade_api_provider.dart';
import 'package:estoque/app/data/provider/drift/estoque_grade_drift_provider.dart';
import 'package:estoque/app/data/repository/estoque_grade_repository.dart';

class EstoqueGradeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<EstoqueGradeController>(() => EstoqueGradeController(
					estoqueGradeRepository:
							EstoqueGradeRepository(estoqueGradeApiProvider: EstoqueGradeApiProvider(), estoqueGradeDriftProvider: EstoqueGradeDriftProvider()))),
		];
	}
}
