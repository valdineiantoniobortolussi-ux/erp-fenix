import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_parametro_dao.g.dart';

@DriftAccessor(tables: [
	ContabilParametros,
])
class ContabilParametroDao extends DatabaseAccessor<AppDatabase> with _$ContabilParametroDaoMixin {
	final AppDatabase db;

	List<ContabilParametro> contabilParametroList = []; 
	List<ContabilParametroGrouped> contabilParametroGroupedList = []; 

	ContabilParametroDao(this.db) : super(db);

	Future<List<ContabilParametro>> getList() async {
		contabilParametroList = await select(contabilParametros).get();
		return contabilParametroList;
	}

	Future<List<ContabilParametro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilParametroList = await (select(contabilParametros)..where((t) => expression)).get();
		return contabilParametroList;	 
	}

	Future<List<ContabilParametroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilParametros)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilParametros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilParametroGroupedList = await query.map((row) {
			final contabilParametro = row.readTableOrNull(contabilParametros); 

			return ContabilParametroGrouped(
				contabilParametro: contabilParametro, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilParametroGrouped in contabilParametroGroupedList) {
		//}		

		return contabilParametroGroupedList;	
	}

	Future<ContabilParametro?> getObject(dynamic pk) async {
		return await (select(contabilParametros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilParametro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_parametro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilParametro;		 
	} 

	Future<ContabilParametroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilParametroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilParametro = object.contabilParametro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilParametros).insert(object.contabilParametro!);
			object.contabilParametro = object.contabilParametro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilParametros).replace(object.contabilParametro!);
		});	 
	} 

	Future<int> deleteObject(ContabilParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilParametros).delete(object.contabilParametro!);
		});		
	}

	Future<void> insertChildren(ContabilParametroGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilParametroGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_parametro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}