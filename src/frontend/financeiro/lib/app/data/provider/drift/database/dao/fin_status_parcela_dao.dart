import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_status_parcela_dao.g.dart';

@DriftAccessor(tables: [
	FinStatusParcelas,
])
class FinStatusParcelaDao extends DatabaseAccessor<AppDatabase> with _$FinStatusParcelaDaoMixin {
	final AppDatabase db;

	List<FinStatusParcela> finStatusParcelaList = []; 
	List<FinStatusParcelaGrouped> finStatusParcelaGroupedList = []; 

	FinStatusParcelaDao(this.db) : super(db);

	Future<List<FinStatusParcela>> getList() async {
		finStatusParcelaList = await select(finStatusParcelas).get();
		return finStatusParcelaList;
	}

	Future<List<FinStatusParcela>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finStatusParcelaList = await (select(finStatusParcelas)..where((t) => expression)).get();
		return finStatusParcelaList;	 
	}

	Future<List<FinStatusParcelaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finStatusParcelas)
			.join([]);

		if (field != null && field != '') { 
			final column = finStatusParcelas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finStatusParcelaGroupedList = await query.map((row) {
			final finStatusParcela = row.readTableOrNull(finStatusParcelas); 

			return FinStatusParcelaGrouped(
				finStatusParcela: finStatusParcela, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finStatusParcelaGrouped in finStatusParcelaGroupedList) {
		//}		

		return finStatusParcelaGroupedList;	
	}

	Future<FinStatusParcela?> getObject(dynamic pk) async {
		return await (select(finStatusParcelas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinStatusParcela?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_status_parcela WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinStatusParcela;		 
	} 

	Future<FinStatusParcelaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinStatusParcelaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finStatusParcela = object.finStatusParcela!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finStatusParcelas).insert(object.finStatusParcela!);
			object.finStatusParcela = object.finStatusParcela!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinStatusParcelaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finStatusParcelas).replace(object.finStatusParcela!);
		});	 
	} 

	Future<int> deleteObject(FinStatusParcelaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finStatusParcelas).delete(object.finStatusParcela!);
		});		
	}

	Future<void> insertChildren(FinStatusParcelaGrouped object) async {
	}
	
	Future<void> deleteChildren(FinStatusParcelaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_status_parcela").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}