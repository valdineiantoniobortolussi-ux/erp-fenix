import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_lote_dao.g.dart';

@DriftAccessor(tables: [
	ContabilLotes,
])
class ContabilLoteDao extends DatabaseAccessor<AppDatabase> with _$ContabilLoteDaoMixin {
	final AppDatabase db;

	List<ContabilLote> contabilLoteList = []; 
	List<ContabilLoteGrouped> contabilLoteGroupedList = []; 

	ContabilLoteDao(this.db) : super(db);

	Future<List<ContabilLote>> getList() async {
		contabilLoteList = await select(contabilLotes).get();
		return contabilLoteList;
	}

	Future<List<ContabilLote>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilLoteList = await (select(contabilLotes)..where((t) => expression)).get();
		return contabilLoteList;	 
	}

	Future<List<ContabilLoteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilLotes)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilLotes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilLoteGroupedList = await query.map((row) {
			final contabilLote = row.readTableOrNull(contabilLotes); 

			return ContabilLoteGrouped(
				contabilLote: contabilLote, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilLoteGrouped in contabilLoteGroupedList) {
		//}		

		return contabilLoteGroupedList;	
	}

	Future<ContabilLote?> getObject(dynamic pk) async {
		return await (select(contabilLotes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilLote?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_lote WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilLote;		 
	} 

	Future<ContabilLoteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilLoteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilLote = object.contabilLote!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilLotes).insert(object.contabilLote!);
			object.contabilLote = object.contabilLote!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilLoteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilLotes).replace(object.contabilLote!);
		});	 
	} 

	Future<int> deleteObject(ContabilLoteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilLotes).delete(object.contabilLote!);
		});		
	}

	Future<void> insertChildren(ContabilLoteGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilLoteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_lote").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}