import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

part 'compra_pedido_dao.g.dart';

@DriftAccessor(tables: [
	CompraPedidos,
	CompraPedidoDetalhes,
	Produtos,
	CompraTipoPedidos,
	ViewPessoaColaboradors,
	ViewPessoaFornecedors,
])
class CompraPedidoDao extends DatabaseAccessor<AppDatabase> with _$CompraPedidoDaoMixin {
	final AppDatabase db;

	List<CompraPedido> compraPedidoList = []; 
	List<CompraPedidoGrouped> compraPedidoGroupedList = []; 

	CompraPedidoDao(this.db) : super(db);

	Future<List<CompraPedido>> getList() async {
		compraPedidoList = await select(compraPedidos).get();
		return compraPedidoList;
	}

	Future<List<CompraPedido>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		compraPedidoList = await (select(compraPedidos)..where((t) => expression)).get();
		return compraPedidoList;	 
	}

	Future<List<CompraPedidoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(compraPedidos)
			.join([ 
				leftOuterJoin(compraTipoPedidos, compraTipoPedidos.id.equalsExp(compraPedidos.idCompraTipoPedido)), 
			]).join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(compraPedidos.idColaborador)), 
			]).join([ 
				leftOuterJoin(viewPessoaFornecedors, viewPessoaFornecedors.id.equalsExp(compraPedidos.idFornecedor)), 
			]);

		if (field != null && field != '') { 
			final column = compraPedidos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		compraPedidoGroupedList = await query.map((row) {
			final compraPedido = row.readTableOrNull(compraPedidos); 
			final compraTipoPedido = row.readTableOrNull(compraTipoPedidos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final viewPessoaFornecedor = row.readTableOrNull(viewPessoaFornecedors); 

			return CompraPedidoGrouped(
				compraPedido: compraPedido, 
				compraTipoPedido: compraTipoPedido, 
				viewPessoaColaborador: viewPessoaColaborador, 
				viewPessoaFornecedor: viewPessoaFornecedor, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var compraPedidoGrouped in compraPedidoGroupedList) {
			compraPedidoGrouped.compraPedidoDetalheGroupedList = [];
			final queryCompraPedidoDetalhe = ' id_compra_pedido = ${compraPedidoGrouped.compraPedido!.id}';
			expression = CustomExpression<bool>(queryCompraPedidoDetalhe);
			final compraPedidoDetalheList = await (select(compraPedidoDetalhes)..where((t) => expression)).get();
			for (var compraPedidoDetalhe in compraPedidoDetalheList) {
				CompraPedidoDetalheGrouped compraPedidoDetalheGrouped = CompraPedidoDetalheGrouped(
					compraPedidoDetalhe: compraPedidoDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(compraPedidoDetalhe.idProduto!))).getSingleOrNull(),
				);
				compraPedidoGrouped.compraPedidoDetalheGroupedList!.add(compraPedidoDetalheGrouped);
			}

		}		

		return compraPedidoGroupedList;	
	}

	Future<CompraPedido?> getObject(dynamic pk) async {
		return await (select(compraPedidos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CompraPedido?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM compra_pedido WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CompraPedido;		 
	} 

	Future<CompraPedidoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CompraPedidoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.compraPedido = object.compraPedido!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(compraPedidos).insert(object.compraPedido!);
			object.compraPedido = object.compraPedido!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CompraPedidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(compraPedidos).replace(object.compraPedido!);
		});	 
	} 

	Future<int> deleteObject(CompraPedidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(compraPedidos).delete(object.compraPedido!);
		});		
	}

	Future<void> insertChildren(CompraPedidoGrouped object) async {
		for (var compraPedidoDetalheGrouped in object.compraPedidoDetalheGroupedList!) {
			compraPedidoDetalheGrouped.compraPedidoDetalhe = compraPedidoDetalheGrouped.compraPedidoDetalhe?.copyWith(
				id: const Value(null),
				idCompraPedido: Value(object.compraPedido!.id),
			);
			await into(compraPedidoDetalhes).insert(compraPedidoDetalheGrouped.compraPedidoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(CompraPedidoGrouped object) async {
		await (delete(compraPedidoDetalhes)..where((t) => t.idCompraPedido.equals(object.compraPedido!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from compra_pedido").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}