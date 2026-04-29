import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';

part 'patrim_bem_dao.g.dart';

@DriftAccessor(tables: [
	PatrimBems,
	PatrimDocumentoBems,
	PatrimDepreciacaoBems,
	PatrimMovimentacaoBems,
	PatrimTipoMovimentacaos,
	PatrimApoliceSeguros,
	Seguradoras,
	CentroResultados,
	PatrimEstadoConservacaos,
	Setors,
	ViewPessoaFornecedors,
	PatrimTipoAquisicaoBems,
	PatrimGrupoBems,
	ViewPessoaColaboradors,
])
class PatrimBemDao extends DatabaseAccessor<AppDatabase> with _$PatrimBemDaoMixin {
	final AppDatabase db;

	List<PatrimBem> patrimBemList = []; 
	List<PatrimBemGrouped> patrimBemGroupedList = []; 

	PatrimBemDao(this.db) : super(db);

	Future<List<PatrimBem>> getList() async {
		patrimBemList = await select(patrimBems).get();
		return patrimBemList;
	}

	Future<List<PatrimBem>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		patrimBemList = await (select(patrimBems)..where((t) => expression)).get();
		return patrimBemList;	 
	}

	Future<List<PatrimBemGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(patrimBems)
			.join([ 
				leftOuterJoin(centroResultados, centroResultados.id.equalsExp(patrimBems.idCentroResultado)), 
			]).join([ 
				leftOuterJoin(patrimEstadoConservacaos, patrimEstadoConservacaos.id.equalsExp(patrimBems.idPatrimEstadoConservacao)), 
			]).join([ 
				leftOuterJoin(setors, setors.id.equalsExp(patrimBems.idSetor)), 
			]).join([ 
				leftOuterJoin(viewPessoaFornecedors, viewPessoaFornecedors.id.equalsExp(patrimBems.idFornecedor)), 
			]).join([ 
				leftOuterJoin(patrimTipoAquisicaoBems, patrimTipoAquisicaoBems.id.equalsExp(patrimBems.idPatrimTipoAquisicaoBem)), 
			]).join([ 
				leftOuterJoin(patrimGrupoBems, patrimGrupoBems.id.equalsExp(patrimBems.idPatrimGrupoBem)), 
			]).join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(patrimBems.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = patrimBems.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		patrimBemGroupedList = await query.map((row) {
			final patrimBem = row.readTableOrNull(patrimBems); 
			final centroResultado = row.readTableOrNull(centroResultados); 
			final patrimEstadoConservacao = row.readTableOrNull(patrimEstadoConservacaos); 
			final setor = row.readTableOrNull(setors); 
			final viewPessoaFornecedor = row.readTableOrNull(viewPessoaFornecedors); 
			final patrimTipoAquisicaoBem = row.readTableOrNull(patrimTipoAquisicaoBems); 
			final patrimGrupoBem = row.readTableOrNull(patrimGrupoBems); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return PatrimBemGrouped(
				patrimBem: patrimBem, 
				centroResultado: centroResultado, 
				patrimEstadoConservacao: patrimEstadoConservacao, 
				setor: setor, 
				viewPessoaFornecedor: viewPessoaFornecedor, 
				patrimTipoAquisicaoBem: patrimTipoAquisicaoBem, 
				patrimGrupoBem: patrimGrupoBem, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var patrimBemGrouped in patrimBemGroupedList) {
			patrimBemGrouped.patrimDocumentoBemGroupedList = [];
			final queryPatrimDocumentoBem = ' id_patrim_bem = ${patrimBemGrouped.patrimBem!.id}';
			expression = CustomExpression<bool>(queryPatrimDocumentoBem);
			final patrimDocumentoBemList = await (select(patrimDocumentoBems)..where((t) => expression)).get();
			for (var patrimDocumentoBem in patrimDocumentoBemList) {
				PatrimDocumentoBemGrouped patrimDocumentoBemGrouped = PatrimDocumentoBemGrouped(
					patrimDocumentoBem: patrimDocumentoBem,
				);
				patrimBemGrouped.patrimDocumentoBemGroupedList!.add(patrimDocumentoBemGrouped);
			}

			patrimBemGrouped.patrimDepreciacaoBemGroupedList = [];
			final queryPatrimDepreciacaoBem = ' id_patrim_bem = ${patrimBemGrouped.patrimBem!.id}';
			expression = CustomExpression<bool>(queryPatrimDepreciacaoBem);
			final patrimDepreciacaoBemList = await (select(patrimDepreciacaoBems)..where((t) => expression)).get();
			for (var patrimDepreciacaoBem in patrimDepreciacaoBemList) {
				PatrimDepreciacaoBemGrouped patrimDepreciacaoBemGrouped = PatrimDepreciacaoBemGrouped(
					patrimDepreciacaoBem: patrimDepreciacaoBem,
				);
				patrimBemGrouped.patrimDepreciacaoBemGroupedList!.add(patrimDepreciacaoBemGrouped);
			}

			patrimBemGrouped.patrimMovimentacaoBemGroupedList = [];
			final queryPatrimMovimentacaoBem = ' id_patrim_bem = ${patrimBemGrouped.patrimBem!.id}';
			expression = CustomExpression<bool>(queryPatrimMovimentacaoBem);
			final patrimMovimentacaoBemList = await (select(patrimMovimentacaoBems)..where((t) => expression)).get();
			for (var patrimMovimentacaoBem in patrimMovimentacaoBemList) {
				PatrimMovimentacaoBemGrouped patrimMovimentacaoBemGrouped = PatrimMovimentacaoBemGrouped(
					patrimMovimentacaoBem: patrimMovimentacaoBem,
					patrimTipoMovimentacao: await (select(patrimTipoMovimentacaos)..where((t) => t.id.equals(patrimMovimentacaoBem.idPatrimTipoMovimentacao!))).getSingleOrNull(),
				);
				patrimBemGrouped.patrimMovimentacaoBemGroupedList!.add(patrimMovimentacaoBemGrouped);
			}

			patrimBemGrouped.patrimApoliceSeguroGroupedList = [];
			final queryPatrimApoliceSeguro = ' id_patrim_bem = ${patrimBemGrouped.patrimBem!.id}';
			expression = CustomExpression<bool>(queryPatrimApoliceSeguro);
			final patrimApoliceSeguroList = await (select(patrimApoliceSeguros)..where((t) => expression)).get();
			for (var patrimApoliceSeguro in patrimApoliceSeguroList) {
				PatrimApoliceSeguroGrouped patrimApoliceSeguroGrouped = PatrimApoliceSeguroGrouped(
					patrimApoliceSeguro: patrimApoliceSeguro,
					seguradora: await (select(seguradoras)..where((t) => t.id.equals(patrimApoliceSeguro.idSeguradora!))).getSingleOrNull(),
				);
				patrimBemGrouped.patrimApoliceSeguroGroupedList!.add(patrimApoliceSeguroGrouped);
			}

		}		

		return patrimBemGroupedList;	
	}

	Future<PatrimBem?> getObject(dynamic pk) async {
		return await (select(patrimBems)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PatrimBem?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM patrim_bem WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PatrimBem;		 
	} 

	Future<PatrimBemGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PatrimBemGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.patrimBem = object.patrimBem!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(patrimBems).insert(object.patrimBem!);
			object.patrimBem = object.patrimBem!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PatrimBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(patrimBems).replace(object.patrimBem!);
		});	 
	} 

	Future<int> deleteObject(PatrimBemGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(patrimBems).delete(object.patrimBem!);
		});		
	}

	Future<void> insertChildren(PatrimBemGrouped object) async {
		for (var patrimDocumentoBemGrouped in object.patrimDocumentoBemGroupedList!) {
			patrimDocumentoBemGrouped.patrimDocumentoBem = patrimDocumentoBemGrouped.patrimDocumentoBem?.copyWith(
				id: const Value(null),
				idPatrimBem: Value(object.patrimBem!.id),
			);
			await into(patrimDocumentoBems).insert(patrimDocumentoBemGrouped.patrimDocumentoBem!);
		}
		for (var patrimDepreciacaoBemGrouped in object.patrimDepreciacaoBemGroupedList!) {
			patrimDepreciacaoBemGrouped.patrimDepreciacaoBem = patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.copyWith(
				id: const Value(null),
				idPatrimBem: Value(object.patrimBem!.id),
			);
			await into(patrimDepreciacaoBems).insert(patrimDepreciacaoBemGrouped.patrimDepreciacaoBem!);
		}
		for (var patrimMovimentacaoBemGrouped in object.patrimMovimentacaoBemGroupedList!) {
			patrimMovimentacaoBemGrouped.patrimMovimentacaoBem = patrimMovimentacaoBemGrouped.patrimMovimentacaoBem?.copyWith(
				id: const Value(null),
				idPatrimBem: Value(object.patrimBem!.id),
			);
			await into(patrimMovimentacaoBems).insert(patrimMovimentacaoBemGrouped.patrimMovimentacaoBem!);
		}
		for (var patrimApoliceSeguroGrouped in object.patrimApoliceSeguroGroupedList!) {
			patrimApoliceSeguroGrouped.patrimApoliceSeguro = patrimApoliceSeguroGrouped.patrimApoliceSeguro?.copyWith(
				id: const Value(null),
				idPatrimBem: Value(object.patrimBem!.id),
			);
			await into(patrimApoliceSeguros).insert(patrimApoliceSeguroGrouped.patrimApoliceSeguro!);
		}
	}
	
	Future<void> deleteChildren(PatrimBemGrouped object) async {
		await (delete(patrimDocumentoBems)..where((t) => t.idPatrimBem.equals(object.patrimBem!.id!))).go();
		await (delete(patrimDepreciacaoBems)..where((t) => t.idPatrimBem.equals(object.patrimBem!.id!))).go();
		await (delete(patrimMovimentacaoBems)..where((t) => t.idPatrimBem.equals(object.patrimBem!.id!))).go();
		await (delete(patrimApoliceSeguros)..where((t) => t.idPatrimBem.equals(object.patrimBem!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from patrim_bem").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}