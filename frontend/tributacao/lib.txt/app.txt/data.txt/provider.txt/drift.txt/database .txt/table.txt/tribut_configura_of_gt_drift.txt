import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';

@DataClassName("TributConfiguraOfGt")
class TributConfiguraOfGts extends Table {
	@override
	String get tableName => 'tribut_configura_of_gt';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idTributGrupoTributario => integer().named('id_tribut_grupo_tributario').nullable()();
	IntColumn get idTributOperacaoFiscal => integer().named('id_tribut_operacao_fiscal').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributConfiguraOfGtGrouped {
	TributConfiguraOfGt? tributConfiguraOfGt; 
	TributIpi? tributIpi; 
	TributCofins? tributCofins; 
	TributPis? tributPis; 
	TributGrupoTributario? tributGrupoTributario; 
	TributOperacaoFiscal? tributOperacaoFiscal; 
	List<TributIcmsUfGrouped>? tributIcmsUfGroupedList; 

  TributConfiguraOfGtGrouped({
		this.tributConfiguraOfGt, 
		this.tributIpi, 
		this.tributCofins, 
		this.tributPis, 
		this.tributGrupoTributario, 
		this.tributOperacaoFiscal, 
		this.tributIcmsUfGroupedList, 

  });
}
