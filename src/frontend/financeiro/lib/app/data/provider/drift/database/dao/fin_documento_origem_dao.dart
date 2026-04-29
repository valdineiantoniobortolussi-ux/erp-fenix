import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_documento_origem_dao.g.dart';

@DriftAccessor(tables: [
	FinDocumentoOrigems,
])
class FinDocumentoOrigemDao extends DatabaseAccessor<AppDatabase> with _$FinDocumentoOrigemDaoMixin {
	final AppDatabase db;

	List<FinDocumentoOrigem> finDocumentoOrigemList = []; 
	List<FinDocumentoOrigemGrouped> finDocumentoOrigemGroupedList = []; 

	FinDocumentoOrigemDao(this.db) : super(db);

	Future<List<FinDocumentoOrigem>> getList() async {
		finDocumentoOrigemList = await select(finDocumentoOrigems).get();
		return finDocumentoOrigemList;
	}

	Future<List<FinDocumentoOrigem>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finDocumentoOrigemList = await (select(finDocumentoOrigems)..where((t) => expression)).get();
		return finDocumentoOrigemList;	 
	}

	Future<List<FinDocumentoOrigemGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finDocumentoOrigems)
			.join([]);

		if (field != null && field != '') { 
			final column = finDocumentoOrigems.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finDocumentoOrigemGroupedList = await query.map((row) {
			final finDocumentoOrigem = row.readTableOrNull(finDocumentoOrigems); 

			return FinDocumentoOrigemGrouped(
				finDocumentoOrigem: finDocumentoOrigem, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finDocumentoOrigemGrouped in finDocumentoOrigemGroupedList) {
		//}		

		return finDocumentoOrigemGroupedList;	
	}

	Future<FinDocumentoOrigem?> getObject(dynamic pk) async {
		return await (select(finDocumentoOrigems)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinDocumentoOrigem?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_documento_origem WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinDocumentoOrigem;		 
	} 

	Future<FinDocumentoOrigemGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinDocumentoOrigemGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finDocumentoOrigem = object.finDocumentoOrigem!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finDocumentoOrigems).insert(object.finDocumentoOrigem!);
			object.finDocumentoOrigem = object.finDocumentoOrigem!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinDocumentoOrigemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finDocumentoOrigems).replace(object.finDocumentoOrigem!);
		});	 
	} 

	Future<int> deleteObject(FinDocumentoOrigemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finDocumentoOrigems).delete(object.finDocumentoOrigem!);
		});		
	}

	Future<void> insertChildren(FinDocumentoOrigemGrouped object) async {
	}
	
	Future<void> deleteChildren(FinDocumentoOrigemGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_documento_origem").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}