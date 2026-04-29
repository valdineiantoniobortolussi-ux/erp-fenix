import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'cep_dao.g.dart';

@DriftAccessor(tables: [
	Ceps,
])
class CepDao extends DatabaseAccessor<AppDatabase> with _$CepDaoMixin {
	final AppDatabase db;

	List<Cep> cepList = []; 
	List<CepGrouped> cepGroupedList = []; 

	CepDao(this.db) : super(db);

	Future<List<Cep>> getList() async {
		cepList = await select(ceps).get();
		return cepList;
	}

	Future<List<Cep>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cepList = await (select(ceps)..where((t) => expression)).get();
		return cepList;	 
	}

	Future<List<CepGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(ceps)
			.join([]);

		if (field != null && field != '') { 
			final column = ceps.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cepGroupedList = await query.map((row) {
			final cep = row.readTableOrNull(ceps); 

			return CepGrouped(
				cep: cep, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cepGrouped in cepGroupedList) {
		//}		

		return cepGroupedList;	
	}

	Future<Cep?> getObject(dynamic pk) async {
		return await (select(ceps)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Cep?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cep WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Cep;		 
	} 

	Future<CepGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CepGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cep = object.cep!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(ceps).insert(object.cep!);
			object.cep = object.cep!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CepGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(ceps).replace(object.cep!);
		});	 
	} 

	Future<int> deleteObject(CepGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(ceps).delete(object.cep!);
		});		
	}

	Future<void> insertChildren(CepGrouped object) async {
	}
	
	Future<void> deleteChildren(CepGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cep").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}