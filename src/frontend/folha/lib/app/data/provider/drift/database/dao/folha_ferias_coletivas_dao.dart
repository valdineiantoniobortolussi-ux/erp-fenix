import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_ferias_coletivas_dao.g.dart';

@DriftAccessor(tables: [
	FolhaFeriasColetivass,
])
class FolhaFeriasColetivasDao extends DatabaseAccessor<AppDatabase> with _$FolhaFeriasColetivasDaoMixin {
	final AppDatabase db;

	List<FolhaFeriasColetivas> folhaFeriasColetivasList = []; 
	List<FolhaFeriasColetivasGrouped> folhaFeriasColetivasGroupedList = []; 

	FolhaFeriasColetivasDao(this.db) : super(db);

	Future<List<FolhaFeriasColetivas>> getList() async {
		folhaFeriasColetivasList = await select(folhaFeriasColetivass).get();
		return folhaFeriasColetivasList;
	}

	Future<List<FolhaFeriasColetivas>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaFeriasColetivasList = await (select(folhaFeriasColetivass)..where((t) => expression)).get();
		return folhaFeriasColetivasList;	 
	}

	Future<List<FolhaFeriasColetivasGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaFeriasColetivass)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaFeriasColetivass.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaFeriasColetivasGroupedList = await query.map((row) {
			final folhaFeriasColetivas = row.readTableOrNull(folhaFeriasColetivass); 

			return FolhaFeriasColetivasGrouped(
				folhaFeriasColetivas: folhaFeriasColetivas, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaFeriasColetivasGrouped in folhaFeriasColetivasGroupedList) {
		//}		

		return folhaFeriasColetivasGroupedList;	
	}

	Future<FolhaFeriasColetivas?> getObject(dynamic pk) async {
		return await (select(folhaFeriasColetivass)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaFeriasColetivas?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_ferias_coletivas WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaFeriasColetivas;		 
	} 

	Future<FolhaFeriasColetivasGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaFeriasColetivasGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaFeriasColetivas = object.folhaFeriasColetivas!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaFeriasColetivass).insert(object.folhaFeriasColetivas!);
			object.folhaFeriasColetivas = object.folhaFeriasColetivas!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaFeriasColetivasGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaFeriasColetivass).replace(object.folhaFeriasColetivas!);
		});	 
	} 

	Future<int> deleteObject(FolhaFeriasColetivasGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaFeriasColetivass).delete(object.folhaFeriasColetivas!);
		});		
	}

	Future<void> insertChildren(FolhaFeriasColetivasGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaFeriasColetivasGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_ferias_coletivas").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}