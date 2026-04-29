import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_numero_dao.g.dart';

@DriftAccessor(tables: [
	NfeNumeros,
])
class NfeNumeroDao extends DatabaseAccessor<AppDatabase> with _$NfeNumeroDaoMixin {
	final AppDatabase db;

	List<NfeNumero> nfeNumeroList = []; 
	List<NfeNumeroGrouped> nfeNumeroGroupedList = []; 

	NfeNumeroDao(this.db) : super(db);

	Future<List<NfeNumero>> getList() async {
		nfeNumeroList = await select(nfeNumeros).get();
		return nfeNumeroList;
	}

	Future<List<NfeNumero>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeNumeroList = await (select(nfeNumeros)..where((t) => expression)).get();
		return nfeNumeroList;	 
	}

	Future<List<NfeNumeroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeNumeros)
			.join([]);

		if (field != null && field != '') { 
			final column = nfeNumeros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeNumeroGroupedList = await query.map((row) {
			final nfeNumero = row.readTableOrNull(nfeNumeros); 

			return NfeNumeroGrouped(
				nfeNumero: nfeNumero, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeNumeroGrouped in nfeNumeroGroupedList) {
		//}		

		return nfeNumeroGroupedList;	
	}

	Future<NfeNumero?> getObject(dynamic pk) async {
		return await (select(nfeNumeros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeNumero?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_numero WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeNumero;		 
	} 

	Future<NfeNumeroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeNumeroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeNumero = object.nfeNumero!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeNumeros).insert(object.nfeNumero!);
			object.nfeNumero = object.nfeNumero!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeNumeroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeNumeros).replace(object.nfeNumero!);
		});	 
	} 

	Future<int> deleteObject(NfeNumeroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeNumeros).delete(object.nfeNumero!);
		});		
	}

	Future<void> insertChildren(NfeNumeroGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeNumeroGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_numero").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}