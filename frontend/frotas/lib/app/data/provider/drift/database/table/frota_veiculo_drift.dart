import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FrotaVeiculo")
class FrotaVeiculos extends Table {
	@override
	String get tableName => 'frota_veiculo';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFrotaVeiculoTipo => integer().named('id_frota_veiculo_tipo').nullable()();
	IntColumn get idFrotaCombustivelTipo => integer().named('id_frota_combustivel_tipo').nullable()();
	TextColumn get marca => text().named('marca').withLength(min: 0, max: 100).nullable()();
	TextColumn get modelo => text().named('modelo').withLength(min: 0, max: 100).nullable()();
	TextColumn get modeloAno => text().named('modelo_ano').withLength(min: 0, max: 4).nullable()();
	TextColumn get placa => text().named('placa').withLength(min: 0, max: 7).nullable()();
	TextColumn get codigoFipe => text().named('codigo_fipe').withLength(min: 0, max: 7).nullable()();
	TextColumn get renavam => text().named('renavam').withLength(min: 0, max: 11).nullable()();
	TextColumn get ipvaMesVencimento => text().named('ipva_mes_vencimento').withLength(min: 0, max: 2).nullable()();
	TextColumn get dpvatMesVencimento => text().named('dpvat_mes_vencimento').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaVeiculoGrouped {
	FrotaVeiculo? frotaVeiculo; 
	List<FrotaIpvaControleGrouped>? frotaIpvaControleGroupedList; 
	List<FrotaDpvatControleGrouped>? frotaDpvatControleGroupedList; 
	List<FrotaVeiculoSinistroGrouped>? frotaVeiculoSinistroGroupedList; 
	List<FrotaVeiculoMovimentacaoGrouped>? frotaVeiculoMovimentacaoGroupedList; 
	List<FrotaVeiculoPneuGrouped>? frotaVeiculoPneuGroupedList; 
	List<FrotaVeiculoManutencaoGrouped>? frotaVeiculoManutencaoGroupedList; 
	List<FrotaMultaControleGrouped>? frotaMultaControleGroupedList; 
	List<FrotaCombustivelControleGrouped>? frotaCombustivelControleGroupedList; 
	FrotaVeiculoTipo? frotaVeiculoTipo; 
	FrotaCombustivelTipo? frotaCombustivelTipo; 

  FrotaVeiculoGrouped({
		this.frotaVeiculo, 
		this.frotaIpvaControleGroupedList, 
		this.frotaDpvatControleGroupedList, 
		this.frotaVeiculoSinistroGroupedList, 
		this.frotaVeiculoMovimentacaoGroupedList, 
		this.frotaVeiculoPneuGroupedList, 
		this.frotaVeiculoManutencaoGroupedList, 
		this.frotaMultaControleGroupedList, 
		this.frotaCombustivelControleGroupedList, 
		this.frotaVeiculoTipo, 
		this.frotaCombustivelTipo, 

  });
}
