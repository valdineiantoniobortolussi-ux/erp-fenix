import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_tipo_pagamento_dao.g.dart';

@DriftAccessor(tables: [
	FinTipoPagamentos,
])
class FinTipoPagamentoDao extends DatabaseAccessor<AppDatabase> with _$FinTipoPagamentoDaoMixin {
	final AppDatabase db;

	List<FinTipoPagamento> finTipoPagamentoList = []; 
	List<FinTipoPagamentoGrouped> finTipoPagamentoGroupedList = []; 

	FinTipoPagamentoDao(this.db) : super(db);

	Future<List<FinTipoPagamento>> getList() async {
		finTipoPagamentoList = await select(finTipoPagamentos).get();
		return finTipoPagamentoList;
	}

	Future<List<FinTipoPagamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finTipoPagamentoList = await (select(finTipoPagamentos)..where((t) => expression)).get();
		return finTipoPagamentoList;	 
	}

	Future<List<FinTipoPagamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finTipoPagamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = finTipoPagamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finTipoPagamentoGroupedList = await query.map((row) {
			final finTipoPagamento = row.readTableOrNull(finTipoPagamentos); 

			return FinTipoPagamentoGrouped(
				finTipoPagamento: finTipoPagamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finTipoPagamentoGrouped in finTipoPagamentoGroupedList) {
		//}		

		return finTipoPagamentoGroupedList;	
	}

	Future<FinTipoPagamento?> getObject(dynamic pk) async {
		return await (select(finTipoPagamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinTipoPagamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_tipo_pagamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinTipoPagamento;		 
	} 

	Future<FinTipoPagamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinTipoPagamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finTipoPagamento = object.finTipoPagamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finTipoPagamentos).insert(object.finTipoPagamento!);
			object.finTipoPagamento = object.finTipoPagamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinTipoPagamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finTipoPagamentos).replace(object.finTipoPagamento!);
		});	 
	} 

	Future<int> deleteObject(FinTipoPagamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finTipoPagamentos).delete(object.finTipoPagamento!);
		});		
	}

	Future<void> insertChildren(FinTipoPagamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinTipoPagamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_tipo_pagamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}