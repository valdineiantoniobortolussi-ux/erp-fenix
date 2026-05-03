import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

part 'ponto_parametro_dao.g.dart';

@DriftAccessor(tables: [
	PontoParametros,
])
class PontoParametroDao extends DatabaseAccessor<AppDatabase> with _$PontoParametroDaoMixin {
	final AppDatabase db;

	List<PontoParametro> pontoParametroList = []; 
	List<PontoParametroGrouped> pontoParametroGroupedList = []; 

	PontoParametroDao(this.db) : super(db);

	Future<List<PontoParametro>> getList() async {
		pontoParametroList = await select(pontoParametros).get();
		return pontoParametroList;
	}

	Future<List<PontoParametro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pontoParametroList = await (select(pontoParametros)..where((t) => expression)).get();
		return pontoParametroList;	 
	}

	Future<List<PontoParametroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pontoParametros)
			.join([]);

		if (field != null && field != '') { 
			final column = pontoParametros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pontoParametroGroupedList = await query.map((row) {
			final pontoParametro = row.readTableOrNull(pontoParametros); 

			return PontoParametroGrouped(
				pontoParametro: pontoParametro, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var pontoParametroGrouped in pontoParametroGroupedList) {
		//}		

		return pontoParametroGroupedList;	
	}

	Future<PontoParametro?> getObject(dynamic pk) async {
		return await (select(pontoParametros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PontoParametro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ponto_parametro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PontoParametro;		 
	} 

	Future<PontoParametroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PontoParametroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pontoParametro = object.pontoParametro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pontoParametros).insert(object.pontoParametro!);
			object.pontoParametro = object.pontoParametro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PontoParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pontoParametros).replace(object.pontoParametro!);
		});	 
	} 

	Future<int> deleteObject(PontoParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pontoParametros).delete(object.pontoParametro!);
		});		
	}

	Future<void> insertChildren(PontoParametroGrouped object) async {
	}
	
	Future<void> deleteChildren(PontoParametroGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ponto_parametro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}