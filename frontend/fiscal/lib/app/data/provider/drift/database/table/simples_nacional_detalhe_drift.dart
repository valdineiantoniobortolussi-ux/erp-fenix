import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("SimplesNacionalDetalhe")
class SimplesNacionalDetalhes extends Table {
	@override
	String get tableName => 'simples_nacional_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idSimplesNacionalCabecalho => integer().named('id_simples_nacional_cabecalho').nullable()();
	IntColumn get faixa => integer().named('faixa').nullable()();
	RealColumn get valorInicial => real().named('valor_inicial').nullable()();
	RealColumn get valorFinal => real().named('valor_final').nullable()();
	RealColumn get aliquota => real().named('aliquota').nullable()();
	RealColumn get irpj => real().named('irpj').nullable()();
	RealColumn get csll => real().named('csll').nullable()();
	RealColumn get cofins => real().named('cofins').nullable()();
	RealColumn get pisPasep => real().named('pis_pasep').nullable()();
	RealColumn get cpp => real().named('cpp').nullable()();
	RealColumn get icms => real().named('icms').nullable()();
	RealColumn get ipi => real().named('ipi').nullable()();
	RealColumn get iss => real().named('iss').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SimplesNacionalDetalheGrouped {
	SimplesNacionalDetalhe? simplesNacionalDetalhe; 

  SimplesNacionalDetalheGrouped({
		this.simplesNacionalDetalhe, 

  });
}
