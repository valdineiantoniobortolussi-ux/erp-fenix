import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'requisicao_interna_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	RequisicaoInternaCabecalhos,
	RequisicaoInternaDetalhes,
	Produtos,
	ViewPessoaColaboradors,
])
class RequisicaoInternaCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$RequisicaoInternaCabecalhoDaoMixin {
	final AppDatabase db;

	List<RequisicaoInternaCabecalho> requisicaoInternaCabecalhoList = []; 
	List<RequisicaoInternaCabecalhoGrouped> requisicaoInternaCabecalhoGroupedList = []; 

	RequisicaoInternaCabecalhoDao(this.db) : super(db);

	Future<List<RequisicaoInternaCabecalho>> getList() async {
		requisicaoInternaCabecalhoList = await select(requisicaoInternaCabecalhos).get();
		return requisicaoInternaCabecalhoList;
	}

	Future<List<RequisicaoInternaCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		requisicaoInternaCabecalhoList = await (select(requisicaoInternaCabecalhos)..where((t) => expression)).get();
		return requisicaoInternaCabecalhoList;	 
	}

	Future<List<RequisicaoInternaCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(requisicaoInternaCabecalhos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(requisicaoInternaCabecalhos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = requisicaoInternaCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		requisicaoInternaCabecalhoGroupedList = await query.map((row) {
			final requisicaoInternaCabecalho = row.readTableOrNull(requisicaoInternaCabecalhos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return RequisicaoInternaCabecalhoGrouped(
				requisicaoInternaCabecalho: requisicaoInternaCabecalho, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var requisicaoInternaCabecalhoGrouped in requisicaoInternaCabecalhoGroupedList) {
			requisicaoInternaCabecalhoGrouped.requisicaoInternaDetalheGroupedList = [];
			final queryRequisicaoInternaDetalhe = ' id_requisicao_interna_cabecalho = ${requisicaoInternaCabecalhoGrouped.requisicaoInternaCabecalho!.id}';
			expression = CustomExpression<bool>(queryRequisicaoInternaDetalhe);
			final requisicaoInternaDetalheList = await (select(requisicaoInternaDetalhes)..where((t) => expression)).get();
			for (var requisicaoInternaDetalhe in requisicaoInternaDetalheList) {
				RequisicaoInternaDetalheGrouped requisicaoInternaDetalheGrouped = RequisicaoInternaDetalheGrouped(
					requisicaoInternaDetalhe: requisicaoInternaDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(requisicaoInternaDetalhe.idProduto!))).getSingleOrNull(),
				);
				requisicaoInternaCabecalhoGrouped.requisicaoInternaDetalheGroupedList!.add(requisicaoInternaDetalheGrouped);
			}

		}		

		return requisicaoInternaCabecalhoGroupedList;	
	}

	Future<RequisicaoInternaCabecalho?> getObject(dynamic pk) async {
		return await (select(requisicaoInternaCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<RequisicaoInternaCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM requisicao_interna_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as RequisicaoInternaCabecalho;		 
	} 

	Future<RequisicaoInternaCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(RequisicaoInternaCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.requisicaoInternaCabecalho = object.requisicaoInternaCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(requisicaoInternaCabecalhos).insert(object.requisicaoInternaCabecalho!);
			object.requisicaoInternaCabecalho = object.requisicaoInternaCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(RequisicaoInternaCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(requisicaoInternaCabecalhos).replace(object.requisicaoInternaCabecalho!);
		});	 
	} 

	Future<int> deleteObject(RequisicaoInternaCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(requisicaoInternaCabecalhos).delete(object.requisicaoInternaCabecalho!);
		});		
	}

	Future<void> insertChildren(RequisicaoInternaCabecalhoGrouped object) async {
		for (var requisicaoInternaDetalheGrouped in object.requisicaoInternaDetalheGroupedList!) {
			requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe = requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe?.copyWith(
				id: const Value(null),
				idRequisicaoInternaCabecalho: Value(object.requisicaoInternaCabecalho!.id),
			);
			await into(requisicaoInternaDetalhes).insert(requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe!);
		}
	}
	
	Future<void> deleteChildren(RequisicaoInternaCabecalhoGrouped object) async {
		await (delete(requisicaoInternaDetalhes)..where((t) => t.idRequisicaoInternaCabecalho.equals(object.requisicaoInternaCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from requisicao_interna_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}