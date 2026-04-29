import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'estoque_marca_dao.g.dart';

@DriftAccessor(tables: [
	EstoqueMarcas,
])
class EstoqueMarcaDao extends DatabaseAccessor<AppDatabase> with _$EstoqueMarcaDaoMixin {
	final AppDatabase db;

	List<EstoqueMarca> estoqueMarcaList = []; 
	List<EstoqueMarcaGrouped> estoqueMarcaGroupedList = []; 

	EstoqueMarcaDao(this.db) : super(db);

	Future<List<EstoqueMarca>> getList() async {
		estoqueMarcaList = await select(estoqueMarcas).get();
		return estoqueMarcaList;
	}

	Future<List<EstoqueMarca>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estoqueMarcaList = await (select(estoqueMarcas)..where((t) => expression)).get();
		return estoqueMarcaList;	 
	}

	Future<List<EstoqueMarcaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estoqueMarcas)
			.join([]);

		if (field != null && field != '') { 
			final column = estoqueMarcas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estoqueMarcaGroupedList = await query.map((row) {
			final estoqueMarca = row.readTableOrNull(estoqueMarcas); 

			return EstoqueMarcaGrouped(
				estoqueMarca: estoqueMarca, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var estoqueMarcaGrouped in estoqueMarcaGroupedList) {
		//}		

		return estoqueMarcaGroupedList;	
	}

	Future<EstoqueMarca?> getObject(dynamic pk) async {
		return await (select(estoqueMarcas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstoqueMarca?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estoque_marca WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstoqueMarca;		 
	} 

	Future<EstoqueMarcaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstoqueMarcaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estoqueMarca = object.estoqueMarca!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estoqueMarcas).insert(object.estoqueMarca!);
			object.estoqueMarca = object.estoqueMarca!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstoqueMarcaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estoqueMarcas).replace(object.estoqueMarca!);
		});	 
	} 

	Future<int> deleteObject(EstoqueMarcaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estoqueMarcas).delete(object.estoqueMarca!);
		});		
	}

	Future<void> insertChildren(EstoqueMarcaGrouped object) async {
	}
	
	Future<void> deleteChildren(EstoqueMarcaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estoque_marca").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}