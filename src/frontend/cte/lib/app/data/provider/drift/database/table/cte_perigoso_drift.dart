import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CtePerigoso")
class CtePerigosos extends Table {
	@override
	String get tableName => 'cte_perigoso';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get numeroOnu => text().named('numero_onu').withLength(min: 0, max: 4).nullable()();
	TextColumn get nomeApropriado => text().named('nome_apropriado').withLength(min: 0, max: 150).nullable()();
	TextColumn get classeRisco => text().named('classe_risco').withLength(min: 0, max: 40).nullable()();
	TextColumn get grupoEmbalagem => text().named('grupo_embalagem').withLength(min: 0, max: 6).nullable()();
	TextColumn get quantidadeTotalProduto => text().named('quantidade_total_produto').withLength(min: 0, max: 20).nullable()();
	TextColumn get quantidadeTipoVolume => text().named('quantidade_tipo_volume').withLength(min: 0, max: 60).nullable()();
	TextColumn get pontoFulgor => text().named('ponto_fulgor').withLength(min: 0, max: 6).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CtePerigosoGrouped {
	CtePerigoso? ctePerigoso; 

  CtePerigosoGrouped({
		this.ctePerigoso, 

  });
}
