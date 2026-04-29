import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/provider/drift/database/database_imports.dart';

part 'esocial_rubrica_dao.g.dart';

@DriftAccessor(tables: [
	EsocialRubricas,
])
class EsocialRubricaDao extends DatabaseAccessor<AppDatabase> with _$EsocialRubricaDaoMixin {
	final AppDatabase db;

	List<EsocialRubrica> esocialRubricaList = []; 
	List<EsocialRubricaGrouped> esocialRubricaGroupedList = []; 

	EsocialRubricaDao(this.db) : super(db);

	Future<List<EsocialRubrica>> getList() async {
		esocialRubricaList = await select(esocialRubricas).get();
		return esocialRubricaList;
	}

	Future<List<EsocialRubrica>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		esocialRubricaList = await (select(esocialRubricas)..where((t) => expression)).get();
		return esocialRubricaList;	 
	}

	Future<List<EsocialRubricaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(esocialRubricas)
			.join([]);

		if (field != null && field != '') { 
			final column = esocialRubricas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		esocialRubricaGroupedList = await query.map((row) {
			final esocialRubrica = row.readTableOrNull(esocialRubricas); 

			return EsocialRubricaGrouped(
				esocialRubrica: esocialRubrica, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var esocialRubricaGrouped in esocialRubricaGroupedList) {
		//}		

		return esocialRubricaGroupedList;	
	}

	Future<EsocialRubrica?> getObject(dynamic pk) async {
		return await (select(esocialRubricas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EsocialRubrica?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM esocial_rubrica WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EsocialRubrica;		 
	} 

	Future<EsocialRubricaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EsocialRubricaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.esocialRubrica = object.esocialRubrica!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(esocialRubricas).insert(object.esocialRubrica!);
			object.esocialRubrica = object.esocialRubrica!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EsocialRubricaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(esocialRubricas).replace(object.esocialRubrica!);
		});	 
	} 

	Future<int> deleteObject(EsocialRubricaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(esocialRubricas).delete(object.esocialRubrica!);
		});		
	}

	Future<void> insertChildren(EsocialRubricaGrouped object) async {
	}
	
	Future<void> deleteChildren(EsocialRubricaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from esocial_rubrica").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}