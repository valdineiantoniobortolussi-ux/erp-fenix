import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'plano_conta_ref_sped_dao.g.dart';

@DriftAccessor(tables: [
	PlanoContaRefSpeds,
])
class PlanoContaRefSpedDao extends DatabaseAccessor<AppDatabase> with _$PlanoContaRefSpedDaoMixin {
	final AppDatabase db;

	List<PlanoContaRefSped> planoContaRefSpedList = []; 
	List<PlanoContaRefSpedGrouped> planoContaRefSpedGroupedList = []; 

	PlanoContaRefSpedDao(this.db) : super(db);

	Future<List<PlanoContaRefSped>> getList() async {
		planoContaRefSpedList = await select(planoContaRefSpeds).get();
		return planoContaRefSpedList;
	}

	Future<List<PlanoContaRefSped>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		planoContaRefSpedList = await (select(planoContaRefSpeds)..where((t) => expression)).get();
		return planoContaRefSpedList;	 
	}

	Future<List<PlanoContaRefSpedGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(planoContaRefSpeds)
			.join([]);

		if (field != null && field != '') { 
			final column = planoContaRefSpeds.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		planoContaRefSpedGroupedList = await query.map((row) {
			final planoContaRefSped = row.readTableOrNull(planoContaRefSpeds); 

			return PlanoContaRefSpedGrouped(
				planoContaRefSped: planoContaRefSped, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var planoContaRefSpedGrouped in planoContaRefSpedGroupedList) {
		//}		

		return planoContaRefSpedGroupedList;	
	}

	Future<PlanoContaRefSped?> getObject(dynamic pk) async {
		return await (select(planoContaRefSpeds)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PlanoContaRefSped?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM plano_conta_ref_sped WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PlanoContaRefSped;		 
	} 

	Future<PlanoContaRefSpedGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PlanoContaRefSpedGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.planoContaRefSped = object.planoContaRefSped!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(planoContaRefSpeds).insert(object.planoContaRefSped!);
			object.planoContaRefSped = object.planoContaRefSped!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PlanoContaRefSpedGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(planoContaRefSpeds).replace(object.planoContaRefSped!);
		});	 
	} 

	Future<int> deleteObject(PlanoContaRefSpedGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(planoContaRefSpeds).delete(object.planoContaRefSped!);
		});		
	}

	Future<void> insertChildren(PlanoContaRefSpedGrouped object) async {
	}
	
	Future<void> deleteChildren(PlanoContaRefSpedGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from plano_conta_ref_sped").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}