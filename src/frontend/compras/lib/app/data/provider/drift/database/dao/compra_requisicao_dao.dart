import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

part 'compra_requisicao_dao.g.dart';

@DriftAccessor(tables: [
	CompraRequisicaos,
	CompraRequisicaoDetalhes,
	Produtos,
	ViewPessoaColaboradors,
	CompraTipoRequisicaos,
])
class CompraRequisicaoDao extends DatabaseAccessor<AppDatabase> with _$CompraRequisicaoDaoMixin {
	final AppDatabase db;

	List<CompraRequisicao> compraRequisicaoList = []; 
	List<CompraRequisicaoGrouped> compraRequisicaoGroupedList = []; 

	CompraRequisicaoDao(this.db) : super(db);

	Future<List<CompraRequisicao>> getList() async {
		compraRequisicaoList = await select(compraRequisicaos).get();
		return compraRequisicaoList;
	}

	Future<List<CompraRequisicao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		compraRequisicaoList = await (select(compraRequisicaos)..where((t) => expression)).get();
		return compraRequisicaoList;	 
	}

	Future<List<CompraRequisicaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(compraRequisicaos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(compraRequisicaos.idColaborador)), 
			]).join([ 
				leftOuterJoin(compraTipoRequisicaos, compraTipoRequisicaos.id.equalsExp(compraRequisicaos.idCompraTipoRequisicao)), 
			]);

		if (field != null && field != '') { 
			final column = compraRequisicaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		compraRequisicaoGroupedList = await query.map((row) {
			final compraRequisicao = row.readTableOrNull(compraRequisicaos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final compraTipoRequisicao = row.readTableOrNull(compraTipoRequisicaos); 

			return CompraRequisicaoGrouped(
				compraRequisicao: compraRequisicao, 
				viewPessoaColaborador: viewPessoaColaborador, 
				compraTipoRequisicao: compraTipoRequisicao, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var compraRequisicaoGrouped in compraRequisicaoGroupedList) {
			compraRequisicaoGrouped.compraRequisicaoDetalheGroupedList = [];
			final queryCompraRequisicaoDetalhe = ' id_compra_requisicao = ${compraRequisicaoGrouped.compraRequisicao!.id}';
			expression = CustomExpression<bool>(queryCompraRequisicaoDetalhe);
			final compraRequisicaoDetalheList = await (select(compraRequisicaoDetalhes)..where((t) => expression)).get();
			for (var compraRequisicaoDetalhe in compraRequisicaoDetalheList) {
				CompraRequisicaoDetalheGrouped compraRequisicaoDetalheGrouped = CompraRequisicaoDetalheGrouped(
					compraRequisicaoDetalhe: compraRequisicaoDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(compraRequisicaoDetalhe.idProduto!))).getSingleOrNull(),
				);
				compraRequisicaoGrouped.compraRequisicaoDetalheGroupedList!.add(compraRequisicaoDetalheGrouped);
			}

		}		

		return compraRequisicaoGroupedList;	
	}

	Future<CompraRequisicao?> getObject(dynamic pk) async {
		return await (select(compraRequisicaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CompraRequisicao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM compra_requisicao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CompraRequisicao;		 
	} 

	Future<CompraRequisicaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CompraRequisicaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.compraRequisicao = object.compraRequisicao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(compraRequisicaos).insert(object.compraRequisicao!);
			object.compraRequisicao = object.compraRequisicao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CompraRequisicaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(compraRequisicaos).replace(object.compraRequisicao!);
		});	 
	} 

	Future<int> deleteObject(CompraRequisicaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(compraRequisicaos).delete(object.compraRequisicao!);
		});		
	}

	Future<void> insertChildren(CompraRequisicaoGrouped object) async {
		for (var compraRequisicaoDetalheGrouped in object.compraRequisicaoDetalheGroupedList!) {
			compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe = compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe?.copyWith(
				id: const Value(null),
				idCompraRequisicao: Value(object.compraRequisicao!.id),
			);
			await into(compraRequisicaoDetalhes).insert(compraRequisicaoDetalheGrouped.compraRequisicaoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(CompraRequisicaoGrouped object) async {
		await (delete(compraRequisicaoDetalhes)..where((t) => t.idCompraRequisicao.equals(object.compraRequisicao!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from compra_requisicao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}