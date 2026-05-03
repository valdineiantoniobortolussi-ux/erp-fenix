import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDetalheImpostoIpi")
class NfeDetalheImpostoIpis extends Table {
	@override
	String get tableName => 'nfe_detalhe_imposto_ipi';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeDetalhe => integer().named('id_nfe_detalhe').nullable()();
	TextColumn get cnpjProdutor => text().named('cnpj_produtor').withLength(min: 0, max: 14).nullable()();
	TextColumn get codigoSeloIpi => text().named('codigo_selo_ipi').withLength(min: 0, max: 60).nullable()();
	IntColumn get quantidadeSeloIpi => integer().named('quantidade_selo_ipi').nullable()();
	TextColumn get enquadramentoLegalIpi => text().named('enquadramento_legal_ipi').withLength(min: 0, max: 3).nullable()();
	TextColumn get cstIpi => text().named('cst_ipi').withLength(min: 0, max: 2).nullable()();
	RealColumn get valorBaseCalculoIpi => real().named('valor_base_calculo_ipi').nullable()();
	RealColumn get quantidadeUnidadeTributavel => real().named('quantidade_unidade_tributavel').nullable()();
	RealColumn get valorUnidadeTributavel => real().named('valor_unidade_tributavel').nullable()();
	RealColumn get aliquotaIpi => real().named('aliquota_ipi').nullable()();
	RealColumn get valorIpi => real().named('valor_ipi').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDetalheImpostoIpiGrouped {
	NfeDetalheImpostoIpi? nfeDetalheImpostoIpi; 

  NfeDetalheImpostoIpiGrouped({
		this.nfeDetalheImpostoIpi, 

  });
}
