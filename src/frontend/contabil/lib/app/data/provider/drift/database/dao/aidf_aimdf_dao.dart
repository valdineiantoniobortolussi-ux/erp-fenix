import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'aidf_aimdf_dao.g.dart';

@DriftAccessor(tables: [
	AidfAimdfs,
])
class AidfAimdfDao extends DatabaseAccessor<AppDatabase> with _$AidfAimdfDaoMixin {
	final AppDatabase db;

	List<AidfAimdf> aidfAimdfList = []; 
	List<AidfAimdfGrouped> aidfAimdfGroupedList = []; 

	AidfAimdfDao(this.db) : super(db);

	Future<List<AidfAimdf>> getList() async {
		aidfAimdfList = await select(aidfAimdfs).get();
		return aidfAimdfList;
	}

	Future<List<AidfAimdf>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		aidfAimdfList = await (select(aidfAimdfs)..where((t) => expression)).get();
		return aidfAimdfList;	 
	}

	Future<List<AidfAimdfGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(aidfAimdfs)
			.join([]);

		if (field != null && field != '') { 
			final column = aidfAimdfs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		aidfAimdfGroupedList = await query.map((row) {
			final aidfAimdf = row.readTableOrNull(aidfAimdfs); 

			return AidfAimdfGrouped(
				aidfAimdf: aidfAimdf, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var aidfAimdfGrouped in aidfAimdfGroupedList) {
		//}		

		return aidfAimdfGroupedList;	
	}

	Future<AidfAimdf?> getObject(dynamic pk) async {
		return await (select(aidfAimdfs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<AidfAimdf?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM aidf_aimdf WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as AidfAimdf;		 
	} 

	Future<AidfAimdfGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(AidfAimdfGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.aidfAimdf = object.aidfAimdf!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(aidfAimdfs).insert(object.aidfAimdf!);
			object.aidfAimdf = object.aidfAimdf!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(AidfAimdfGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(aidfAimdfs).replace(object.aidfAimdf!);
		});	 
	} 

	Future<int> deleteObject(AidfAimdfGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(aidfAimdfs).delete(object.aidfAimdf!);
		});		
	}

	Future<void> insertChildren(AidfAimdfGrouped object) async {
	}
	
	Future<void> deleteChildren(AidfAimdfGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from aidf_aimdf").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}