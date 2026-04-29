import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

part 'venda_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	VendaCabecalhos,
	VendaComissaos,
	ViewPessoaVendedors,
	VendaDetalhes,
	Produtos,
	VendaFretes,
	ViewPessoaTransportadoras,
	VendaCondicoesPagamentos,
	ViewPessoaVendedors,
	ViewPessoaTransportadoras,
	ViewPessoaClientes,
	VendaOrcamentoCabecalhos,
	NotaFiscalTipos,
])
class VendaCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$VendaCabecalhoDaoMixin {
	final AppDatabase db;

	List<VendaCabecalho> vendaCabecalhoList = []; 
	List<VendaCabecalhoGrouped> vendaCabecalhoGroupedList = []; 

	VendaCabecalhoDao(this.db) : super(db);

	Future<List<VendaCabecalho>> getList() async {
		vendaCabecalhoList = await select(vendaCabecalhos).get();
		return vendaCabecalhoList;
	}

	Future<List<VendaCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		vendaCabecalhoList = await (select(vendaCabecalhos)..where((t) => expression)).get();
		return vendaCabecalhoList;	 
	}

	Future<List<VendaCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(vendaCabecalhos)
			.join([ 
				leftOuterJoin(vendaComissaos, vendaComissaos.idVendaCabecalho.equalsExp(vendaCabecalhos.id)), 
			]).join([ 
				leftOuterJoin(viewPessoaVendedors, viewPessoaVendedors.id.equalsExp(vendaComissaos.idVendedor)), 
			]).join([ 
				leftOuterJoin(vendaCondicoesPagamentos, vendaCondicoesPagamentos.id.equalsExp(vendaCabecalhos.idVendaCondicoesPagamento)), 
			]).join([ 
				leftOuterJoin(viewPessoaVendedors, viewPessoaVendedors.id.equalsExp(vendaCabecalhos.idVendedor)), 
			]).join([ 
				leftOuterJoin(viewPessoaTransportadoras, viewPessoaTransportadoras.id.equalsExp(vendaCabecalhos.idTransportadora)), 
			]).join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(vendaCabecalhos.idCliente)), 
			]).join([ 
				leftOuterJoin(vendaOrcamentoCabecalhos, vendaOrcamentoCabecalhos.id.equalsExp(vendaCabecalhos.idVendaOrcamentoCabecalho)), 
			]).join([ 
				leftOuterJoin(notaFiscalTipos, notaFiscalTipos.id.equalsExp(vendaCabecalhos.idNotaFiscalTipo)), 
			]);

		if (field != null && field != '') { 
			final column = vendaCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		vendaCabecalhoGroupedList = await query.map((row) {
			final vendaCabecalho = row.readTableOrNull(vendaCabecalhos); 
			final vendaComissao = row.readTableOrNull(vendaComissaos); 
			final viewPessoaVendedor = row.readTableOrNull(viewPessoaVendedors); 
			final vendaCondicoesPagamento = row.readTableOrNull(vendaCondicoesPagamentos); 
			final viewPessoaVendedor = row.readTableOrNull(viewPessoaVendedors); 
			final viewPessoaTransportadora = row.readTableOrNull(viewPessoaTransportadoras); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 
			final vendaOrcamentoCabecalho = row.readTableOrNull(vendaOrcamentoCabecalhos); 
			final notaFiscalTipo = row.readTableOrNull(notaFiscalTipos); 

			return VendaCabecalhoGrouped(
				vendaCabecalho: vendaCabecalho, 
				vendaComissaoGrouped: VendaComissaoGrouped 
				(
					vendaComissao: vendaComissao, 
					viewPessoaVendedor: viewPessoaVendedor, 
				),
				vendaCondicoesPagamento: vendaCondicoesPagamento, 
				viewPessoaVendedor: viewPessoaVendedor, 
				viewPessoaTransportadora: viewPessoaTransportadora, 
				viewPessoaCliente: viewPessoaCliente, 
				vendaOrcamentoCabecalho: vendaOrcamentoCabecalho, 
				notaFiscalTipo: notaFiscalTipo, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var vendaCabecalhoGrouped in vendaCabecalhoGroupedList) {
			vendaCabecalhoGrouped.vendaDetalheGroupedList = [];
			final queryVendaDetalhe = ' id_venda_cabecalho = ${vendaCabecalhoGrouped.vendaCabecalho!.id}';
			expression = CustomExpression<bool>(queryVendaDetalhe);
			final vendaDetalheList = await (select(vendaDetalhes)..where((t) => expression)).get();
			for (var vendaDetalhe in vendaDetalheList) {
				VendaDetalheGrouped vendaDetalheGrouped = VendaDetalheGrouped(
					vendaDetalhe: vendaDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(vendaDetalhe.idProduto!))).getSingleOrNull(),
				);
				vendaCabecalhoGrouped.vendaDetalheGroupedList!.add(vendaDetalheGrouped);
			}

			vendaCabecalhoGrouped.vendaFreteGroupedList = [];
			final queryVendaFrete = ' id_venda_cabecalho = ${vendaCabecalhoGrouped.vendaCabecalho!.id}';
			expression = CustomExpression<bool>(queryVendaFrete);
			final vendaFreteList = await (select(vendaFretes)..where((t) => expression)).get();
			for (var vendaFrete in vendaFreteList) {
				VendaFreteGrouped vendaFreteGrouped = VendaFreteGrouped(
					vendaFrete: vendaFrete,
					viewPessoaTransportadora: await (select(viewPessoaTransportadoras)..where((t) => t.id.equals(vendaFrete.idTransportadora!))).getSingleOrNull(),
				);
				vendaCabecalhoGrouped.vendaFreteGroupedList!.add(vendaFreteGrouped);
			}

		}		

		return vendaCabecalhoGroupedList;	
	}

	Future<VendaCabecalho?> getObject(dynamic pk) async {
		return await (select(vendaCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<VendaCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM venda_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as VendaCabecalho;		 
	} 

	Future<VendaCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(VendaCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.vendaCabecalho = object.vendaCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(vendaCabecalhos).insert(object.vendaCabecalho!);
			object.vendaCabecalho = object.vendaCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(VendaCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(vendaCabecalhos).replace(object.vendaCabecalho!);
		});	 
	} 

	Future<int> deleteObject(VendaCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(vendaCabecalhos).delete(object.vendaCabecalho!);
		});		
	}

	Future<void> insertChildren(VendaCabecalhoGrouped object) async {
		object.vendaComissaoGrouped!.vendaComissao = object.vendaComissaoGrouped!.vendaComissao!.copyWith(idVendaCabecalho: Value(object.vendaCabecalho!.id));
		await into(pessoaFisicas).insert(object.pessoaFisicaGrouped!.pessoaFisica!);
		for (var vendaDetalheGrouped in object.vendaDetalheGroupedList!) {
			vendaDetalheGrouped.vendaDetalhe = vendaDetalheGrouped.vendaDetalhe?.copyWith(
				id: const Value(null),
				idVendaCabecalho: Value(object.vendaCabecalho!.id),
			);
			await into(vendaDetalhes).insert(vendaDetalheGrouped.vendaDetalhe!);
		}
		for (var vendaFreteGrouped in object.vendaFreteGroupedList!) {
			vendaFreteGrouped.vendaFrete = vendaFreteGrouped.vendaFrete?.copyWith(
				id: const Value(null),
				idVendaCabecalho: Value(object.vendaCabecalho!.id),
			);
			await into(vendaFretes).insert(vendaFreteGrouped.vendaFrete!);
		}
	}
	
	Future<void> deleteChildren(VendaCabecalhoGrouped object) async {
		await (delete(vendaComissaos)..where((t) => t.idVendaCabecalho.equals(object.vendaCabecalho!.id!))).go();
		await (delete(vendaDetalhes)..where((t) => t.idVendaCabecalho.equals(object.vendaCabecalho!.id!))).go();
		await (delete(vendaFretes)..where((t) => t.idVendaCabecalho.equals(object.vendaCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from venda_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}