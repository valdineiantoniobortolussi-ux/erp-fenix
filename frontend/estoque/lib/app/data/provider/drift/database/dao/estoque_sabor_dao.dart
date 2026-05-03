import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'estoque_sabor_dao.g.dart';

@DriftAccessor(tables: [
	EstoqueSabors,
])
class EstoqueSaborDao extends DatabaseAccessor<AppDatabase> with _$EstoqueSaborDaoMixin {
	final AppDatabase db;

	List<EstoqueSabor> estoqueSaborList = []; 
	List<EstoqueSaborGrouped> estoqueSaborGroupedList = []; 

	EstoqueSaborDao(this.db) : super(db);

	Future<List<EstoqueSabor>> getList() async {
		estoqueSaborList = await select(estoqueSabors).get();
		return estoqueSaborList;
	}

	Future<List<EstoqueSabor>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estoqueSaborList = await (select(estoqueSabors)..where((t) => expression)).get();
		return estoqueSaborList;	 
	}

	Future<List<EstoqueSaborGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estoqueSabors)
			.join([]);

		if (field != null && field != '') { 
			final column = estoqueSabors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estoqueSaborGroupedList = await query.map((row) {
			final estoqueSabor = row.readTableOrNull(estoqueSabors); 

			return EstoqueSaborGrouped(
				estoqueSabor: estoqueSabor, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var estoqueSaborGrouped in estoqueSaborGroupedList) {
		//}		

		return estoqueSaborGroupedList;	
	}

	Future<EstoqueSabor?> getObject(dynamic pk) async {
		return await (select(estoqueSabors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstoqueSabor?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estoque_sabor WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstoqueSabor;		 
	} 

	Future<EstoqueSaborGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstoqueSaborGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estoqueSabor = object.estoqueSabor!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estoqueSabors).insert(object.estoqueSabor!);
			object.estoqueSabor = object.estoqueSabor!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstoqueSaborGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estoqueSabors).replace(object.estoqueSabor!);
		});	 
	} 

	Future<int> deleteObject(EstoqueSaborGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estoqueSabors).delete(object.estoqueSabor!);
		});		
	}

	Future<void> insertChildren(EstoqueSaborGrouped object) async {
	}
	
	Future<void> deleteChildren(EstoqueSaborGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estoque_sabor").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}