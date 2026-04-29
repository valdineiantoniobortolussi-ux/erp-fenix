import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';

part 'gondola_estante_dao.g.dart';

@DriftAccessor(tables: [
	GondolaEstantes,
	GondolaRuas,
])
class GondolaEstanteDao extends DatabaseAccessor<AppDatabase> with _$GondolaEstanteDaoMixin {
	final AppDatabase db;

	List<GondolaEstante> gondolaEstanteList = []; 
	List<GondolaEstanteGrouped> gondolaEstanteGroupedList = []; 

	GondolaEstanteDao(this.db) : super(db);

	Future<List<GondolaEstante>> getList() async {
		gondolaEstanteList = await select(gondolaEstantes).get();
		return gondolaEstanteList;
	}

	Future<List<GondolaEstante>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		gondolaEstanteList = await (select(gondolaEstantes)..where((t) => expression)).get();
		return gondolaEstanteList;	 
	}

	Future<List<GondolaEstanteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(gondolaEstantes)
			.join([ 
				leftOuterJoin(gondolaRuas, gondolaRuas.id.equalsExp(gondolaEstantes.idGondolaRua)), 
			]);

		if (field != null && field != '') { 
			final column = gondolaEstantes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		gondolaEstanteGroupedList = await query.map((row) {
			final gondolaEstante = row.readTableOrNull(gondolaEstantes); 
			final gondolaRua = row.readTableOrNull(gondolaRuas); 

			return GondolaEstanteGrouped(
				gondolaEstante: gondolaEstante, 
				gondolaRua: gondolaRua, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var gondolaEstanteGrouped in gondolaEstanteGroupedList) {
		//}		

		return gondolaEstanteGroupedList;	
	}

	Future<GondolaEstante?> getObject(dynamic pk) async {
		return await (select(gondolaEstantes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GondolaEstante?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM gondola_estante WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GondolaEstante;		 
	} 

	Future<GondolaEstanteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GondolaEstanteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.gondolaEstante = object.gondolaEstante!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(gondolaEstantes).insert(object.gondolaEstante!);
			object.gondolaEstante = object.gondolaEstante!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GondolaEstanteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(gondolaEstantes).replace(object.gondolaEstante!);
		});	 
	} 

	Future<int> deleteObject(GondolaEstanteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(gondolaEstantes).delete(object.gondolaEstante!);
		});		
	}

	Future<void> insertChildren(GondolaEstanteGrouped object) async {
	}
	
	Future<void> deleteChildren(GondolaEstanteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from gondola_estante").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}