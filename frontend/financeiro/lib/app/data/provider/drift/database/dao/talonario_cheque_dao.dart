import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'talonario_cheque_dao.g.dart';

@DriftAccessor(tables: [
	TalonarioCheques,
	Cheques,
	BancoContaCaixas,
])
class TalonarioChequeDao extends DatabaseAccessor<AppDatabase> with _$TalonarioChequeDaoMixin {
	final AppDatabase db;

	List<TalonarioCheque> talonarioChequeList = []; 
	List<TalonarioChequeGrouped> talonarioChequeGroupedList = []; 

	TalonarioChequeDao(this.db) : super(db);

	Future<List<TalonarioCheque>> getList() async {
		talonarioChequeList = await select(talonarioCheques).get();
		return talonarioChequeList;
	}

	Future<List<TalonarioCheque>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		talonarioChequeList = await (select(talonarioCheques)..where((t) => expression)).get();
		return talonarioChequeList;	 
	}

	Future<List<TalonarioChequeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(talonarioCheques)
			.join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(talonarioCheques.idBancoContaCaixa)), 
			]);

		if (field != null && field != '') { 
			final column = talonarioCheques.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		talonarioChequeGroupedList = await query.map((row) {
			final talonarioCheque = row.readTableOrNull(talonarioCheques); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 

			return TalonarioChequeGrouped(
				talonarioCheque: talonarioCheque, 
				bancoContaCaixa: bancoContaCaixa, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var talonarioChequeGrouped in talonarioChequeGroupedList) {
			talonarioChequeGrouped.chequeGroupedList = [];
			final queryCheque = ' id_talonario_cheque = ${talonarioChequeGrouped.talonarioCheque!.id}';
			expression = CustomExpression<bool>(queryCheque);
			final chequeList = await (select(cheques)..where((t) => expression)).get();
			for (var cheque in chequeList) {
				ChequeGrouped chequeGrouped = ChequeGrouped(
					cheque: cheque,
				);
				talonarioChequeGrouped.chequeGroupedList!.add(chequeGrouped);
			}

		}		

		return talonarioChequeGroupedList;	
	}

	Future<TalonarioCheque?> getObject(dynamic pk) async {
		return await (select(talonarioCheques)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TalonarioCheque?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM talonario_cheque WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TalonarioCheque;		 
	} 

	Future<TalonarioChequeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TalonarioChequeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.talonarioCheque = object.talonarioCheque!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(talonarioCheques).insert(object.talonarioCheque!);
			object.talonarioCheque = object.talonarioCheque!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TalonarioChequeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(talonarioCheques).replace(object.talonarioCheque!);
		});	 
	} 

	Future<int> deleteObject(TalonarioChequeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(talonarioCheques).delete(object.talonarioCheque!);
		});		
	}

	Future<void> insertChildren(TalonarioChequeGrouped object) async {
		for (var chequeGrouped in object.chequeGroupedList!) {
			chequeGrouped.cheque = chequeGrouped.cheque?.copyWith(
				id: const Value(null),
				idTalonarioCheque: Value(object.talonarioCheque!.id),
			);
			await into(cheques).insert(chequeGrouped.cheque!);
		}
	}
	
	Future<void> deleteChildren(TalonarioChequeGrouped object) async {
		await (delete(cheques)..where((t) => t.idTalonarioCheque.equals(object.talonarioCheque!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from talonario_cheque").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}