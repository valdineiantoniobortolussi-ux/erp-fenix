import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_rodoviario_pedagio_dao.g.dart';

@DriftAccessor(tables: [
	MdfeRodoviarioPedagios,
	MdfeRodoviarios,
])
class MdfeRodoviarioPedagioDao extends DatabaseAccessor<AppDatabase> with _$MdfeRodoviarioPedagioDaoMixin {
	final AppDatabase db;

	List<MdfeRodoviarioPedagio> mdfeRodoviarioPedagioList = []; 
	List<MdfeRodoviarioPedagioGrouped> mdfeRodoviarioPedagioGroupedList = []; 

	MdfeRodoviarioPedagioDao(this.db) : super(db);

	Future<List<MdfeRodoviarioPedagio>> getList() async {
		mdfeRodoviarioPedagioList = await select(mdfeRodoviarioPedagios).get();
		return mdfeRodoviarioPedagioList;
	}

	Future<List<MdfeRodoviarioPedagio>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeRodoviarioPedagioList = await (select(mdfeRodoviarioPedagios)..where((t) => expression)).get();
		return mdfeRodoviarioPedagioList;	 
	}

	Future<List<MdfeRodoviarioPedagioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeRodoviarioPedagios)
			.join([ 
				leftOuterJoin(mdfeRodoviarios, mdfeRodoviarios.id.equalsExp(mdfeRodoviarioPedagios.idMdfeRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = mdfeRodoviarioPedagios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeRodoviarioPedagioGroupedList = await query.map((row) {
			final mdfeRodoviarioPedagio = row.readTableOrNull(mdfeRodoviarioPedagios); 
			final mdfeRodoviario = row.readTableOrNull(mdfeRodoviarios); 

			return MdfeRodoviarioPedagioGrouped(
				mdfeRodoviarioPedagio: mdfeRodoviarioPedagio, 
				mdfeRodoviario: mdfeRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var mdfeRodoviarioPedagioGrouped in mdfeRodoviarioPedagioGroupedList) {
		//}		

		return mdfeRodoviarioPedagioGroupedList;	
	}

	Future<MdfeRodoviarioPedagio?> getObject(dynamic pk) async {
		return await (select(mdfeRodoviarioPedagios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeRodoviarioPedagio?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_rodoviario_pedagio WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeRodoviarioPedagio;		 
	} 

	Future<MdfeRodoviarioPedagioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeRodoviarioPedagioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeRodoviarioPedagio = object.mdfeRodoviarioPedagio!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeRodoviarioPedagios).insert(object.mdfeRodoviarioPedagio!);
			object.mdfeRodoviarioPedagio = object.mdfeRodoviarioPedagio!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeRodoviarioPedagioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeRodoviarioPedagios).replace(object.mdfeRodoviarioPedagio!);
		});	 
	} 

	Future<int> deleteObject(MdfeRodoviarioPedagioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeRodoviarioPedagios).delete(object.mdfeRodoviarioPedagio!);
		});		
	}

	Future<void> insertChildren(MdfeRodoviarioPedagioGrouped object) async {
	}
	
	Future<void> deleteChildren(MdfeRodoviarioPedagioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_rodoviario_pedagio").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}