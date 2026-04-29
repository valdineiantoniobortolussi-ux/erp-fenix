import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'estoque_tamanho_dao.g.dart';

@DriftAccessor(tables: [
	EstoqueTamanhos,
])
class EstoqueTamanhoDao extends DatabaseAccessor<AppDatabase> with _$EstoqueTamanhoDaoMixin {
	final AppDatabase db;

	List<EstoqueTamanho> estoqueTamanhoList = []; 
	List<EstoqueTamanhoGrouped> estoqueTamanhoGroupedList = []; 

	EstoqueTamanhoDao(this.db) : super(db);

	Future<List<EstoqueTamanho>> getList() async {
		estoqueTamanhoList = await select(estoqueTamanhos).get();
		return estoqueTamanhoList;
	}

	Future<List<EstoqueTamanho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estoqueTamanhoList = await (select(estoqueTamanhos)..where((t) => expression)).get();
		return estoqueTamanhoList;	 
	}

	Future<List<EstoqueTamanhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estoqueTamanhos)
			.join([]);

		if (field != null && field != '') { 
			final column = estoqueTamanhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estoqueTamanhoGroupedList = await query.map((row) {
			final estoqueTamanho = row.readTableOrNull(estoqueTamanhos); 

			return EstoqueTamanhoGrouped(
				estoqueTamanho: estoqueTamanho, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var estoqueTamanhoGrouped in estoqueTamanhoGroupedList) {
		//}		

		return estoqueTamanhoGroupedList;	
	}

	Future<EstoqueTamanho?> getObject(dynamic pk) async {
		return await (select(estoqueTamanhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstoqueTamanho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estoque_tamanho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstoqueTamanho;		 
	} 

	Future<EstoqueTamanhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstoqueTamanhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estoqueTamanho = object.estoqueTamanho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estoqueTamanhos).insert(object.estoqueTamanho!);
			object.estoqueTamanho = object.estoqueTamanho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstoqueTamanhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estoqueTamanhos).replace(object.estoqueTamanho!);
		});	 
	} 

	Future<int> deleteObject(EstoqueTamanhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estoqueTamanhos).delete(object.estoqueTamanho!);
		});		
	}

	Future<void> insertChildren(EstoqueTamanhoGrouped object) async {
	}
	
	Future<void> deleteChildren(EstoqueTamanhoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estoque_tamanho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}