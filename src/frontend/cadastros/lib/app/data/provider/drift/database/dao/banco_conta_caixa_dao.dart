import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'banco_conta_caixa_dao.g.dart';

@DriftAccessor(tables: [
	BancoContaCaixas,
	BancoAgencias,
])
class BancoContaCaixaDao extends DatabaseAccessor<AppDatabase> with _$BancoContaCaixaDaoMixin {
	final AppDatabase db;

	List<BancoContaCaixa> bancoContaCaixaList = []; 
	List<BancoContaCaixaGrouped> bancoContaCaixaGroupedList = []; 

	BancoContaCaixaDao(this.db) : super(db);

	Future<List<BancoContaCaixa>> getList() async {
		bancoContaCaixaList = await select(bancoContaCaixas).get();
		return bancoContaCaixaList;
	}

	Future<List<BancoContaCaixa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		bancoContaCaixaList = await (select(bancoContaCaixas)..where((t) => expression)).get();
		return bancoContaCaixaList;	 
	}

	Future<List<BancoContaCaixaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(bancoContaCaixas)
			.join([ 
				leftOuterJoin(bancoAgencias, bancoAgencias.id.equalsExp(bancoContaCaixas.idBancoAgencia)), 
			]);

		if (field != null && field != '') { 
			final column = bancoContaCaixas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		bancoContaCaixaGroupedList = await query.map((row) {
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 
			final bancoAgencia = row.readTableOrNull(bancoAgencias); 

			return BancoContaCaixaGrouped(
				bancoContaCaixa: bancoContaCaixa, 
				bancoAgencia: bancoAgencia, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var bancoContaCaixaGrouped in bancoContaCaixaGroupedList) {
		//}		

		return bancoContaCaixaGroupedList;	
	}

	Future<BancoContaCaixa?> getObject(dynamic pk) async {
		return await (select(bancoContaCaixas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<BancoContaCaixa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM banco_conta_caixa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as BancoContaCaixa;		 
	} 

	Future<BancoContaCaixaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(BancoContaCaixaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.bancoContaCaixa = object.bancoContaCaixa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(bancoContaCaixas).insert(object.bancoContaCaixa!);
			object.bancoContaCaixa = object.bancoContaCaixa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(BancoContaCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(bancoContaCaixas).replace(object.bancoContaCaixa!);
		});	 
	} 

	Future<int> deleteObject(BancoContaCaixaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(bancoContaCaixas).delete(object.bancoContaCaixa!);
		});		
	}

	Future<void> insertChildren(BancoContaCaixaGrouped object) async {
	}
	
	Future<void> deleteChildren(BancoContaCaixaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from banco_conta_caixa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}