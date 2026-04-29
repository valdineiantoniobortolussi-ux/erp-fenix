import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';

@DataClassName("VendaFrete")
class VendaFretes extends Table {
	@override
	String get tableName => 'venda_frete';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idVendaCabecalho => integer().named('id_venda_cabecalho').nullable()();
	IntColumn get idTransportadora => integer().named('id_transportadora').nullable()();
	TextColumn get responsavel => text().named('responsavel').withLength(min: 0, max: 1).nullable()();
	IntColumn get conhecimento => integer().named('conhecimento').nullable()();
	TextColumn get placa => text().named('placa').withLength(min: 0, max: 7).nullable()();
	TextColumn get ufPlaca => text().named('uf_placa').withLength(min: 0, max: 2).nullable()();
	IntColumn get seloFiscal => integer().named('selo_fiscal').nullable()();
	RealColumn get quantidadeVolume => real().named('quantidade_volume').nullable()();
	TextColumn get marcaVolume => text().named('marca_volume').withLength(min: 0, max: 50).nullable()();
	TextColumn get especieVolume => text().named('especie_volume').withLength(min: 0, max: 20).nullable()();
	RealColumn get pesoBruto => real().named('peso_bruto').nullable()();
	RealColumn get pesoLiquido => real().named('peso_liquido').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendaFreteGrouped {
	VendaFrete? vendaFrete; 
	ViewPessoaTransportadora? viewPessoaTransportadora; 

  VendaFreteGrouped({
		this.vendaFrete, 
		this.viewPessoaTransportadora, 

  });
}
