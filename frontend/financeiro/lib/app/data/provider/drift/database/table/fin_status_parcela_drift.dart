import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinStatusParcela")
class FinStatusParcelas extends Table {
	@override
	String get tableName => 'fin_status_parcela';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 30).nullable()();
	TextColumn get procedimento => text().named('procedimento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinStatusParcelaGrouped {
	FinStatusParcela? finStatusParcela; 

  FinStatusParcelaGrouped({
		this.finStatusParcela, 

  });
}
