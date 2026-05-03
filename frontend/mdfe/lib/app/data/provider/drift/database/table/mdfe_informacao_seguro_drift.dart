import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeInformacaoSeguro")
class MdfeInformacaoSeguros extends Table {
	@override
	String get tableName => 'mdfe_informacao_seguro';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeCabecalho => integer().named('id_mdfe_cabecalho').nullable()();
	IntColumn get responsavel => integer().named('responsavel').nullable()();
	TextColumn get cnpjCpf => text().named('cnpj_cpf').withLength(min: 0, max: 14).nullable()();
	TextColumn get seguradora => text().named('seguradora').withLength(min: 0, max: 11).nullable()();
	TextColumn get cnpjSeguradora => text().named('cnpj_seguradora').withLength(min: 0, max: 14).nullable()();
	TextColumn get apolice => text().named('apolice').withLength(min: 0, max: 20).nullable()();
	TextColumn get averbacao => text().named('averbacao').withLength(min: 0, max: 40).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeInformacaoSeguroGrouped {
	MdfeInformacaoSeguro? mdfeInformacaoSeguro; 

  MdfeInformacaoSeguroGrouped({
		this.mdfeInformacaoSeguro, 

  });
}
