import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_inss_dao.g.dart';

@DriftAccessor(tables: [
	FolhaInsss,
	FolhaInssRetencaos,
	FolhaInssServicos,
])
class FolhaInssDao extends DatabaseAccessor<AppDatabase> with _$FolhaInssDaoMixin {
	final AppDatabase db;

	List<FolhaInss> folhaInssList = []; 
	List<FolhaInssGrouped> folhaInssGroupedList = []; 

	FolhaInssDao(this.db) : super(db);

	Future<List<FolhaInss>> getList() async {
		folhaInssList = await select(folhaInsss).get();
		return folhaInssList;
	}

	Future<List<FolhaInss>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaInssList = await (select(folhaInsss)..where((t) => expression)).get();
		return folhaInssList;	 
	}

	Future<List<FolhaInssGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaInsss)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaInsss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaInssGroupedList = await query.map((row) {
			final folhaInss = row.readTableOrNull(folhaInsss); 

			return FolhaInssGrouped(
				folhaInss: folhaInss, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var folhaInssGrouped in folhaInssGroupedList) {
			folhaInssGrouped.folhaInssRetencaoGroupedList = [];
			final queryFolhaInssRetencao = ' id_folha_inss = ${folhaInssGrouped.folhaInss!.id}';
			expression = CustomExpression<bool>(queryFolhaInssRetencao);
			final folhaInssRetencaoList = await (select(folhaInssRetencaos)..where((t) => expression)).get();
			for (var folhaInssRetencao in folhaInssRetencaoList) {
				FolhaInssRetencaoGrouped folhaInssRetencaoGrouped = FolhaInssRetencaoGrouped(
					folhaInssRetencao: folhaInssRetencao,
					folhaInssServico: await (select(folhaInssServicos)..where((t) => t.id.equals(folhaInssRetencao.idFolhaInssServico!))).getSingleOrNull(),
				);
				folhaInssGrouped.folhaInssRetencaoGroupedList!.add(folhaInssRetencaoGrouped);
			}

		}		

		return folhaInssGroupedList;	
	}

	Future<FolhaInss?> getObject(dynamic pk) async {
		return await (select(folhaInsss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaInss?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_inss WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaInss;		 
	} 

	Future<FolhaInssGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaInssGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaInss = object.folhaInss!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaInsss).insert(object.folhaInss!);
			object.folhaInss = object.folhaInss!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaInssGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaInsss).replace(object.folhaInss!);
		});	 
	} 

	Future<int> deleteObject(FolhaInssGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaInsss).delete(object.folhaInss!);
		});		
	}

	Future<void> insertChildren(FolhaInssGrouped object) async {
		for (var folhaInssRetencaoGrouped in object.folhaInssRetencaoGroupedList!) {
			folhaInssRetencaoGrouped.folhaInssRetencao = folhaInssRetencaoGrouped.folhaInssRetencao?.copyWith(
				id: const Value(null),
				idFolhaInss: Value(object.folhaInss!.id),
			);
			await into(folhaInssRetencaos).insert(folhaInssRetencaoGrouped.folhaInssRetencao!);
		}
	}
	
	Future<void> deleteChildren(FolhaInssGrouped object) async {
		await (delete(folhaInssRetencaos)..where((t) => t.idFolhaInss.equals(object.folhaInss!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_inss").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}