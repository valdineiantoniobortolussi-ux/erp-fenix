import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_fechamento_caixa_banco_dao.g.dart';

@DriftAccessor(tables: [
	FinFechamentoCaixaBancos,
	BancoContaCaixas,
])
class FinFechamentoCaixaBancoDao extends DatabaseAccessor<AppDatabase> with _$FinFechamentoCaixaBancoDaoMixin {
	final AppDatabase db;

	List<FinFechamentoCaixaBanco> finFechamentoCaixaBancoList = []; 
	List<FinFechamentoCaixaBancoGrouped> finFechamentoCaixaBancoGroupedList = []; 

	FinFechamentoCaixaBancoDao(this.db) : super(db);

	Future<List<FinFechamentoCaixaBanco>> getList() async {
		finFechamentoCaixaBancoList = await select(finFechamentoCaixaBancos).get();
		return finFechamentoCaixaBancoList;
	}

	Future<List<FinFechamentoCaixaBanco>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finFechamentoCaixaBancoList = await (select(finFechamentoCaixaBancos)..where((t) => expression)).get();
		return finFechamentoCaixaBancoList;	 
	}

	Future<List<FinFechamentoCaixaBancoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finFechamentoCaixaBancos)
			.join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(finFechamentoCaixaBancos.idBancoContaCaixa)), 
			]);

		if (field != null && field != '') { 
			final column = finFechamentoCaixaBancos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finFechamentoCaixaBancoGroupedList = await query.map((row) {
			final finFechamentoCaixaBanco = row.readTableOrNull(finFechamentoCaixaBancos); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 

			return FinFechamentoCaixaBancoGrouped(
				finFechamentoCaixaBanco: finFechamentoCaixaBanco, 
				bancoContaCaixa: bancoContaCaixa, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finFechamentoCaixaBancoGrouped in finFechamentoCaixaBancoGroupedList) {
		//}		

		return finFechamentoCaixaBancoGroupedList;	
	}

	Future<FinFechamentoCaixaBanco?> getObject(dynamic pk) async {
		return await (select(finFechamentoCaixaBancos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinFechamentoCaixaBanco?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_fechamento_caixa_banco WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinFechamentoCaixaBanco;		 
	} 

	Future<FinFechamentoCaixaBancoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinFechamentoCaixaBancoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finFechamentoCaixaBanco = object.finFechamentoCaixaBanco!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finFechamentoCaixaBancos).insert(object.finFechamentoCaixaBanco!);
			object.finFechamentoCaixaBanco = object.finFechamentoCaixaBanco!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinFechamentoCaixaBancoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finFechamentoCaixaBancos).replace(object.finFechamentoCaixaBanco!);
		});	 
	} 

	Future<int> deleteObject(FinFechamentoCaixaBancoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finFechamentoCaixaBancos).delete(object.finFechamentoCaixaBanco!);
		});		
	}

	Future<void> insertChildren(FinFechamentoCaixaBancoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinFechamentoCaixaBancoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_fechamento_caixa_banco").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}