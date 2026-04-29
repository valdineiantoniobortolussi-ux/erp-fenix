import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/provider/drift/database/database_imports.dart';

part 'frota_veiculo_tipo_dao.g.dart';

@DriftAccessor(tables: [
	FrotaVeiculoTipos,
])
class FrotaVeiculoTipoDao extends DatabaseAccessor<AppDatabase> with _$FrotaVeiculoTipoDaoMixin {
	final AppDatabase db;

	List<FrotaVeiculoTipo> frotaVeiculoTipoList = []; 
	List<FrotaVeiculoTipoGrouped> frotaVeiculoTipoGroupedList = []; 

	FrotaVeiculoTipoDao(this.db) : super(db);

	Future<List<FrotaVeiculoTipo>> getList() async {
		frotaVeiculoTipoList = await select(frotaVeiculoTipos).get();
		return frotaVeiculoTipoList;
	}

	Future<List<FrotaVeiculoTipo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		frotaVeiculoTipoList = await (select(frotaVeiculoTipos)..where((t) => expression)).get();
		return frotaVeiculoTipoList;	 
	}

	Future<List<FrotaVeiculoTipoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(frotaVeiculoTipos)
			.join([]);

		if (field != null && field != '') { 
			final column = frotaVeiculoTipos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		frotaVeiculoTipoGroupedList = await query.map((row) {
			final frotaVeiculoTipo = row.readTableOrNull(frotaVeiculoTipos); 

			return FrotaVeiculoTipoGrouped(
				frotaVeiculoTipo: frotaVeiculoTipo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var frotaVeiculoTipoGrouped in frotaVeiculoTipoGroupedList) {
		//}		

		return frotaVeiculoTipoGroupedList;	
	}

	Future<FrotaVeiculoTipo?> getObject(dynamic pk) async {
		return await (select(frotaVeiculoTipos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FrotaVeiculoTipo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM frota_veiculo_tipo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FrotaVeiculoTipo;		 
	} 

	Future<FrotaVeiculoTipoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FrotaVeiculoTipoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.frotaVeiculoTipo = object.frotaVeiculoTipo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(frotaVeiculoTipos).insert(object.frotaVeiculoTipo!);
			object.frotaVeiculoTipo = object.frotaVeiculoTipo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FrotaVeiculoTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(frotaVeiculoTipos).replace(object.frotaVeiculoTipo!);
		});	 
	} 

	Future<int> deleteObject(FrotaVeiculoTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(frotaVeiculoTipos).delete(object.frotaVeiculoTipo!);
		});		
	}

	Future<void> insertChildren(FrotaVeiculoTipoGrouped object) async {
	}
	
	Future<void> deleteChildren(FrotaVeiculoTipoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from frota_veiculo_tipo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}