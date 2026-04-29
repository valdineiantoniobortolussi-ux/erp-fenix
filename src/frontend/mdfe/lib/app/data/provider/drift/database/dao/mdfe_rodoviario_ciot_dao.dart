import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_rodoviario_ciot_dao.g.dart';

@DriftAccessor(tables: [
	MdfeRodoviarioCiots,
	MdfeRodoviarios,
])
class MdfeRodoviarioCiotDao extends DatabaseAccessor<AppDatabase> with _$MdfeRodoviarioCiotDaoMixin {
	final AppDatabase db;

	List<MdfeRodoviarioCiot> mdfeRodoviarioCiotList = []; 
	List<MdfeRodoviarioCiotGrouped> mdfeRodoviarioCiotGroupedList = []; 

	MdfeRodoviarioCiotDao(this.db) : super(db);

	Future<List<MdfeRodoviarioCiot>> getList() async {
		mdfeRodoviarioCiotList = await select(mdfeRodoviarioCiots).get();
		return mdfeRodoviarioCiotList;
	}

	Future<List<MdfeRodoviarioCiot>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeRodoviarioCiotList = await (select(mdfeRodoviarioCiots)..where((t) => expression)).get();
		return mdfeRodoviarioCiotList;	 
	}

	Future<List<MdfeRodoviarioCiotGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeRodoviarioCiots)
			.join([ 
				leftOuterJoin(mdfeRodoviarios, mdfeRodoviarios.id.equalsExp(mdfeRodoviarioCiots.idMdfeRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = mdfeRodoviarioCiots.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeRodoviarioCiotGroupedList = await query.map((row) {
			final mdfeRodoviarioCiot = row.readTableOrNull(mdfeRodoviarioCiots); 
			final mdfeRodoviario = row.readTableOrNull(mdfeRodoviarios); 

			return MdfeRodoviarioCiotGrouped(
				mdfeRodoviarioCiot: mdfeRodoviarioCiot, 
				mdfeRodoviario: mdfeRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var mdfeRodoviarioCiotGrouped in mdfeRodoviarioCiotGroupedList) {
		//}		

		return mdfeRodoviarioCiotGroupedList;	
	}

	Future<MdfeRodoviarioCiot?> getObject(dynamic pk) async {
		return await (select(mdfeRodoviarioCiots)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeRodoviarioCiot?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_rodoviario_ciot WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeRodoviarioCiot;		 
	} 

	Future<MdfeRodoviarioCiotGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeRodoviarioCiotGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeRodoviarioCiot = object.mdfeRodoviarioCiot!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeRodoviarioCiots).insert(object.mdfeRodoviarioCiot!);
			object.mdfeRodoviarioCiot = object.mdfeRodoviarioCiot!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeRodoviarioCiotGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeRodoviarioCiots).replace(object.mdfeRodoviarioCiot!);
		});	 
	} 

	Future<int> deleteObject(MdfeRodoviarioCiotGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeRodoviarioCiots).delete(object.mdfeRodoviarioCiot!);
		});		
	}

	Future<void> insertChildren(MdfeRodoviarioCiotGrouped object) async {
	}
	
	Future<void> deleteChildren(MdfeRodoviarioCiotGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_rodoviario_ciot").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}