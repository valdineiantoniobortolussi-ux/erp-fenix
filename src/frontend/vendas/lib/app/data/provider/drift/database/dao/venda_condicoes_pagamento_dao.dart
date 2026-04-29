import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

part 'venda_condicoes_pagamento_dao.g.dart';

@DriftAccessor(tables: [
	VendaCondicoesPagamentos,
	VendaCondicoesParcelass,
])
class VendaCondicoesPagamentoDao extends DatabaseAccessor<AppDatabase> with _$VendaCondicoesPagamentoDaoMixin {
	final AppDatabase db;

	List<VendaCondicoesPagamento> vendaCondicoesPagamentoList = []; 
	List<VendaCondicoesPagamentoGrouped> vendaCondicoesPagamentoGroupedList = []; 

	VendaCondicoesPagamentoDao(this.db) : super(db);

	Future<List<VendaCondicoesPagamento>> getList() async {
		vendaCondicoesPagamentoList = await select(vendaCondicoesPagamentos).get();
		return vendaCondicoesPagamentoList;
	}

	Future<List<VendaCondicoesPagamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		vendaCondicoesPagamentoList = await (select(vendaCondicoesPagamentos)..where((t) => expression)).get();
		return vendaCondicoesPagamentoList;	 
	}

	Future<List<VendaCondicoesPagamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(vendaCondicoesPagamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = vendaCondicoesPagamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		vendaCondicoesPagamentoGroupedList = await query.map((row) {
			final vendaCondicoesPagamento = row.readTableOrNull(vendaCondicoesPagamentos); 

			return VendaCondicoesPagamentoGrouped(
				vendaCondicoesPagamento: vendaCondicoesPagamento, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var vendaCondicoesPagamentoGrouped in vendaCondicoesPagamentoGroupedList) {
			vendaCondicoesPagamentoGrouped.vendaCondicoesParcelasGroupedList = [];
			final queryVendaCondicoesParcelas = ' id_venda_condicoes_pagamento = ${vendaCondicoesPagamentoGrouped.vendaCondicoesPagamento!.id}';
			expression = CustomExpression<bool>(queryVendaCondicoesParcelas);
			final vendaCondicoesParcelasList = await (select(vendaCondicoesParcelass)..where((t) => expression)).get();
			for (var vendaCondicoesParcelas in vendaCondicoesParcelasList) {
				VendaCondicoesParcelasGrouped vendaCondicoesParcelasGrouped = VendaCondicoesParcelasGrouped(
					vendaCondicoesParcelas: vendaCondicoesParcelas,
				);
				vendaCondicoesPagamentoGrouped.vendaCondicoesParcelasGroupedList!.add(vendaCondicoesParcelasGrouped);
			}

		}		

		return vendaCondicoesPagamentoGroupedList;	
	}

	Future<VendaCondicoesPagamento?> getObject(dynamic pk) async {
		return await (select(vendaCondicoesPagamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<VendaCondicoesPagamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM venda_condicoes_pagamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as VendaCondicoesPagamento;		 
	} 

	Future<VendaCondicoesPagamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(VendaCondicoesPagamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.vendaCondicoesPagamento = object.vendaCondicoesPagamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(vendaCondicoesPagamentos).insert(object.vendaCondicoesPagamento!);
			object.vendaCondicoesPagamento = object.vendaCondicoesPagamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(VendaCondicoesPagamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(vendaCondicoesPagamentos).replace(object.vendaCondicoesPagamento!);
		});	 
	} 

	Future<int> deleteObject(VendaCondicoesPagamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(vendaCondicoesPagamentos).delete(object.vendaCondicoesPagamento!);
		});		
	}

	Future<void> insertChildren(VendaCondicoesPagamentoGrouped object) async {
		for (var vendaCondicoesParcelasGrouped in object.vendaCondicoesParcelasGroupedList!) {
			vendaCondicoesParcelasGrouped.vendaCondicoesParcelas = vendaCondicoesParcelasGrouped.vendaCondicoesParcelas?.copyWith(
				id: const Value(null),
				idVendaCondicoesPagamento: Value(object.vendaCondicoesPagamento!.id),
			);
			await into(vendaCondicoesParcelass).insert(vendaCondicoesParcelasGrouped.vendaCondicoesParcelas!);
		}
	}
	
	Future<void> deleteChildren(VendaCondicoesPagamentoGrouped object) async {
		await (delete(vendaCondicoesParcelass)..where((t) => t.idVendaCondicoesPagamento.equals(object.vendaCondicoesPagamento!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from venda_condicoes_pagamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}