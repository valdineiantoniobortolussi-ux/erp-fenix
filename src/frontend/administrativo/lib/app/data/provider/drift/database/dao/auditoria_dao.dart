import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';

part 'auditoria_dao.g.dart';

@DriftAccessor(tables: [
	Auditorias,
])
class AuditoriaDao extends DatabaseAccessor<AppDatabase> with _$AuditoriaDaoMixin {
	final AppDatabase db;

	List<Auditoria> auditoriaList = []; 
	List<AuditoriaGrouped> auditoriaGroupedList = []; 

	AuditoriaDao(this.db) : super(db);

	Future<List<Auditoria>> getList() async {
		auditoriaList = await select(auditorias).get();
		return auditoriaList;
	}

	Future<List<Auditoria>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		auditoriaList = await (select(auditorias)..where((t) => expression)).get();
		return auditoriaList;	 
	}

	Future<List<AuditoriaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(auditorias)
			.join([]);

		if (field != null && field != '') { 
			final column = auditorias.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		auditoriaGroupedList = await query.map((row) {
			final auditoria = row.readTableOrNull(auditorias); 

			return AuditoriaGrouped(
				auditoria: auditoria, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var auditoriaGrouped in auditoriaGroupedList) {
		//}		

		return auditoriaGroupedList;	
	}

	Future<Auditoria?> getObject(dynamic pk) async {
		return await (select(auditorias)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Auditoria?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM auditoria WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Auditoria;		 
	} 

	Future<AuditoriaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(AuditoriaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.auditoria = object.auditoria!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(auditorias).insert(object.auditoria!);
			object.auditoria = object.auditoria!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(AuditoriaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(auditorias).replace(object.auditoria!);
		});	 
	} 

	Future<int> deleteObject(AuditoriaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(auditorias).delete(object.auditoria!);
		});		
	}

	Future<void> insertChildren(AuditoriaGrouped object) async {
	}
	
	Future<void> deleteChildren(AuditoriaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from auditoria").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}