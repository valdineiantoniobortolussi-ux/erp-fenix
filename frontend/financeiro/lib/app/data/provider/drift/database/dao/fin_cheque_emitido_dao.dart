import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_cheque_emitido_dao.g.dart';

@DriftAccessor(tables: [
	FinChequeEmitidos,
	Cheques,
])
class FinChequeEmitidoDao extends DatabaseAccessor<AppDatabase> with _$FinChequeEmitidoDaoMixin {
	final AppDatabase db;

	List<FinChequeEmitido> finChequeEmitidoList = []; 
	List<FinChequeEmitidoGrouped> finChequeEmitidoGroupedList = []; 

	FinChequeEmitidoDao(this.db) : super(db);

	Future<List<FinChequeEmitido>> getList() async {
		finChequeEmitidoList = await select(finChequeEmitidos).get();
		return finChequeEmitidoList;
	}

	Future<List<FinChequeEmitido>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finChequeEmitidoList = await (select(finChequeEmitidos)..where((t) => expression)).get();
		return finChequeEmitidoList;	 
	}

	Future<List<FinChequeEmitidoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finChequeEmitidos)
			.join([ 
				leftOuterJoin(cheques, cheques.id.equalsExp(finChequeEmitidos.idCheque)), 
			]);

		if (field != null && field != '') { 
			final column = finChequeEmitidos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finChequeEmitidoGroupedList = await query.map((row) {
			final finChequeEmitido = row.readTableOrNull(finChequeEmitidos); 
			final cheque = row.readTableOrNull(cheques); 

			return FinChequeEmitidoGrouped(
				finChequeEmitido: finChequeEmitido, 
				cheque: cheque, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finChequeEmitidoGrouped in finChequeEmitidoGroupedList) {
		//}		

		return finChequeEmitidoGroupedList;	
	}

	Future<FinChequeEmitido?> getObject(dynamic pk) async {
		return await (select(finChequeEmitidos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinChequeEmitido?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_cheque_emitido WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinChequeEmitido;		 
	} 

	Future<FinChequeEmitidoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinChequeEmitidoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finChequeEmitido = object.finChequeEmitido!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finChequeEmitidos).insert(object.finChequeEmitido!);
			object.finChequeEmitido = object.finChequeEmitido!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinChequeEmitidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finChequeEmitidos).replace(object.finChequeEmitido!);
		});	 
	} 

	Future<int> deleteObject(FinChequeEmitidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finChequeEmitidos).delete(object.finChequeEmitido!);
		});		
	}

	Future<void> insertChildren(FinChequeEmitidoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinChequeEmitidoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_cheque_emitido").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}