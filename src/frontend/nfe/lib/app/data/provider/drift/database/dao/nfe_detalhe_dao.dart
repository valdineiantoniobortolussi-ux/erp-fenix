import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_detalhe_dao.g.dart';

@DriftAccessor(tables: [
	NfeDetalhes,
	NfeDetEspecificoVeiculos,
	NfeDetEspecificoMedicamentos,
	NfeDetEspecificoArmamentos,
	NfeDetEspecificoCombustivels,
	NfeDeclaracaoImportacaos,
	NfeDetalheImpostoIcmss,
	NfeDetalheImpostoIpis,
	NfeDetalheImpostoIis,
	NfeDetalheImpostoPiss,
	NfeDetalheImpostoCofinss,
	NfeDetalheImpostoIssqns,
	NfeExportacaos,
	NfeItemRastreados,
	NfeDetalheImpostoPisSts,
	NfeDetalheImpostoIcmsUfdests,
	NfeDetalheImpostoCofinsSts,
	NfeCabecalhos,
	Produtos,
])
class NfeDetalheDao extends DatabaseAccessor<AppDatabase> with _$NfeDetalheDaoMixin {
	final AppDatabase db;

	List<NfeDetalhe> nfeDetalheList = []; 
	List<NfeDetalheGrouped> nfeDetalheGroupedList = []; 

	NfeDetalheDao(this.db) : super(db);

	Future<List<NfeDetalhe>> getList() async {
		nfeDetalheList = await select(nfeDetalhes).get();
		return nfeDetalheList;
	}

	Future<List<NfeDetalhe>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeDetalheList = await (select(nfeDetalhes)..where((t) => expression)).get();
		return nfeDetalheList;	 
	}

	Future<List<NfeDetalheGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeDetalhes)
			.join([ 
				leftOuterJoin(nfeCabecalhos, nfeCabecalhos.id.equalsExp(nfeDetalhes.idNfeCabecalho)), 
			]).join([ 
				leftOuterJoin(produtos, produtos.id.equalsExp(nfeDetalhes.idProduto)), 
			]);

		if (field != null && field != '') { 
			final column = nfeDetalhes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeDetalheGroupedList = await query.map((row) {
			final nfeDetalhe = row.readTableOrNull(nfeDetalhes); 
			final nfeCabecalho = row.readTableOrNull(nfeCabecalhos); 
			final produto = row.readTableOrNull(produtos); 

			return NfeDetalheGrouped(
				nfeDetalhe: nfeDetalhe, 
				nfeCabecalho: nfeCabecalho, 
				produto: produto, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var nfeDetalheGrouped in nfeDetalheGroupedList) {
			nfeDetalheGrouped.nfeDetEspecificoVeiculoGroupedList = [];
			final queryNfeDetEspecificoVeiculo = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetEspecificoVeiculo);
			final nfeDetEspecificoVeiculoList = await (select(nfeDetEspecificoVeiculos)..where((t) => expression)).get();
			for (var nfeDetEspecificoVeiculo in nfeDetEspecificoVeiculoList) {
				NfeDetEspecificoVeiculoGrouped nfeDetEspecificoVeiculoGrouped = NfeDetEspecificoVeiculoGrouped(
					nfeDetEspecificoVeiculo: nfeDetEspecificoVeiculo,
				);
				nfeDetalheGrouped.nfeDetEspecificoVeiculoGroupedList!.add(nfeDetEspecificoVeiculoGrouped);
			}

			nfeDetalheGrouped.nfeDetEspecificoMedicamentoGroupedList = [];
			final queryNfeDetEspecificoMedicamento = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetEspecificoMedicamento);
			final nfeDetEspecificoMedicamentoList = await (select(nfeDetEspecificoMedicamentos)..where((t) => expression)).get();
			for (var nfeDetEspecificoMedicamento in nfeDetEspecificoMedicamentoList) {
				NfeDetEspecificoMedicamentoGrouped nfeDetEspecificoMedicamentoGrouped = NfeDetEspecificoMedicamentoGrouped(
					nfeDetEspecificoMedicamento: nfeDetEspecificoMedicamento,
				);
				nfeDetalheGrouped.nfeDetEspecificoMedicamentoGroupedList!.add(nfeDetEspecificoMedicamentoGrouped);
			}

			nfeDetalheGrouped.nfeDetEspecificoArmamentoGroupedList = [];
			final queryNfeDetEspecificoArmamento = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetEspecificoArmamento);
			final nfeDetEspecificoArmamentoList = await (select(nfeDetEspecificoArmamentos)..where((t) => expression)).get();
			for (var nfeDetEspecificoArmamento in nfeDetEspecificoArmamentoList) {
				NfeDetEspecificoArmamentoGrouped nfeDetEspecificoArmamentoGrouped = NfeDetEspecificoArmamentoGrouped(
					nfeDetEspecificoArmamento: nfeDetEspecificoArmamento,
				);
				nfeDetalheGrouped.nfeDetEspecificoArmamentoGroupedList!.add(nfeDetEspecificoArmamentoGrouped);
			}

			nfeDetalheGrouped.nfeDetEspecificoCombustivelGroupedList = [];
			final queryNfeDetEspecificoCombustivel = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetEspecificoCombustivel);
			final nfeDetEspecificoCombustivelList = await (select(nfeDetEspecificoCombustivels)..where((t) => expression)).get();
			for (var nfeDetEspecificoCombustivel in nfeDetEspecificoCombustivelList) {
				NfeDetEspecificoCombustivelGrouped nfeDetEspecificoCombustivelGrouped = NfeDetEspecificoCombustivelGrouped(
					nfeDetEspecificoCombustivel: nfeDetEspecificoCombustivel,
				);
				nfeDetalheGrouped.nfeDetEspecificoCombustivelGroupedList!.add(nfeDetEspecificoCombustivelGrouped);
			}

			nfeDetalheGrouped.nfeDeclaracaoImportacaoGroupedList = [];
			final queryNfeDeclaracaoImportacao = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDeclaracaoImportacao);
			final nfeDeclaracaoImportacaoList = await (select(nfeDeclaracaoImportacaos)..where((t) => expression)).get();
			for (var nfeDeclaracaoImportacao in nfeDeclaracaoImportacaoList) {
				NfeDeclaracaoImportacaoGrouped nfeDeclaracaoImportacaoGrouped = NfeDeclaracaoImportacaoGrouped(
					nfeDeclaracaoImportacao: nfeDeclaracaoImportacao,
				);
				nfeDetalheGrouped.nfeDeclaracaoImportacaoGroupedList!.add(nfeDeclaracaoImportacaoGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoIcmsGroupedList = [];
			final queryNfeDetalheImpostoIcms = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoIcms);
			final nfeDetalheImpostoIcmsList = await (select(nfeDetalheImpostoIcmss)..where((t) => expression)).get();
			for (var nfeDetalheImpostoIcms in nfeDetalheImpostoIcmsList) {
				NfeDetalheImpostoIcmsGrouped nfeDetalheImpostoIcmsGrouped = NfeDetalheImpostoIcmsGrouped(
					nfeDetalheImpostoIcms: nfeDetalheImpostoIcms,
				);
				nfeDetalheGrouped.nfeDetalheImpostoIcmsGroupedList!.add(nfeDetalheImpostoIcmsGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoIpiGroupedList = [];
			final queryNfeDetalheImpostoIpi = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoIpi);
			final nfeDetalheImpostoIpiList = await (select(nfeDetalheImpostoIpis)..where((t) => expression)).get();
			for (var nfeDetalheImpostoIpi in nfeDetalheImpostoIpiList) {
				NfeDetalheImpostoIpiGrouped nfeDetalheImpostoIpiGrouped = NfeDetalheImpostoIpiGrouped(
					nfeDetalheImpostoIpi: nfeDetalheImpostoIpi,
				);
				nfeDetalheGrouped.nfeDetalheImpostoIpiGroupedList!.add(nfeDetalheImpostoIpiGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoIiGroupedList = [];
			final queryNfeDetalheImpostoIi = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoIi);
			final nfeDetalheImpostoIiList = await (select(nfeDetalheImpostoIis)..where((t) => expression)).get();
			for (var nfeDetalheImpostoIi in nfeDetalheImpostoIiList) {
				NfeDetalheImpostoIiGrouped nfeDetalheImpostoIiGrouped = NfeDetalheImpostoIiGrouped(
					nfeDetalheImpostoIi: nfeDetalheImpostoIi,
				);
				nfeDetalheGrouped.nfeDetalheImpostoIiGroupedList!.add(nfeDetalheImpostoIiGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoPisGroupedList = [];
			final queryNfeDetalheImpostoPis = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoPis);
			final nfeDetalheImpostoPisList = await (select(nfeDetalheImpostoPiss)..where((t) => expression)).get();
			for (var nfeDetalheImpostoPis in nfeDetalheImpostoPisList) {
				NfeDetalheImpostoPisGrouped nfeDetalheImpostoPisGrouped = NfeDetalheImpostoPisGrouped(
					nfeDetalheImpostoPis: nfeDetalheImpostoPis,
				);
				nfeDetalheGrouped.nfeDetalheImpostoPisGroupedList!.add(nfeDetalheImpostoPisGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoCofinsGroupedList = [];
			final queryNfeDetalheImpostoCofins = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoCofins);
			final nfeDetalheImpostoCofinsList = await (select(nfeDetalheImpostoCofinss)..where((t) => expression)).get();
			for (var nfeDetalheImpostoCofins in nfeDetalheImpostoCofinsList) {
				NfeDetalheImpostoCofinsGrouped nfeDetalheImpostoCofinsGrouped = NfeDetalheImpostoCofinsGrouped(
					nfeDetalheImpostoCofins: nfeDetalheImpostoCofins,
				);
				nfeDetalheGrouped.nfeDetalheImpostoCofinsGroupedList!.add(nfeDetalheImpostoCofinsGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoIssqnGroupedList = [];
			final queryNfeDetalheImpostoIssqn = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoIssqn);
			final nfeDetalheImpostoIssqnList = await (select(nfeDetalheImpostoIssqns)..where((t) => expression)).get();
			for (var nfeDetalheImpostoIssqn in nfeDetalheImpostoIssqnList) {
				NfeDetalheImpostoIssqnGrouped nfeDetalheImpostoIssqnGrouped = NfeDetalheImpostoIssqnGrouped(
					nfeDetalheImpostoIssqn: nfeDetalheImpostoIssqn,
				);
				nfeDetalheGrouped.nfeDetalheImpostoIssqnGroupedList!.add(nfeDetalheImpostoIssqnGrouped);
			}

			nfeDetalheGrouped.nfeExportacaoGroupedList = [];
			final queryNfeExportacao = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeExportacao);
			final nfeExportacaoList = await (select(nfeExportacaos)..where((t) => expression)).get();
			for (var nfeExportacao in nfeExportacaoList) {
				NfeExportacaoGrouped nfeExportacaoGrouped = NfeExportacaoGrouped(
					nfeExportacao: nfeExportacao,
				);
				nfeDetalheGrouped.nfeExportacaoGroupedList!.add(nfeExportacaoGrouped);
			}

			nfeDetalheGrouped.nfeItemRastreadoGroupedList = [];
			final queryNfeItemRastreado = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeItemRastreado);
			final nfeItemRastreadoList = await (select(nfeItemRastreados)..where((t) => expression)).get();
			for (var nfeItemRastreado in nfeItemRastreadoList) {
				NfeItemRastreadoGrouped nfeItemRastreadoGrouped = NfeItemRastreadoGrouped(
					nfeItemRastreado: nfeItemRastreado,
				);
				nfeDetalheGrouped.nfeItemRastreadoGroupedList!.add(nfeItemRastreadoGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoPisStGroupedList = [];
			final queryNfeDetalheImpostoPisSt = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoPisSt);
			final nfeDetalheImpostoPisStList = await (select(nfeDetalheImpostoPisSts)..where((t) => expression)).get();
			for (var nfeDetalheImpostoPisSt in nfeDetalheImpostoPisStList) {
				NfeDetalheImpostoPisStGrouped nfeDetalheImpostoPisStGrouped = NfeDetalheImpostoPisStGrouped(
					nfeDetalheImpostoPisSt: nfeDetalheImpostoPisSt,
				);
				nfeDetalheGrouped.nfeDetalheImpostoPisStGroupedList!.add(nfeDetalheImpostoPisStGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoIcmsUfdestGroupedList = [];
			final queryNfeDetalheImpostoIcmsUfdest = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoIcmsUfdest);
			final nfeDetalheImpostoIcmsUfdestList = await (select(nfeDetalheImpostoIcmsUfdests)..where((t) => expression)).get();
			for (var nfeDetalheImpostoIcmsUfdest in nfeDetalheImpostoIcmsUfdestList) {
				NfeDetalheImpostoIcmsUfdestGrouped nfeDetalheImpostoIcmsUfdestGrouped = NfeDetalheImpostoIcmsUfdestGrouped(
					nfeDetalheImpostoIcmsUfdest: nfeDetalheImpostoIcmsUfdest,
				);
				nfeDetalheGrouped.nfeDetalheImpostoIcmsUfdestGroupedList!.add(nfeDetalheImpostoIcmsUfdestGrouped);
			}

			nfeDetalheGrouped.nfeDetalheImpostoCofinsStGroupedList = [];
			final queryNfeDetalheImpostoCofinsSt = ' id_nfe_detalhe = ${nfeDetalheGrouped.nfeDetalhe!.id}';
			expression = CustomExpression<bool>(queryNfeDetalheImpostoCofinsSt);
			final nfeDetalheImpostoCofinsStList = await (select(nfeDetalheImpostoCofinsSts)..where((t) => expression)).get();
			for (var nfeDetalheImpostoCofinsSt in nfeDetalheImpostoCofinsStList) {
				NfeDetalheImpostoCofinsStGrouped nfeDetalheImpostoCofinsStGrouped = NfeDetalheImpostoCofinsStGrouped(
					nfeDetalheImpostoCofinsSt: nfeDetalheImpostoCofinsSt,
				);
				nfeDetalheGrouped.nfeDetalheImpostoCofinsStGroupedList!.add(nfeDetalheImpostoCofinsStGrouped);
			}

		}		

		return nfeDetalheGroupedList;	
	}

	Future<NfeDetalhe?> getObject(dynamic pk) async {
		return await (select(nfeDetalhes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeDetalhe?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_detalhe WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeDetalhe;		 
	} 

	Future<NfeDetalheGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeDetalheGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeDetalhe = object.nfeDetalhe!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeDetalhes).insert(object.nfeDetalhe!);
			object.nfeDetalhe = object.nfeDetalhe!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeDetalheGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeDetalhes).replace(object.nfeDetalhe!);
		});	 
	} 

	Future<int> deleteObject(NfeDetalheGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeDetalhes).delete(object.nfeDetalhe!);
		});		
	}

	Future<void> insertChildren(NfeDetalheGrouped object) async {
		for (var nfeDetEspecificoVeiculoGrouped in object.nfeDetEspecificoVeiculoGroupedList!) {
			nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo = nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetEspecificoVeiculos).insert(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo!);
		}
		for (var nfeDetEspecificoMedicamentoGrouped in object.nfeDetEspecificoMedicamentoGroupedList!) {
			nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento = nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetEspecificoMedicamentos).insert(nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento!);
		}
		for (var nfeDetEspecificoArmamentoGrouped in object.nfeDetEspecificoArmamentoGroupedList!) {
			nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento = nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetEspecificoArmamentos).insert(nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento!);
		}
		for (var nfeDetEspecificoCombustivelGrouped in object.nfeDetEspecificoCombustivelGroupedList!) {
			nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel = nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetEspecificoCombustivels).insert(nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel!);
		}
		for (var nfeDeclaracaoImportacaoGrouped in object.nfeDeclaracaoImportacaoGroupedList!) {
			nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao = nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDeclaracaoImportacaos).insert(nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao!);
		}
		for (var nfeDetalheImpostoIcmsGrouped in object.nfeDetalheImpostoIcmsGroupedList!) {
			nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms = nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoIcmss).insert(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms!);
		}
		for (var nfeDetalheImpostoIpiGrouped in object.nfeDetalheImpostoIpiGroupedList!) {
			nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi = nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoIpis).insert(nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi!);
		}
		for (var nfeDetalheImpostoIiGrouped in object.nfeDetalheImpostoIiGroupedList!) {
			nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi = nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoIis).insert(nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi!);
		}
		for (var nfeDetalheImpostoPisGrouped in object.nfeDetalheImpostoPisGroupedList!) {
			nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis = nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoPiss).insert(nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis!);
		}
		for (var nfeDetalheImpostoCofinsGrouped in object.nfeDetalheImpostoCofinsGroupedList!) {
			nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins = nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoCofinss).insert(nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins!);
		}
		for (var nfeDetalheImpostoIssqnGrouped in object.nfeDetalheImpostoIssqnGroupedList!) {
			nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn = nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoIssqns).insert(nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn!);
		}
		for (var nfeExportacaoGrouped in object.nfeExportacaoGroupedList!) {
			nfeExportacaoGrouped.nfeExportacao = nfeExportacaoGrouped.nfeExportacao?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeExportacaos).insert(nfeExportacaoGrouped.nfeExportacao!);
		}
		for (var nfeItemRastreadoGrouped in object.nfeItemRastreadoGroupedList!) {
			nfeItemRastreadoGrouped.nfeItemRastreado = nfeItemRastreadoGrouped.nfeItemRastreado?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeItemRastreados).insert(nfeItemRastreadoGrouped.nfeItemRastreado!);
		}
		for (var nfeDetalheImpostoPisStGrouped in object.nfeDetalheImpostoPisStGroupedList!) {
			nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt = nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoPisSts).insert(nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt!);
		}
		for (var nfeDetalheImpostoIcmsUfdestGrouped in object.nfeDetalheImpostoIcmsUfdestGroupedList!) {
			nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest = nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoIcmsUfdests).insert(nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest!);
		}
		for (var nfeDetalheImpostoCofinsStGrouped in object.nfeDetalheImpostoCofinsStGroupedList!) {
			nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt = nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.copyWith(
				id: const Value(null),
				idNfeDetalhe: Value(object.nfeDetalhe!.id),
			);
			await into(nfeDetalheImpostoCofinsSts).insert(nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt!);
		}
	}
	
	Future<void> deleteChildren(NfeDetalheGrouped object) async {
		await (delete(nfeDetEspecificoVeiculos)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetEspecificoMedicamentos)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetEspecificoArmamentos)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetEspecificoCombustivels)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDeclaracaoImportacaos)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoIcmss)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoIpis)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoIis)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoPiss)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoCofinss)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoIssqns)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeExportacaos)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeItemRastreados)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoPisSts)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoIcmsUfdests)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
		await (delete(nfeDetalheImpostoCofinsSts)..where((t) => t.idNfeDetalhe.equals(object.nfeDetalhe!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_detalhe").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}