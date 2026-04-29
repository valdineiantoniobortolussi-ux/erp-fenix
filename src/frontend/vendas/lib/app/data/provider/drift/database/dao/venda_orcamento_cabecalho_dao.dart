import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

part 'venda_orcamento_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	VendaOrcamentoCabecalhos,
	VendaOrcamentoDetalhes,
	Produtos,
	VendaCondicoesPagamentos,
	ViewPessoaVendedors,
	ViewPessoaTransportadoras,
	ViewPessoaClientes,
])
class VendaOrcamentoCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$VendaOrcamentoCabecalhoDaoMixin {
	final AppDatabase db;

	List<VendaOrcamentoCabecalho> vendaOrcamentoCabecalhoList = []; 
	List<VendaOrcamentoCabecalhoGrouped> vendaOrcamentoCabecalhoGroupedList = []; 

	VendaOrcamentoCabecalhoDao(this.db) : super(db);

	Future<List<VendaOrcamentoCabecalho>> getList() async {
		vendaOrcamentoCabecalhoList = await select(vendaOrcamentoCabecalhos).get();
		return vendaOrcamentoCabecalhoList;
	}

	Future<List<VendaOrcamentoCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		vendaOrcamentoCabecalhoList = await (select(vendaOrcamentoCabecalhos)..where((t) => expression)).get();
		return vendaOrcamentoCabecalhoList;	 
	}

	Future<List<VendaOrcamentoCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(vendaOrcamentoCabecalhos)
			.join([ 
				leftOuterJoin(vendaCondicoesPagamentos, vendaCondicoesPagamentos.id.equalsExp(vendaOrcamentoCabecalhos.idVendaCondicoesPagamento)), 
			]).join([ 
				leftOuterJoin(viewPessoaVendedors, viewPessoaVendedors.id.equalsExp(vendaOrcamentoCabecalhos.idVendedor)), 
			]).join([ 
				leftOuterJoin(viewPessoaTransportadoras, viewPessoaTransportadoras.id.equalsExp(vendaOrcamentoCabecalhos.idTransportadora)), 
			]).join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(vendaOrcamentoCabecalhos.idCliente)), 
			]);

		if (field != null && field != '') { 
			final column = vendaOrcamentoCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		vendaOrcamentoCabecalhoGroupedList = await query.map((row) {
			final vendaOrcamentoCabecalho = row.readTableOrNull(vendaOrcamentoCabecalhos); 
			final vendaCondicoesPagamento = row.readTableOrNull(vendaCondicoesPagamentos); 
			final viewPessoaVendedor = row.readTableOrNull(viewPessoaVendedors); 
			final viewPessoaTransportadora = row.readTableOrNull(viewPessoaTransportadoras); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 

			return VendaOrcamentoCabecalhoGrouped(
				vendaOrcamentoCabecalho: vendaOrcamentoCabecalho, 
				vendaCondicoesPagamento: vendaCondicoesPagamento, 
				viewPessoaVendedor: viewPessoaVendedor, 
				viewPessoaTransportadora: viewPessoaTransportadora, 
				viewPessoaCliente: viewPessoaCliente, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var vendaOrcamentoCabecalhoGrouped in vendaOrcamentoCabecalhoGroupedList) {
			vendaOrcamentoCabecalhoGrouped.vendaOrcamentoDetalheGroupedList = [];
			final queryVendaOrcamentoDetalhe = ' id_venda_orcamento_cabecalho = ${vendaOrcamentoCabecalhoGrouped.vendaOrcamentoCabecalho!.id}';
			expression = CustomExpression<bool>(queryVendaOrcamentoDetalhe);
			final vendaOrcamentoDetalheList = await (select(vendaOrcamentoDetalhes)..where((t) => expression)).get();
			for (var vendaOrcamentoDetalhe in vendaOrcamentoDetalheList) {
				VendaOrcamentoDetalheGrouped vendaOrcamentoDetalheGrouped = VendaOrcamentoDetalheGrouped(
					vendaOrcamentoDetalhe: vendaOrcamentoDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(vendaOrcamentoDetalhe.idProduto!))).getSingleOrNull(),
				);
				vendaOrcamentoCabecalhoGrouped.vendaOrcamentoDetalheGroupedList!.add(vendaOrcamentoDetalheGrouped);
			}

		}		

		return vendaOrcamentoCabecalhoGroupedList;	
	}

	Future<VendaOrcamentoCabecalho?> getObject(dynamic pk) async {
		return await (select(vendaOrcamentoCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<VendaOrcamentoCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM venda_orcamento_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as VendaOrcamentoCabecalho;		 
	} 

	Future<VendaOrcamentoCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(VendaOrcamentoCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.vendaOrcamentoCabecalho = object.vendaOrcamentoCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(vendaOrcamentoCabecalhos).insert(object.vendaOrcamentoCabecalho!);
			object.vendaOrcamentoCabecalho = object.vendaOrcamentoCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(VendaOrcamentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(vendaOrcamentoCabecalhos).replace(object.vendaOrcamentoCabecalho!);
		});	 
	} 

	Future<int> deleteObject(VendaOrcamentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(vendaOrcamentoCabecalhos).delete(object.vendaOrcamentoCabecalho!);
		});		
	}

	Future<void> insertChildren(VendaOrcamentoCabecalhoGrouped object) async {
		for (var vendaOrcamentoDetalheGrouped in object.vendaOrcamentoDetalheGroupedList!) {
			vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe = vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe?.copyWith(
				id: const Value(null),
				idVendaOrcamentoCabecalho: Value(object.vendaOrcamentoCabecalho!.id),
			);
			await into(vendaOrcamentoDetalhes).insert(vendaOrcamentoDetalheGrouped.vendaOrcamentoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(VendaOrcamentoCabecalhoGrouped object) async {
		await (delete(vendaOrcamentoDetalhes)..where((t) => t.idVendaOrcamentoCabecalho.equals(object.vendaOrcamentoCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from venda_orcamento_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}