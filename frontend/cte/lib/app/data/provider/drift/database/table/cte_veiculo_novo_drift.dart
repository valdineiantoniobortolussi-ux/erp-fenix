import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteVeiculoNovo")
class CteVeiculoNovos extends Table {
	@override
	String get tableName => 'cte_veiculo_novo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get chassi => text().named('chassi').withLength(min: 0, max: 17).nullable()();
	TextColumn get cor => text().named('cor').withLength(min: 0, max: 4).nullable()();
	TextColumn get descricaoCor => text().named('descricao_cor').withLength(min: 0, max: 40).nullable()();
	TextColumn get codigoMarcaModelo => text().named('codigo_marca_modelo').withLength(min: 0, max: 6).nullable()();
	RealColumn get valorUnitario => real().named('valor_unitario').nullable()();
	RealColumn get valorFrete => real().named('valor_frete').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteVeiculoNovoGrouped {
	CteVeiculoNovo? cteVeiculoNovo; 

  CteVeiculoNovoGrouped({
		this.cteVeiculoNovo, 

  });
}
