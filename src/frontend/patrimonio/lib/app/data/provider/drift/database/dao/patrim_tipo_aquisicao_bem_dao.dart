import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_tipo_aquisicao_bem_dao.g.dart';

@DriftAccessor(tables: [
	PatrimTipoAquisicaoBems,
])
class PatrimTipoAquisicaoBemDao extends DatabaseAccessor<AppDatabase> with _$PatrimTipoAquisicaoBemDaoMixin {
	final AppDatabase db;

	List<PatrimTipoAquisicaoBem> patrimTipoAquisicaoBemList = []; 
	List<PatrimTipoAquisicaoBemGrouped> patrimTipoAquisicaoBemGroupedList = []; 

	PatrimTipoAquisicaoBemDao(this.db) : super(db);

	Future<List<PatrimTipoAquisicaoBem>> getList() async {
		patrimTipoAquisicaoBemList = await select(patrimTipoAquisicaoBems).get();
		return patrimTipoAquisicaoBemList;
	}

	Future<List<PatrimTipoAquisicaoBem>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimTipoAquisicaoBemList = await (select(patrimTipoAquisicaoBems)..where((t) => expression)).get();
		return patrimTipoAquisicaoBemList;	 
	}

	Future<List<PatrimTipoAquisicaoBemGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimTipoAquisicaoBems)
			.join([]);

		if (field != null && field != '') { 
			final column = patrimTipoAquisicaoBems.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimTipoAquisicaoBemGroupedList = await query.map((row) {
			final patrimTipoAquisicaoBem = row.readTableOrNull(patrimTipoAquisicaoBems); 

			return PatrimTipoAquisicaoBemGrouped(
				patrimTipoAquisicaoBem: patrimTipoAquisicaoBem, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var patrimTipoAquisicaoBemGrouped in patrimTipoAquisicaoBemGroupedList) {
		//}		

		return patrimTipoAquisicaoBemGroupedList;	
	}

	Future<PatrimTipoAquisicaoBem?> getObject(dynamic pk) async {
		return await (select(patrimTipoAquisicaoBems)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimTipoAquisicaoBem?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_tipo_aquisicao_bem WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimTipoAquisicaoBem;		 
	} 

	Future<PatrimTipoAquisicaoBemGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimTipoAquisicaoBemGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimTipoAquisicaoBem = object.patrimTipoAquisicaoBem!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimTipoAquisicaoBems).insert(object.patrimTipoAquisicaoBem!);
			object.patrimTipoAquisicaoBem = object.patrimTipoAquisicaoBem!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimTipoAquisicaoBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimTipoAquisicaoBems).replace(object.patrimTipoAquisicaoBem!);
		});	 
	} 

	Future<int> deleteObject(PatrimTipoAquisicaoBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimTipoAquisicaoBems).delete(object.patrimTipoAquisicaoBem!);
		});		
	}

	Future<void> insertChildren(PatrimTipoAquisicaoBemGrouped object) async {
	}
	
	Future<void> deleteChildren(PatrimTipoAquisicaoBemGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_tipo_aquisicao_bem").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}