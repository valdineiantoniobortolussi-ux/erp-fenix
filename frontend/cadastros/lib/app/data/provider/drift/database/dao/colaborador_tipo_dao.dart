import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'colaborador_tipo_dao.g.dart';

@DriftAccessor(tables: [
	ColaboradorTipos,
])
class ColaboradorTipoDao extends DatabaseAccessor<AppDatabase> with _$ColaboradorTipoDaoMixin {
	final AppDatabase db;

	List<ColaboradorTipo> colaboradorTipoList = []; 
	List<ColaboradorTipoGrouped> colaboradorTipoGroupedList = []; 

	ColaboradorTipoDao(this.db) : super(db);

	Future<List<ColaboradorTipo>> getList() async {
		colaboradorTipoList = await select(colaboradorTipos).get();
		return colaboradorTipoList;
	}

	Future<List<ColaboradorTipo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		colaboradorTipoList = await (select(colaboradorTipos)..where((t) => expression)).get();
		return colaboradorTipoList;	 
	}

	Future<List<ColaboradorTipoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(colaboradorTipos)
			.join([]);

		if (field != null && field != '') { 
			final column = colaboradorTipos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		colaboradorTipoGroupedList = await query.map((row) {
			final colaboradorTipo = row.readTableOrNull(colaboradorTipos); 

			return ColaboradorTipoGrouped(
				colaboradorTipo: colaboradorTipo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var colaboradorTipoGrouped in colaboradorTipoGroupedList) {
		//}		

		return colaboradorTipoGroupedList;	
	}

	Future<ColaboradorTipo?> getObject(dynamic pk) async {
		return await (select(colaboradorTipos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ColaboradorTipo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM colaborador_tipo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ColaboradorTipo;		 
	} 

	Future<ColaboradorTipoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ColaboradorTipoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.colaboradorTipo = object.colaboradorTipo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(colaboradorTipos).insert(object.colaboradorTipo!);
			object.colaboradorTipo = object.colaboradorTipo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ColaboradorTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(colaboradorTipos).replace(object.colaboradorTipo!);
		});	 
	} 

	Future<int> deleteObject(ColaboradorTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(colaboradorTipos).delete(object.colaboradorTipo!);
		});		
	}

	Future<void> insertChildren(ColaboradorTipoGrouped object) async {
	}
	
	Future<void> deleteChildren(ColaboradorTipoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from colaborador_tipo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}