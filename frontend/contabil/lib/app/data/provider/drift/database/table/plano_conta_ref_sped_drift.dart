import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("PlanoContaRefSped")
class PlanoContaRefSpeds extends Table {
	@override
	String get tableName => 'plano_conta_ref_sped';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codCtaRef => text().named('cod_cta_ref').withLength(min: 0, max: 30).nullable()();
	DateTimeColumn get inicioValidade => dateTime().named('inicio_validade').nullable()();
	DateTimeColumn get fimValidade => dateTime().named('fim_validade').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();
	TextColumn get orientacoes => text().named('orientacoes').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PlanoContaRefSpedGrouped {
	PlanoContaRefSped? planoContaRefSped; 

  PlanoContaRefSpedGrouped({
		this.planoContaRefSped, 

  });
}
