import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaValeTransporte")
class FolhaValeTransportes extends Table {
	@override
	String get tableName => 'folha_vale_transporte';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idEmpresaTranspItin => integer().named('id_empresa_transp_itin').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaValeTransporteGrouped {
	FolhaValeTransporte? folhaValeTransporte; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	EmpresaTransporteItinerario? empresaTransporteItinerario; 

  FolhaValeTransporteGrouped({
		this.folhaValeTransporte, 
		this.viewPessoaColaborador, 
		this.empresaTransporteItinerario, 

  });
}
