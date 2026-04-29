import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_rodoviario_lacre_dao.g.dart';

@DriftAccessor(tables: [
	CteRodoviarioLacres,
	CteRodoviarios,
])
class CteRodoviarioLacreDao extends DatabaseAccessor<AppDatabase> with _$CteRodoviarioLacreDaoMixin {
	final AppDatabase db;

	List<CteRodoviarioLacre> cteRodoviarioLacreList = []; 
	List<CteRodoviarioLacreGrouped> cteRodoviarioLacreGroupedList = []; 

	CteRodoviarioLacreDao(this.db) : super(db);

	Future<List<CteRodoviarioLacre>> getList() async {
		cteRodoviarioLacreList = await select(cteRodoviarioLacres).get();
		return cteRodoviarioLacreList;
	}

	Future<List<CteRodoviarioLacre>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteRodoviarioLacreList = await (select(cteRodoviarioLacres)..where((t) => expression)).get();
		return cteRodoviarioLacreList;	 
	}

	Future<List<CteRodoviarioLacreGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteRodoviarioLacres)
			.join([ 
				leftOuterJoin(cteRodoviarios, cteRodoviarios.id.equalsExp(cteRodoviarioLacres.idCteRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteRodoviarioLacres.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteRodoviarioLacreGroupedList = await query.map((row) {
			final cteRodoviarioLacre = row.readTableOrNull(cteRodoviarioLacres); 
			final cteRodoviario = row.readTableOrNull(cteRodoviarios); 

			return CteRodoviarioLacreGrouped(
				cteRodoviarioLacre: cteRodoviarioLacre, 
				cteRodoviario: cteRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteRodoviarioLacreGrouped in cteRodoviarioLacreGroupedList) {
		//}		

		return cteRodoviarioLacreGroupedList;	
	}

	Future<CteRodoviarioLacre?> getObject(dynamic pk) async {
		return await (select(cteRodoviarioLacres)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteRodoviarioLacre?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_rodoviario_lacre WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteRodoviarioLacre;		 
	} 

	Future<CteRodoviarioLacreGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteRodoviarioLacreGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteRodoviarioLacre = object.cteRodoviarioLacre!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteRodoviarioLacres).insert(object.cteRodoviarioLacre!);
			object.cteRodoviarioLacre = object.cteRodoviarioLacre!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteRodoviarioLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteRodoviarioLacres).replace(object.cteRodoviarioLacre!);
		});	 
	} 

	Future<int> deleteObject(CteRodoviarioLacreGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteRodoviarioLacres).delete(object.cteRodoviarioLacre!);
		});		
	}

	Future<void> insertChildren(CteRodoviarioLacreGrouped object) async {
	}
	
	Future<void> deleteChildren(CteRodoviarioLacreGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_rodoviario_lacre").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}