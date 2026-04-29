import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("TributOperacaoFiscal")
class TributOperacaoFiscals extends Table {
	@override
	String get tableName => 'tribut_operacao_fiscal';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricaoNaNf => text().named('descricao_na_nf').withLength(min: 0, max: 100).nullable()();
	IntColumn get cfop => integer().named('cfop').nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributOperacaoFiscalGrouped {
	TributOperacaoFiscal? tributOperacaoFiscal; 

  TributOperacaoFiscalGrouped({
		this.tributOperacaoFiscal, 

  });
}
