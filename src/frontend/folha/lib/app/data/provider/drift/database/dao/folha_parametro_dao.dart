import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_parametro_dao.g.dart';

@DriftAccessor(tables: [
	FolhaParametros,
])
class FolhaParametroDao extends DatabaseAccessor<AppDatabase> with _$FolhaParametroDaoMixin {
	final AppDatabase db;

	List<FolhaParametro> folhaParametroList = []; 
	List<FolhaParametroGrouped> folhaParametroGroupedList = []; 

	FolhaParametroDao(this.db) : super(db);

	Future<List<FolhaParametro>> getList() async {
		folhaParametroList = await select(folhaParametros).get();
		return folhaParametroList;
	}

	Future<List<FolhaParametro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaParametroList = await (select(folhaParametros)..where((t) => expression)).get();
		return folhaParametroList;	 
	}

	Future<List<FolhaParametroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaParametros)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaParametros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaParametroGroupedList = await query.map((row) {
			final folhaParametro = row.readTableOrNull(folhaParametros); 

			return FolhaParametroGrouped(
				folhaParametro: folhaParametro, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaParametroGrouped in folhaParametroGroupedList) {
		//}		

		return folhaParametroGroupedList;	
	}

	Future<FolhaParametro?> getObject(dynamic pk) async {
		return await (select(folhaParametros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaParametro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_parametro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaParametro;		 
	} 

	Future<FolhaParametroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaParametroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaParametro = object.folhaParametro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaParametros).insert(object.folhaParametro!);
			object.folhaParametro = object.folhaParametro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaParametros).replace(object.folhaParametro!);
		});	 
	} 

	Future<int> deleteObject(FolhaParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaParametros).delete(object.folhaParametro!);
		});		
	}

	Future<void> insertChildren(FolhaParametroGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaParametroGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_parametro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}