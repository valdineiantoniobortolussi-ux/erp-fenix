import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'seguradora_dao.g.dart';

@DriftAccessor(tables: [
	Seguradoras,
])
class SeguradoraDao extends DatabaseAccessor<AppDatabase> with _$SeguradoraDaoMixin {
	final AppDatabase db;

	List<Seguradora> seguradoraList = []; 
	List<SeguradoraGrouped> seguradoraGroupedList = []; 

	SeguradoraDao(this.db) : super(db);

	Future<List<Seguradora>> getList() async {
		seguradoraList = await select(seguradoras).get();
		return seguradoraList;
	}

	Future<List<Seguradora>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		seguradoraList = await (select(seguradoras)..where((t) => expression)).get();
		return seguradoraList;	 
	}

	Future<List<SeguradoraGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(seguradoras)
			.join([]);

		if (field != null && field != '') { 
			final column = seguradoras.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		seguradoraGroupedList = await query.map((row) {
			final seguradora = row.readTableOrNull(seguradoras); 

			return SeguradoraGrouped(
				seguradora: seguradora, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var seguradoraGrouped in seguradoraGroupedList) {
		//}		

		return seguradoraGroupedList;	
	}

	Future<Seguradora?> getObject(dynamic pk) async {
		return await (select(seguradoras)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Seguradora?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM seguradora WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Seguradora;		 
	} 

	Future<SeguradoraGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(SeguradoraGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.seguradora = object.seguradora!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(seguradoras).insert(object.seguradora!);
			object.seguradora = object.seguradora!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(SeguradoraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(seguradoras).replace(object.seguradora!);
		});	 
	} 

	Future<int> deleteObject(SeguradoraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(seguradoras).delete(object.seguradora!);
		});		
	}

	Future<void> insertChildren(SeguradoraGrouped object) async {
	}
	
	Future<void> deleteChildren(SeguradoraGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from seguradora").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}