import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilDreDetalhe")
class ContabilDreDetalhes extends Table {
	@override
	String get tableName => 'contabil_dre_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilDreCabecalho => integer().named('id_contabil_dre_cabecalho').nullable()();
	TextColumn get classificacao => text().named('classificacao').withLength(min: 0, max: 30).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get formaCalculo => text().named('forma_calculo').withLength(min: 0, max: 1).nullable()();
	TextColumn get sinal => text().named('sinal').withLength(min: 0, max: 1).nullable()();
	TextColumn get natureza => text().named('natureza').withLength(min: 0, max: 1).nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilDreDetalheGrouped {
	ContabilDreDetalhe? contabilDreDetalhe; 

  ContabilDreDetalheGrouped({
		this.contabilDreDetalhe, 

  });
}
