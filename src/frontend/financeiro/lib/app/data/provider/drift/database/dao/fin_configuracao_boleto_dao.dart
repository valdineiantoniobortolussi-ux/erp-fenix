import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_configuracao_boleto_dao.g.dart';

@DriftAccessor(tables: [
	FinConfiguracaoBoletos,
	BancoContaCaixas,
])
class FinConfiguracaoBoletoDao extends DatabaseAccessor<AppDatabase> with _$FinConfiguracaoBoletoDaoMixin {
	final AppDatabase db;

	List<FinConfiguracaoBoleto> finConfiguracaoBoletoList = []; 
	List<FinConfiguracaoBoletoGrouped> finConfiguracaoBoletoGroupedList = []; 

	FinConfiguracaoBoletoDao(this.db) : super(db);

	Future<List<FinConfiguracaoBoleto>> getList() async {
		finConfiguracaoBoletoList = await select(finConfiguracaoBoletos).get();
		return finConfiguracaoBoletoList;
	}

	Future<List<FinConfiguracaoBoleto>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finConfiguracaoBoletoList = await (select(finConfiguracaoBoletos)..where((t) => expression)).get();
		return finConfiguracaoBoletoList;	 
	}

	Future<List<FinConfiguracaoBoletoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finConfiguracaoBoletos)
			.join([ 
				leftOuterJoin(bancoContaCaixas, bancoContaCaixas.id.equalsExp(finConfiguracaoBoletos.idBancoContaCaixa)), 
			]);

		if (field != null && field != '') { 
			final column = finConfiguracaoBoletos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finConfiguracaoBoletoGroupedList = await query.map((row) {
			final finConfiguracaoBoleto = row.readTableOrNull(finConfiguracaoBoletos); 
			final bancoContaCaixa = row.readTableOrNull(bancoContaCaixas); 

			return FinConfiguracaoBoletoGrouped(
				finConfiguracaoBoleto: finConfiguracaoBoleto, 
				bancoContaCaixa: bancoContaCaixa, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finConfiguracaoBoletoGrouped in finConfiguracaoBoletoGroupedList) {
		//}		

		return finConfiguracaoBoletoGroupedList;	
	}

	Future<FinConfiguracaoBoleto?> getObject(dynamic pk) async {
		return await (select(finConfiguracaoBoletos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinConfiguracaoBoleto?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_configuracao_boleto WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinConfiguracaoBoleto;		 
	} 

	Future<FinConfiguracaoBoletoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinConfiguracaoBoletoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finConfiguracaoBoleto = object.finConfiguracaoBoleto!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finConfiguracaoBoletos).insert(object.finConfiguracaoBoleto!);
			object.finConfiguracaoBoleto = object.finConfiguracaoBoleto!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinConfiguracaoBoletoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finConfiguracaoBoletos).replace(object.finConfiguracaoBoleto!);
		});	 
	} 

	Future<int> deleteObject(FinConfiguracaoBoletoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finConfiguracaoBoletos).delete(object.finConfiguracaoBoleto!);
		});		
	}

	Future<void> insertChildren(FinConfiguracaoBoletoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinConfiguracaoBoletoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_configuracao_boleto").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}