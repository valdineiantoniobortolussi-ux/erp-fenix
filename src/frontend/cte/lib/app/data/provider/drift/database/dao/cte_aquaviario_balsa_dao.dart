import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_aquaviario_balsa_dao.g.dart';

@DriftAccessor(tables: [
	CteAquaviarioBalsas,
	CteAquaviarios,
])
class CteAquaviarioBalsaDao extends DatabaseAccessor<AppDatabase> with _$CteAquaviarioBalsaDaoMixin {
	final AppDatabase db;

	List<CteAquaviarioBalsa> cteAquaviarioBalsaList = []; 
	List<CteAquaviarioBalsaGrouped> cteAquaviarioBalsaGroupedList = []; 

	CteAquaviarioBalsaDao(this.db) : super(db);

	Future<List<CteAquaviarioBalsa>> getList() async {
		cteAquaviarioBalsaList = await select(cteAquaviarioBalsas).get();
		return cteAquaviarioBalsaList;
	}

	Future<List<CteAquaviarioBalsa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteAquaviarioBalsaList = await (select(cteAquaviarioBalsas)..where((t) => expression)).get();
		return cteAquaviarioBalsaList;	 
	}

	Future<List<CteAquaviarioBalsaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteAquaviarioBalsas)
			.join([ 
				leftOuterJoin(cteAquaviarios, cteAquaviarios.id.equalsExp(cteAquaviarioBalsas.idCteAquaviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteAquaviarioBalsas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteAquaviarioBalsaGroupedList = await query.map((row) {
			final cteAquaviarioBalsa = row.readTableOrNull(cteAquaviarioBalsas); 
			final cteAquaviario = row.readTableOrNull(cteAquaviarios); 

			return CteAquaviarioBalsaGrouped(
				cteAquaviarioBalsa: cteAquaviarioBalsa, 
				cteAquaviario: cteAquaviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteAquaviarioBalsaGrouped in cteAquaviarioBalsaGroupedList) {
		//}		

		return cteAquaviarioBalsaGroupedList;	
	}

	Future<CteAquaviarioBalsa?> getObject(dynamic pk) async {
		return await (select(cteAquaviarioBalsas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteAquaviarioBalsa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_aquaviario_balsa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteAquaviarioBalsa;		 
	} 

	Future<CteAquaviarioBalsaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteAquaviarioBalsaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteAquaviarioBalsa = object.cteAquaviarioBalsa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteAquaviarioBalsas).insert(object.cteAquaviarioBalsa!);
			object.cteAquaviarioBalsa = object.cteAquaviarioBalsa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteAquaviarioBalsaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteAquaviarioBalsas).replace(object.cteAquaviarioBalsa!);
		});	 
	} 

	Future<int> deleteObject(CteAquaviarioBalsaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteAquaviarioBalsas).delete(object.cteAquaviarioBalsa!);
		});		
	}

	Future<void> insertChildren(CteAquaviarioBalsaGrouped object) async {
	}
	
	Future<void> deleteChildren(CteAquaviarioBalsaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_aquaviario_balsa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}