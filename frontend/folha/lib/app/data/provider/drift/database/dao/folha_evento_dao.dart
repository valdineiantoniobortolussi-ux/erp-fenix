import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_evento_dao.g.dart';

@DriftAccessor(tables: [
	FolhaEventos,
])
class FolhaEventoDao extends DatabaseAccessor<AppDatabase> with _$FolhaEventoDaoMixin {
	final AppDatabase db;

	List<FolhaEvento> folhaEventoList = []; 
	List<FolhaEventoGrouped> folhaEventoGroupedList = []; 

	FolhaEventoDao(this.db) : super(db);

	Future<List<FolhaEvento>> getList() async {
		folhaEventoList = await select(folhaEventos).get();
		return folhaEventoList;
	}

	Future<List<FolhaEvento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaEventoList = await (select(folhaEventos)..where((t) => expression)).get();
		return folhaEventoList;	 
	}

	Future<List<FolhaEventoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaEventos)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaEventos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaEventoGroupedList = await query.map((row) {
			final folhaEvento = row.readTableOrNull(folhaEventos); 

			return FolhaEventoGrouped(
				folhaEvento: folhaEvento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaEventoGrouped in folhaEventoGroupedList) {
		//}		

		return folhaEventoGroupedList;	
	}

	Future<FolhaEvento?> getObject(dynamic pk) async {
		return await (select(folhaEventos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaEvento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_evento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaEvento;		 
	} 

	Future<FolhaEventoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaEventoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaEvento = object.folhaEvento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaEventos).insert(object.folhaEvento!);
			object.folhaEvento = object.folhaEvento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaEventoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaEventos).replace(object.folhaEvento!);
		});	 
	} 

	Future<int> deleteObject(FolhaEventoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaEventos).delete(object.folhaEvento!);
		});		
	}

	Future<void> insertChildren(FolhaEventoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaEventoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_evento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}