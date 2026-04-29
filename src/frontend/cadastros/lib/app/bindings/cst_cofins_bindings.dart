import 'package:get/get.dart';
import 'package:cadastros/app/controller/cst_cofins_controller.dart';
import 'package:cadastros/app/data/provider/api/cst_cofins_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/cst_cofins_drift_provider.dart';
import 'package:cadastros/app/data/repository/cst_cofins_repository.dart';

class CstCofinsBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<CstCofinsController>(() => CstCofinsController(
					cstCofinsRepository:
							CstCofinsRepository(cstCofinsApiProvider: CstCofinsApiProvider(), cstCofinsDriftProvider: CstCofinsDriftProvider()))),
		];
	}
}
