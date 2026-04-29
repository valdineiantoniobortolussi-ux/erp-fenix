import 'package:get/get.dart';
import 'package:financeiro/app/controller/talonario_cheque_controller.dart';
import 'package:financeiro/app/data/provider/api/talonario_cheque_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/talonario_cheque_drift_provider.dart';
import 'package:financeiro/app/data/repository/talonario_cheque_repository.dart';

class TalonarioChequeBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<TalonarioChequeController>(() => TalonarioChequeController(
					talonarioChequeRepository:
							TalonarioChequeRepository(talonarioChequeApiProvider: TalonarioChequeApiProvider(), talonarioChequeDriftProvider: TalonarioChequeDriftProvider()))),
		];
	}
}
