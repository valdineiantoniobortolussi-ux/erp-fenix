import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/provider/drift/database/database_imports.dart';

part 'frota_combustivel_tipo_dao.g.dart';

@DriftAccessor(tables: [
	FrotaCombustivelTipos,
])
class FrotaCombustivelTipoDao extends DatabaseAccessor<AppDatabase> with _$FrotaCombustivelTipoDaoMixin {
	final AppDatabase db;

	List<FrotaCombustivelTipo> frotaCombustivelTipoList = []; 
	List<FrotaCombustivelTipoGrouped> frotaCombustivelTipoGroupedList = []; 

	FrotaCombustivelTipoDao(this.db) : super(db);

	Future<List<FrotaCombustivelTipo>> getList() async {
		frotaCombustivelTipoList = await select(frotaCombustivelTipos).get();
		return frotaCombustivelTipoList;
	}

	Future<List<FrotaCombustivelTipo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		frotaCombustivelTipoList = await (select(frotaCombustivelTipos)..where((t) => expression)).get();
		return frotaCombustivelTipoList;	 
	}

	Future<List<FrotaCombustivelTipoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(frotaCombustivelTipos)
			.join([]);

		if (field != null && field != '') { 
			final column = frotaCombustivelTipos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		frotaCombustivelTipoGroupedList = await query.map((row) {
			final frotaCombustivelTipo = row.readTableOrNull(frotaCombustivelTipos); 

			return FrotaCombustivelTipoGrouped(
				frotaCombustivelTipo: frotaCombustivelTipo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var frotaCombustivelTipoGrouped in frotaCombustivelTipoGroupedList) {
		//}		

		return frotaCombustivelTipoGroupedList;	
	}

	Future<FrotaCombustivelTipo?> getObject(dynamic pk) async {
		return await (select(frotaCombustivelTipos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FrotaCombustivelTipo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM frota_combustivel_tipo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FrotaCombustivelTipo;		 
	} 

	Future<FrotaCombustivelTipoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FrotaCombustivelTipoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.frotaCombustivelTipo = object.frotaCombustivelTipo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(frotaCombustivelTipos).insert(object.frotaCombustivelTipo!);
			object.frotaCombustivelTipo = object.frotaCombustivelTipo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FrotaCombustivelTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(frotaCombustivelTipos).replace(object.frotaCombustivelTipo!);
		});	 
	} 

	Future<int> deleteObject(FrotaCombustivelTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(frotaCombustivelTipos).delete(object.frotaCombustivelTipo!);
		});		
	}

	Future<void> insertChildren(FrotaCombustivelTipoGrouped object) async {
	}
	
	Future<void> deleteChildren(FrotaCombustivelTipoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from frota_combustivel_tipo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}