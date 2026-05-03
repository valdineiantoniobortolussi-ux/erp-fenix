import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';

part 'tribut_configura_of_gt_dao.g.dart';

@DriftAccessor(tables: [
	TributConfiguraOfGts,
	TributIpis,
	TributCofinss,
	TributPiss,
	TributGrupoTributarios,
	TributOperacaoFiscals,
	TributIcmsUfs,
])
class TributConfiguraOfGtDao extends DatabaseAccessor<AppDatabase> with _$TributConfiguraOfGtDaoMixin {
	final AppDatabase db;

	List<TributConfiguraOfGt> tributConfiguraOfGtList = []; 
	List<TributConfiguraOfGtGrouped> tributConfiguraOfGtGroupedList = []; 

	TributConfiguraOfGtDao(this.db) : super(db);

	Future<List<TributConfiguraOfGt>> getList() async {
		tributConfiguraOfGtList = await select(tributConfiguraOfGts).get();
		return tributConfiguraOfGtList;
	}

	Future<List<TributConfiguraOfGt>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tributConfiguraOfGtList = await (select(tributConfiguraOfGts)..where((t) => expression)).get();
		return tributConfiguraOfGtList;	 
	}

	Future<List<TributConfiguraOfGtGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tributConfiguraOfGts)
			.join([ 
				leftOuterJoin(tributIpis, tributIpis.idTributConfiguraOfGt.equalsExp(tributConfiguraOfGts.id)), 
			]).join([ 
				leftOuterJoin(tributCofinss, tributCofinss.idTributConfiguraOfGt.equalsExp(tributConfiguraOfGts.id)), 
			]).join([ 
				leftOuterJoin(tributPiss, tributPiss.idTributConfiguraOfGt.equalsExp(tributConfiguraOfGts.id)), 
			]).join([ 
				leftOuterJoin(tributGrupoTributarios, tributGrupoTributarios.id.equalsExp(tributConfiguraOfGts.idTributGrupoTributario)), 
			]).join([ 
				leftOuterJoin(tributOperacaoFiscals, tributOperacaoFiscals.id.equalsExp(tributConfiguraOfGts.idTributOperacaoFiscal)), 
			]);

		if (field != null && field != '') { 
			final column = tributConfiguraOfGts.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tributConfiguraOfGtGroupedList = await query.map((row) {
			final tributConfiguraOfGt = row.readTableOrNull(tributConfiguraOfGts); 
			final tributIpi = row.readTableOrNull(tributIpis); 
			final tributCofins = row.readTableOrNull(tributCofinss); 
			final tributPis = row.readTableOrNull(tributPiss); 
			final tributGrupoTributario = row.readTableOrNull(tributGrupoTributarios); 
			final tributOperacaoFiscal = row.readTableOrNull(tributOperacaoFiscals); 

			return TributConfiguraOfGtGrouped(
				tributConfiguraOfGt: tributConfiguraOfGt, 
				tributIpi: tributIpi, 
				tributCofins: tributCofins, 
				tributPis: tributPis, 
				tributGrupoTributario: tributGrupoTributario, 
				tributOperacaoFiscal: tributOperacaoFiscal, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var tributConfiguraOfGtGrouped in tributConfiguraOfGtGroupedList) {
			tributConfiguraOfGtGrouped.tributIcmsUfGroupedList = [];
			final queryTributIcmsUf = ' id_tribut_configura_of_gt = ${tributConfiguraOfGtGrouped.tributConfiguraOfGt!.id}';
			expression = CustomExpression<bool>(queryTributIcmsUf);
			final tributIcmsUfList = await (select(tributIcmsUfs)..where((t) => expression)).get();
			for (var tributIcmsUf in tributIcmsUfList) {
				TributIcmsUfGrouped tributIcmsUfGrouped = TributIcmsUfGrouped(
					tributIcmsUf: tributIcmsUf,
				);
				tributConfiguraOfGtGrouped.tributIcmsUfGroupedList!.add(tributIcmsUfGrouped);
			}

		}		

		return tributConfiguraOfGtGroupedList;	
	}

	Future<TributConfiguraOfGt?> getObject(dynamic pk) async {
		return await (select(tributConfiguraOfGts)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TributConfiguraOfGt?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tribut_configura_of_gt WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TributConfiguraOfGt;		 
	} 

	Future<TributConfiguraOfGtGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TributConfiguraOfGtGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tributConfiguraOfGt = object.tributConfiguraOfGt!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tributConfiguraOfGts).insert(object.tributConfiguraOfGt!);
			object.tributConfiguraOfGt = object.tributConfiguraOfGt!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TributConfiguraOfGtGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tributConfiguraOfGts).replace(object.tributConfiguraOfGt!);
		});	 
	} 

	Future<int> deleteObject(TributConfiguraOfGtGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tributConfiguraOfGts).delete(object.tributConfiguraOfGt!);
		});		
	}

	Future<void> insertChildren(TributConfiguraOfGtGrouped object) async {
		object.tributIpi = object.tributIpi!.copyWith(idTributConfiguraOfGt: Value(object.tributConfiguraOfGt!.id));
		await into(tributIpis).insert(object.tributIpi!);
		object.tributCofins = object.tributCofins!.copyWith(idTributConfiguraOfGt: Value(object.tributConfiguraOfGt!.id));
		await into(tributCofinss).insert(object.tributCofins!);
		object.tributPis = object.tributPis!.copyWith(idTributConfiguraOfGt: Value(object.tributConfiguraOfGt!.id));
		await into(tributPiss).insert(object.tributPis!);
		for (var tributIcmsUfGrouped in object.tributIcmsUfGroupedList!) {
			tributIcmsUfGrouped.tributIcmsUf = tributIcmsUfGrouped.tributIcmsUf?.copyWith(
				id: const Value(null),
				idTributConfiguraOfGt: Value(object.tributConfiguraOfGt!.id),
			);
			await into(tributIcmsUfs).insert(tributIcmsUfGrouped.tributIcmsUf!);
		}
	}
	
	Future<void> deleteChildren(TributConfiguraOfGtGrouped object) async {
		await (delete(tributIpis)..where((t) => t.idTributConfiguraOfGt.equals(object.tributConfiguraOfGt!.id!))).go();
		await (delete(tributCofinss)..where((t) => t.idTributConfiguraOfGt.equals(object.tributConfiguraOfGt!.id!))).go();
		await (delete(tributPiss)..where((t) => t.idTributConfiguraOfGt.equals(object.tributConfiguraOfGt!.id!))).go();
		await (delete(tributIcmsUfs)..where((t) => t.idTributConfiguraOfGt.equals(object.tributConfiguraOfGt!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tribut_configura_of_gt").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}