import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_ppp_dao.g.dart';

@DriftAccessor(tables: [
	FolhaPpps,
	FolhaPppCats,
	FolhaPppAtividades,
	FolhaPppFatorRiscos,
	FolhaPppExameMedicos,
	ViewPessoaColaboradors,
])
class FolhaPppDao extends DatabaseAccessor<AppDatabase> with _$FolhaPppDaoMixin {
	final AppDatabase db;

	List<FolhaPpp> folhaPppList = []; 
	List<FolhaPppGrouped> folhaPppGroupedList = []; 

	FolhaPppDao(this.db) : super(db);

	Future<List<FolhaPpp>> getList() async {
		folhaPppList = await select(folhaPpps).get();
		return folhaPppList;
	}

	Future<List<FolhaPpp>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaPppList = await (select(folhaPpps)..where((t) => expression)).get();
		return folhaPppList;	 
	}

	Future<List<FolhaPppGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaPpps)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaPpps.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = folhaPpps.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaPppGroupedList = await query.map((row) {
			final folhaPpp = row.readTableOrNull(folhaPpps); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FolhaPppGrouped(
				folhaPpp: folhaPpp, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var folhaPppGrouped in folhaPppGroupedList) {
			folhaPppGrouped.folhaPppCatGroupedList = [];
			final queryFolhaPppCat = ' id_folha_ppp = ${folhaPppGrouped.folhaPpp!.id}';
			expression = CustomExpression<bool>(queryFolhaPppCat);
			final folhaPppCatList = await (select(folhaPppCats)..where((t) => expression)).get();
			for (var folhaPppCat in folhaPppCatList) {
				FolhaPppCatGrouped folhaPppCatGrouped = FolhaPppCatGrouped(
					folhaPppCat: folhaPppCat,
				);
				folhaPppGrouped.folhaPppCatGroupedList!.add(folhaPppCatGrouped);
			}

			folhaPppGrouped.folhaPppAtividadeGroupedList = [];
			final queryFolhaPppAtividade = ' id_folha_ppp = ${folhaPppGrouped.folhaPpp!.id}';
			expression = CustomExpression<bool>(queryFolhaPppAtividade);
			final folhaPppAtividadeList = await (select(folhaPppAtividades)..where((t) => expression)).get();
			for (var folhaPppAtividade in folhaPppAtividadeList) {
				FolhaPppAtividadeGrouped folhaPppAtividadeGrouped = FolhaPppAtividadeGrouped(
					folhaPppAtividade: folhaPppAtividade,
				);
				folhaPppGrouped.folhaPppAtividadeGroupedList!.add(folhaPppAtividadeGrouped);
			}

			folhaPppGrouped.folhaPppFatorRiscoGroupedList = [];
			final queryFolhaPppFatorRisco = ' id_folha_ppp = ${folhaPppGrouped.folhaPpp!.id}';
			expression = CustomExpression<bool>(queryFolhaPppFatorRisco);
			final folhaPppFatorRiscoList = await (select(folhaPppFatorRiscos)..where((t) => expression)).get();
			for (var folhaPppFatorRisco in folhaPppFatorRiscoList) {
				FolhaPppFatorRiscoGrouped folhaPppFatorRiscoGrouped = FolhaPppFatorRiscoGrouped(
					folhaPppFatorRisco: folhaPppFatorRisco,
				);
				folhaPppGrouped.folhaPppFatorRiscoGroupedList!.add(folhaPppFatorRiscoGrouped);
			}

			folhaPppGrouped.folhaPppExameMedicoGroupedList = [];
			final queryFolhaPppExameMedico = ' id_folha_ppp = ${folhaPppGrouped.folhaPpp!.id}';
			expression = CustomExpression<bool>(queryFolhaPppExameMedico);
			final folhaPppExameMedicoList = await (select(folhaPppExameMedicos)..where((t) => expression)).get();
			for (var folhaPppExameMedico in folhaPppExameMedicoList) {
				FolhaPppExameMedicoGrouped folhaPppExameMedicoGrouped = FolhaPppExameMedicoGrouped(
					folhaPppExameMedico: folhaPppExameMedico,
				);
				folhaPppGrouped.folhaPppExameMedicoGroupedList!.add(folhaPppExameMedicoGrouped);
			}

		}		

		return folhaPppGroupedList;	
	}

	Future<FolhaPpp?> getObject(dynamic pk) async {
		return await (select(folhaPpps)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaPpp?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_ppp WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaPpp;		 
	} 

	Future<FolhaPppGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaPppGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaPpp = object.folhaPpp!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaPpps).insert(object.folhaPpp!);
			object.folhaPpp = object.folhaPpp!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaPppGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaPpps).replace(object.folhaPpp!);
		});	 
	} 

	Future<int> deleteObject(FolhaPppGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaPpps).delete(object.folhaPpp!);
		});		
	}

	Future<void> insertChildren(FolhaPppGrouped object) async {
		for (var folhaPppCatGrouped in object.folhaPppCatGroupedList!) {
			folhaPppCatGrouped.folhaPppCat = folhaPppCatGrouped.folhaPppCat?.copyWith(
				id: const Value(null),
				idFolhaPpp: Value(object.folhaPpp!.id),
			);
			await into(folhaPppCats).insert(folhaPppCatGrouped.folhaPppCat!);
		}
		for (var folhaPppAtividadeGrouped in object.folhaPppAtividadeGroupedList!) {
			folhaPppAtividadeGrouped.folhaPppAtividade = folhaPppAtividadeGrouped.folhaPppAtividade?.copyWith(
				id: const Value(null),
				idFolhaPpp: Value(object.folhaPpp!.id),
			);
			await into(folhaPppAtividades).insert(folhaPppAtividadeGrouped.folhaPppAtividade!);
		}
		for (var folhaPppFatorRiscoGrouped in object.folhaPppFatorRiscoGroupedList!) {
			folhaPppFatorRiscoGrouped.folhaPppFatorRisco = folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.copyWith(
				id: const Value(null),
				idFolhaPpp: Value(object.folhaPpp!.id),
			);
			await into(folhaPppFatorRiscos).insert(folhaPppFatorRiscoGrouped.folhaPppFatorRisco!);
		}
		for (var folhaPppExameMedicoGrouped in object.folhaPppExameMedicoGroupedList!) {
			folhaPppExameMedicoGrouped.folhaPppExameMedico = folhaPppExameMedicoGrouped.folhaPppExameMedico?.copyWith(
				id: const Value(null),
				idFolhaPpp: Value(object.folhaPpp!.id),
			);
			await into(folhaPppExameMedicos).insert(folhaPppExameMedicoGrouped.folhaPppExameMedico!);
		}
	}
	
	Future<void> deleteChildren(FolhaPppGrouped object) async {
		await (delete(folhaPppCats)..where((t) => t.idFolhaPpp.equals(object.folhaPpp!.id!))).go();
		await (delete(folhaPppAtividades)..where((t) => t.idFolhaPpp.equals(object.folhaPpp!.id!))).go();
		await (delete(folhaPppFatorRiscos)..where((t) => t.idFolhaPpp.equals(object.folhaPpp!.id!))).go();
		await (delete(folhaPppExameMedicos)..where((t) => t.idFolhaPpp.equals(object.folhaPpp!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_ppp").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}