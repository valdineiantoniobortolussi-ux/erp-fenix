import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_extrato_conta_banco_dao.g.dart';

@DriftAccessor(tables: [
	FinExtratoContaBancos,
	BancoContaCaixas,
])
class FinExtratoContaBancoDao extends DatabaseAccessor<AppDatabase> with _$FinExtratoContaBancoDaoMixin {
	final AppDatabase db;

	List<FinExtratoContaBanco> finExtratoContaBancoList = []; 
	List<FinExtratoContaBancoGrouped> finExtratoContaBancoGroupedList = []; 

	FinExtratoContaBancoDao(this.db) : super(db);

	Future<List<FinExtratoContaBanco>> getList() async {
		finExtratoContaBancoList = await select(finExtratoContaBancos).get();
		return finExtratoContaBancoList;
	}

	Future<List<FinExtratoContaBanco>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finExtratoContaBancoList = await (select(finExtratoContaBancos)..where((t) => expression)).get();
		return finExtratoContaBancoList;	 
	}

	Future<List<FinExtratoContaBancoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finExtratoContaBancos)
			.join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(finExtratoContaBancos.idBancoContaCaixa)), 
			]);

		if (field != null && field != '') { 
			final column = finExtratoContaBancos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finExtratoContaBancoGroupedList = await query.map((row) {
			final finExtratoContaBanco = row.readTableOrNull(finExtratoContaBancos); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 

			return FinExtratoContaBancoGrouped(
				finExtratoContaBanco: finExtratoContaBanco, 
				bancoContaCaixa: bancoContaCaixa, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finExtratoContaBancoGrouped in finExtratoContaBancoGroupedList) {
		//}		

		return finExtratoContaBancoGroupedList;	
	}

	Future<FinExtratoContaBanco?> getObject(dynamic pk) async {
		return await (select(finExtratoContaBancos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinExtratoContaBanco?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_extrato_conta_banco WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinExtratoContaBanco;		 
	} 

	Future<FinExtratoContaBancoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinExtratoContaBancoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finExtratoContaBanco = object.finExtratoContaBanco!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finExtratoContaBancos).insert(object.finExtratoContaBanco!);
			object.finExtratoContaBanco = object.finExtratoContaBanco!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinExtratoContaBancoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finExtratoContaBancos).replace(object.finExtratoContaBanco!);
		});	 
	} 

	Future<int> deleteObject(FinExtratoContaBancoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finExtratoContaBancos).delete(object.finExtratoContaBanco!);
		});		
	}

	Future<void> insertChildren(FinExtratoContaBancoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinExtratoContaBancoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_extrato_conta_banco").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}