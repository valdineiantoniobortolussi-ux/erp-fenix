import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_numero_inutilizado_dao.g.dart';

@DriftAccessor(tables: [
	NfeNumeroInutilizados,
])
class NfeNumeroInutilizadoDao extends DatabaseAccessor<AppDatabase> with _$NfeNumeroInutilizadoDaoMixin {
	final AppDatabase db;

	List<NfeNumeroInutilizado> nfeNumeroInutilizadoList = []; 
	List<NfeNumeroInutilizadoGrouped> nfeNumeroInutilizadoGroupedList = []; 

	NfeNumeroInutilizadoDao(this.db) : super(db);

	Future<List<NfeNumeroInutilizado>> getList() async {
		nfeNumeroInutilizadoList = await select(nfeNumeroInutilizados).get();
		return nfeNumeroInutilizadoList;
	}

	Future<List<NfeNumeroInutilizado>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeNumeroInutilizadoList = await (select(nfeNumeroInutilizados)..where((t) => expression)).get();
		return nfeNumeroInutilizadoList;	 
	}

	Future<List<NfeNumeroInutilizadoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeNumeroInutilizados)
			.join([]);

		if (field != null && field != '') { 
			final column = nfeNumeroInutilizados.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeNumeroInutilizadoGroupedList = await query.map((row) {
			final nfeNumeroInutilizado = row.readTableOrNull(nfeNumeroInutilizados); 

			return NfeNumeroInutilizadoGrouped(
				nfeNumeroInutilizado: nfeNumeroInutilizado, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeNumeroInutilizadoGrouped in nfeNumeroInutilizadoGroupedList) {
		//}		

		return nfeNumeroInutilizadoGroupedList;	
	}

	Future<NfeNumeroInutilizado?> getObject(dynamic pk) async {
		return await (select(nfeNumeroInutilizados)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeNumeroInutilizado?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_numero_inutilizado WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeNumeroInutilizado;		 
	} 

	Future<NfeNumeroInutilizadoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeNumeroInutilizadoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeNumeroInutilizado = object.nfeNumeroInutilizado!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeNumeroInutilizados).insert(object.nfeNumeroInutilizado!);
			object.nfeNumeroInutilizado = object.nfeNumeroInutilizado!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeNumeroInutilizadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeNumeroInutilizados).replace(object.nfeNumeroInutilizado!);
		});	 
	} 

	Future<int> deleteObject(NfeNumeroInutilizadoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeNumeroInutilizados).delete(object.nfeNumeroInutilizado!);
		});		
	}

	Future<void> insertChildren(NfeNumeroInutilizadoGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeNumeroInutilizadoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_numero_inutilizado").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}