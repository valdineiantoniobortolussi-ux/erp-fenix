import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'tribut_grupo_tributario_dao.g.dart';

@DriftAccessor(tables: [
	TributGrupoTributarios,
])
class TributGrupoTributarioDao extends DatabaseAccessor<AppDatabase> with _$TributGrupoTributarioDaoMixin {
	final AppDatabase db;

	List<TributGrupoTributario> tributGrupoTributarioList = []; 
	List<TributGrupoTributarioGrouped> tributGrupoTributarioGroupedList = []; 

	TributGrupoTributarioDao(this.db) : super(db);

	Future<List<TributGrupoTributario>> getList() async {
		tributGrupoTributarioList = await select(tributGrupoTributarios).get();
		return tributGrupoTributarioList;
	}

	Future<List<TributGrupoTributario>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tributGrupoTributarioList = await (select(tributGrupoTributarios)..where((t) => expression)).get();
		return tributGrupoTributarioList;	 
	}

	Future<List<TributGrupoTributarioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tributGrupoTributarios)
			.join([]);

		if (field != null && field != '') { 
			final column = tributGrupoTributarios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tributGrupoTributarioGroupedList = await query.map((row) {
			final tributGrupoTributario = row.readTableOrNull(tributGrupoTributarios); 

			return TributGrupoTributarioGrouped(
				tributGrupoTributario: tributGrupoTributario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tributGrupoTributarioGrouped in tributGrupoTributarioGroupedList) {
		//}		

		return tributGrupoTributarioGroupedList;	
	}

	Future<TributGrupoTributario?> getObject(dynamic pk) async {
		return await (select(tributGrupoTributarios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TributGrupoTributario?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tribut_grupo_tributario WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TributGrupoTributario;		 
	} 

	Future<TributGrupoTributarioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TributGrupoTributarioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tributGrupoTributario = object.tributGrupoTributario!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tributGrupoTributarios).insert(object.tributGrupoTributario!);
			object.tributGrupoTributario = object.tributGrupoTributario!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TributGrupoTributarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tributGrupoTributarios).replace(object.tributGrupoTributario!);
		});	 
	} 

	Future<int> deleteObject(TributGrupoTributarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tributGrupoTributarios).delete(object.tributGrupoTributario!);
		});		
	}

	Future<void> insertChildren(TributGrupoTributarioGrouped object) async {
	}
	
	Future<void> deleteChildren(TributGrupoTributarioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tribut_grupo_tributario").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}