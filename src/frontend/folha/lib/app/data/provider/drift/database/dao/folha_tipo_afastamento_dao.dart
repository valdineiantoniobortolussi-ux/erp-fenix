import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_tipo_afastamento_dao.g.dart';

@DriftAccessor(tables: [
	FolhaTipoAfastamentos,
])
class FolhaTipoAfastamentoDao extends DatabaseAccessor<AppDatabase> with _$FolhaTipoAfastamentoDaoMixin {
	final AppDatabase db;

	List<FolhaTipoAfastamento> folhaTipoAfastamentoList = []; 
	List<FolhaTipoAfastamentoGrouped> folhaTipoAfastamentoGroupedList = []; 

	FolhaTipoAfastamentoDao(this.db) : super(db);

	Future<List<FolhaTipoAfastamento>> getList() async {
		folhaTipoAfastamentoList = await select(folhaTipoAfastamentos).get();
		return folhaTipoAfastamentoList;
	}

	Future<List<FolhaTipoAfastamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaTipoAfastamentoList = await (select(folhaTipoAfastamentos)..where((t) => expression)).get();
		return folhaTipoAfastamentoList;	 
	}

	Future<List<FolhaTipoAfastamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaTipoAfastamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaTipoAfastamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaTipoAfastamentoGroupedList = await query.map((row) {
			final folhaTipoAfastamento = row.readTableOrNull(folhaTipoAfastamentos); 

			return FolhaTipoAfastamentoGrouped(
				folhaTipoAfastamento: folhaTipoAfastamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaTipoAfastamentoGrouped in folhaTipoAfastamentoGroupedList) {
		//}		

		return folhaTipoAfastamentoGroupedList;	
	}

	Future<FolhaTipoAfastamento?> getObject(dynamic pk) async {
		return await (select(folhaTipoAfastamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaTipoAfastamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_tipo_afastamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaTipoAfastamento;		 
	} 

	Future<FolhaTipoAfastamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaTipoAfastamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaTipoAfastamento = object.folhaTipoAfastamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaTipoAfastamentos).insert(object.folhaTipoAfastamento!);
			object.folhaTipoAfastamento = object.folhaTipoAfastamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaTipoAfastamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaTipoAfastamentos).replace(object.folhaTipoAfastamento!);
		});	 
	} 

	Future<int> deleteObject(FolhaTipoAfastamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaTipoAfastamentos).delete(object.folhaTipoAfastamento!);
		});		
	}

	Future<void> insertChildren(FolhaTipoAfastamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaTipoAfastamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_tipo_afastamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}