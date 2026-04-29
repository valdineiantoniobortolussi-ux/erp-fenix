import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeItemRastreado")
class NfeItemRastreados extends Table {
	@override
	String get tableName => 'nfe_item_rastreado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get numeroLote => text().named('numero_lote').withLength(min: 0, max: 20).nullable()();
	RealColumn get quantidadeItens => real().named('quantidade_itens').nullable()();
	DateTimeColumn get dataFabricacao => dateTime().named('data_fabricacao').nullable()();
	DateTimeColumn get dataValidade => dateTime().named('data_validade').nullable()();
	TextColumn get codigoAgregacao => text().named('codigo_agregacao').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeItemRastreadoGrouped {
	NfeItemRastreado? nfeItemRastreado; 

  NfeItemRastreadoGrouped({
		this.nfeItemRastreado, 

  });
}
