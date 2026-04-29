import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	NfeCabecalhos,
	NfeReferenciadas,
	NfeEmitentes,
	NfeDestinatarios,
	NfeLocalRetiradas,
	NfeLocalEntregas,
	NfeTransportes,
	NfeFaturas,
	NfeCanas,
	NfeProdRuralReferenciadas,
	NfeNfReferenciadas,
	NfeProcessoReferenciados,
	NfeAcessoXmls,
	NfeInformacaoPagamentos,
	NfeResponsavelTecnicos,
	TributOperacaoFiscals,
	VendaCabecalhos,
	ViewPessoaClientes,
	ViewPessoaColaboradors,
	ViewPessoaFornecedors,
	NfeCteReferenciados,
	NfeCupomFiscalReferenciados,
])
class NfeCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$NfeCabecalhoDaoMixin {
	final AppDatabase db;

	List<NfeCabecalho> nfeCabecalhoList = []; 
	List<NfeCabecalhoGrouped> nfeCabecalhoGroupedList = []; 

	NfeCabecalhoDao(this.db) : super(db);

	Future<List<NfeCabecalho>> getList() async {
		nfeCabecalhoList = await select(nfeCabecalhos).get();
		return nfeCabecalhoList;
	}

	Future<List<NfeCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeCabecalhoList = await (select(nfeCabecalhos)..where((t) => expression)).get();
		return nfeCabecalhoList;	 
	}

	Future<List<NfeCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeCabecalhos)
			.join([ 
				leftOuterJoin(tributOperacaoFiscals, tributOperacaoFiscals.id.equalsExp(nfeCabecalhos.idTributOperacaoFiscal)), 
			]).join([ 
				leftOuterJoin(vendaCabecalhos, vendaCabecalhos.id.equalsExp(nfeCabecalhos.idVendaCabecalho)), 
			]).join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(nfeCabecalhos.idCliente)), 
			]).join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(nfeCabecalhos.idColaborador)), 
			]).join([ 
				leftOuterJoin(viewPessoaFornecedors, viewPessoaFornecedors.id.equalsExp(nfeCabecalhos.idFornecedor)), 
			]);

		if (field != null && field != '') { 
			final column = nfeCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeCabecalhoGroupedList = await query.map((row) {
			final nfeCabecalho = row.readTableOrNull(nfeCabecalhos); 
			final tributOperacaoFiscal = row.readTableOrNull(tributOperacaoFiscals); 
			final vendaCabecalho = row.readTableOrNull(vendaCabecalhos); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final viewPessoaFornecedor = row.readTableOrNull(viewPessoaFornecedors); 

			return NfeCabecalhoGrouped(
				nfeCabecalho: nfeCabecalho, 
				tributOperacaoFiscal: tributOperacaoFiscal, 
				vendaCabecalho: vendaCabecalho, 
				viewPessoaCliente: viewPessoaCliente, 
				viewPessoaColaborador: viewPessoaColaborador, 
				viewPessoaFornecedor: viewPessoaFornecedor, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var nfeCabecalhoGrouped in nfeCabecalhoGroupedList) {
			nfeCabecalhoGrouped.nfeReferenciadaGroupedList = [];
			final queryNfeReferenciada = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeReferenciada);
			final nfeReferenciadaList = await (select(nfeReferenciadas)..where((t) => expression)).get();
			for (var nfeReferenciada in nfeReferenciadaList) {
				NfeReferenciadaGrouped nfeReferenciadaGrouped = NfeReferenciadaGrouped(
					nfeReferenciada: nfeReferenciada,
				);
				nfeCabecalhoGrouped.nfeReferenciadaGroupedList!.add(nfeReferenciadaGrouped);
			}

			nfeCabecalhoGrouped.nfeEmitenteGroupedList = [];
			final queryNfeEmitente = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeEmitente);
			final nfeEmitenteList = await (select(nfeEmitentes)..where((t) => expression)).get();
			for (var nfeEmitente in nfeEmitenteList) {
				NfeEmitenteGrouped nfeEmitenteGrouped = NfeEmitenteGrouped(
					nfeEmitente: nfeEmitente,
				);
				nfeCabecalhoGrouped.nfeEmitenteGroupedList!.add(nfeEmitenteGrouped);
			}

			nfeCabecalhoGrouped.nfeDestinatarioGroupedList = [];
			final queryNfeDestinatario = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeDestinatario);
			final nfeDestinatarioList = await (select(nfeDestinatarios)..where((t) => expression)).get();
			for (var nfeDestinatario in nfeDestinatarioList) {
				NfeDestinatarioGrouped nfeDestinatarioGrouped = NfeDestinatarioGrouped(
					nfeDestinatario: nfeDestinatario,
				);
				nfeCabecalhoGrouped.nfeDestinatarioGroupedList!.add(nfeDestinatarioGrouped);
			}

			nfeCabecalhoGrouped.nfeLocalRetiradaGroupedList = [];
			final queryNfeLocalRetirada = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeLocalRetirada);
			final nfeLocalRetiradaList = await (select(nfeLocalRetiradas)..where((t) => expression)).get();
			for (var nfeLocalRetirada in nfeLocalRetiradaList) {
				NfeLocalRetiradaGrouped nfeLocalRetiradaGrouped = NfeLocalRetiradaGrouped(
					nfeLocalRetirada: nfeLocalRetirada,
				);
				nfeCabecalhoGrouped.nfeLocalRetiradaGroupedList!.add(nfeLocalRetiradaGrouped);
			}

			nfeCabecalhoGrouped.nfeLocalEntregaGroupedList = [];
			final queryNfeLocalEntrega = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeLocalEntrega);
			final nfeLocalEntregaList = await (select(nfeLocalEntregas)..where((t) => expression)).get();
			for (var nfeLocalEntrega in nfeLocalEntregaList) {
				NfeLocalEntregaGrouped nfeLocalEntregaGrouped = NfeLocalEntregaGrouped(
					nfeLocalEntrega: nfeLocalEntrega,
				);
				nfeCabecalhoGrouped.nfeLocalEntregaGroupedList!.add(nfeLocalEntregaGrouped);
			}

			nfeCabecalhoGrouped.nfeTransporteGroupedList = [];
			final queryNfeTransporte = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeTransporte);
			final nfeTransporteList = await (select(nfeTransportes)..where((t) => expression)).get();
			for (var nfeTransporte in nfeTransporteList) {
				NfeTransporteGrouped nfeTransporteGrouped = NfeTransporteGrouped(
					nfeTransporte: nfeTransporte,
				);
				nfeCabecalhoGrouped.nfeTransporteGroupedList!.add(nfeTransporteGrouped);
			}

			nfeCabecalhoGrouped.nfeFaturaGroupedList = [];
			final queryNfeFatura = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeFatura);
			final nfeFaturaList = await (select(nfeFaturas)..where((t) => expression)).get();
			for (var nfeFatura in nfeFaturaList) {
				NfeFaturaGrouped nfeFaturaGrouped = NfeFaturaGrouped(
					nfeFatura: nfeFatura,
				);
				nfeCabecalhoGrouped.nfeFaturaGroupedList!.add(nfeFaturaGrouped);
			}

			nfeCabecalhoGrouped.nfeCanaGroupedList = [];
			final queryNfeCana = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeCana);
			final nfeCanaList = await (select(nfeCanas)..where((t) => expression)).get();
			for (var nfeCana in nfeCanaList) {
				NfeCanaGrouped nfeCanaGrouped = NfeCanaGrouped(
					nfeCana: nfeCana,
				);
				nfeCabecalhoGrouped.nfeCanaGroupedList!.add(nfeCanaGrouped);
			}

			nfeCabecalhoGrouped.nfeProdRuralReferenciadaGroupedList = [];
			final queryNfeProdRuralReferenciada = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeProdRuralReferenciada);
			final nfeProdRuralReferenciadaList = await (select(nfeProdRuralReferenciadas)..where((t) => expression)).get();
			for (var nfeProdRuralReferenciada in nfeProdRuralReferenciadaList) {
				NfeProdRuralReferenciadaGrouped nfeProdRuralReferenciadaGrouped = NfeProdRuralReferenciadaGrouped(
					nfeProdRuralReferenciada: nfeProdRuralReferenciada,
				);
				nfeCabecalhoGrouped.nfeProdRuralReferenciadaGroupedList!.add(nfeProdRuralReferenciadaGrouped);
			}

			nfeCabecalhoGrouped.nfeNfReferenciadaGroupedList = [];
			final queryNfeNfReferenciada = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeNfReferenciada);
			final nfeNfReferenciadaList = await (select(nfeNfReferenciadas)..where((t) => expression)).get();
			for (var nfeNfReferenciada in nfeNfReferenciadaList) {
				NfeNfReferenciadaGrouped nfeNfReferenciadaGrouped = NfeNfReferenciadaGrouped(
					nfeNfReferenciada: nfeNfReferenciada,
				);
				nfeCabecalhoGrouped.nfeNfReferenciadaGroupedList!.add(nfeNfReferenciadaGrouped);
			}

			nfeCabecalhoGrouped.nfeProcessoReferenciadoGroupedList = [];
			final queryNfeProcessoReferenciado = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeProcessoReferenciado);
			final nfeProcessoReferenciadoList = await (select(nfeProcessoReferenciados)..where((t) => expression)).get();
			for (var nfeProcessoReferenciado in nfeProcessoReferenciadoList) {
				NfeProcessoReferenciadoGrouped nfeProcessoReferenciadoGrouped = NfeProcessoReferenciadoGrouped(
					nfeProcessoReferenciado: nfeProcessoReferenciado,
				);
				nfeCabecalhoGrouped.nfeProcessoReferenciadoGroupedList!.add(nfeProcessoReferenciadoGrouped);
			}

			nfeCabecalhoGrouped.nfeAcessoXmlGroupedList = [];
			final queryNfeAcessoXml = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeAcessoXml);
			final nfeAcessoXmlList = await (select(nfeAcessoXmls)..where((t) => expression)).get();
			for (var nfeAcessoXml in nfeAcessoXmlList) {
				NfeAcessoXmlGrouped nfeAcessoXmlGrouped = NfeAcessoXmlGrouped(
					nfeAcessoXml: nfeAcessoXml,
				);
				nfeCabecalhoGrouped.nfeAcessoXmlGroupedList!.add(nfeAcessoXmlGrouped);
			}

			nfeCabecalhoGrouped.nfeInformacaoPagamentoGroupedList = [];
			final queryNfeInformacaoPagamento = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeInformacaoPagamento);
			final nfeInformacaoPagamentoList = await (select(nfeInformacaoPagamentos)..where((t) => expression)).get();
			for (var nfeInformacaoPagamento in nfeInformacaoPagamentoList) {
				NfeInformacaoPagamentoGrouped nfeInformacaoPagamentoGrouped = NfeInformacaoPagamentoGrouped(
					nfeInformacaoPagamento: nfeInformacaoPagamento,
				);
				nfeCabecalhoGrouped.nfeInformacaoPagamentoGroupedList!.add(nfeInformacaoPagamentoGrouped);
			}

			nfeCabecalhoGrouped.nfeResponsavelTecnicoGroupedList = [];
			final queryNfeResponsavelTecnico = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeResponsavelTecnico);
			final nfeResponsavelTecnicoList = await (select(nfeResponsavelTecnicos)..where((t) => expression)).get();
			for (var nfeResponsavelTecnico in nfeResponsavelTecnicoList) {
				NfeResponsavelTecnicoGrouped nfeResponsavelTecnicoGrouped = NfeResponsavelTecnicoGrouped(
					nfeResponsavelTecnico: nfeResponsavelTecnico,
				);
				nfeCabecalhoGrouped.nfeResponsavelTecnicoGroupedList!.add(nfeResponsavelTecnicoGrouped);
			}

			nfeCabecalhoGrouped.nfeCteReferenciadoGroupedList = [];
			final queryNfeCteReferenciado = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeCteReferenciado);
			final nfeCteReferenciadoList = await (select(nfeCteReferenciados)..where((t) => expression)).get();
			for (var nfeCteReferenciado in nfeCteReferenciadoList) {
				NfeCteReferenciadoGrouped nfeCteReferenciadoGrouped = NfeCteReferenciadoGrouped(
					nfeCteReferenciado: nfeCteReferenciado,
				);
				nfeCabecalhoGrouped.nfeCteReferenciadoGroupedList!.add(nfeCteReferenciadoGrouped);
			}

			nfeCabecalhoGrouped.nfeCupomFiscalReferenciadoGroupedList = [];
			final queryNfeCupomFiscalReferenciado = ' id_nfe_cabecalho = ${nfeCabecalhoGrouped.nfeCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfeCupomFiscalReferenciado);
			final nfeCupomFiscalReferenciadoList = await (select(nfeCupomFiscalReferenciados)..where((t) => expression)).get();
			for (var nfeCupomFiscalReferenciado in nfeCupomFiscalReferenciadoList) {
				NfeCupomFiscalReferenciadoGrouped nfeCupomFiscalReferenciadoGrouped = NfeCupomFiscalReferenciadoGrouped(
					nfeCupomFiscalReferenciado: nfeCupomFiscalReferenciado,
				);
				nfeCabecalhoGrouped.nfeCupomFiscalReferenciadoGroupedList!.add(nfeCupomFiscalReferenciadoGrouped);
			}

		}		

		return nfeCabecalhoGroupedList;	
	}

	Future<NfeCabecalho?> getObject(dynamic pk) async {
		return await (select(nfeCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeCabecalho;		 
	} 

	Future<NfeCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeCabecalho = object.nfeCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeCabecalhos).insert(object.nfeCabecalho!);
			object.nfeCabecalho = object.nfeCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeCabecalhos).replace(object.nfeCabecalho!);
		});	 
	} 

	Future<int> deleteObject(NfeCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeCabecalhos).delete(object.nfeCabecalho!);
		});		
	}

	Future<void> insertChildren(NfeCabecalhoGrouped object) async {
		for (var nfeReferenciadaGrouped in object.nfeReferenciadaGroupedList!) {
			nfeReferenciadaGrouped.nfeReferenciada = nfeReferenciadaGrouped.nfeReferenciada?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeReferenciadas).insert(nfeReferenciadaGrouped.nfeReferenciada!);
		}
		for (var nfeEmitenteGrouped in object.nfeEmitenteGroupedList!) {
			nfeEmitenteGrouped.nfeEmitente = nfeEmitenteGrouped.nfeEmitente?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeEmitentes).insert(nfeEmitenteGrouped.nfeEmitente!);
		}
		for (var nfeDestinatarioGrouped in object.nfeDestinatarioGroupedList!) {
			nfeDestinatarioGrouped.nfeDestinatario = nfeDestinatarioGrouped.nfeDestinatario?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeDestinatarios).insert(nfeDestinatarioGrouped.nfeDestinatario!);
		}
		for (var nfeLocalRetiradaGrouped in object.nfeLocalRetiradaGroupedList!) {
			nfeLocalRetiradaGrouped.nfeLocalRetirada = nfeLocalRetiradaGrouped.nfeLocalRetirada?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeLocalRetiradas).insert(nfeLocalRetiradaGrouped.nfeLocalRetirada!);
		}
		for (var nfeLocalEntregaGrouped in object.nfeLocalEntregaGroupedList!) {
			nfeLocalEntregaGrouped.nfeLocalEntrega = nfeLocalEntregaGrouped.nfeLocalEntrega?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeLocalEntregas).insert(nfeLocalEntregaGrouped.nfeLocalEntrega!);
		}
		for (var nfeTransporteGrouped in object.nfeTransporteGroupedList!) {
			nfeTransporteGrouped.nfeTransporte = nfeTransporteGrouped.nfeTransporte?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeTransportes).insert(nfeTransporteGrouped.nfeTransporte!);
		}
		for (var nfeFaturaGrouped in object.nfeFaturaGroupedList!) {
			nfeFaturaGrouped.nfeFatura = nfeFaturaGrouped.nfeFatura?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeFaturas).insert(nfeFaturaGrouped.nfeFatura!);
		}
		for (var nfeCanaGrouped in object.nfeCanaGroupedList!) {
			nfeCanaGrouped.nfeCana = nfeCanaGrouped.nfeCana?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeCanas).insert(nfeCanaGrouped.nfeCana!);
		}
		for (var nfeProdRuralReferenciadaGrouped in object.nfeProdRuralReferenciadaGroupedList!) {
			nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada = nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeProdRuralReferenciadas).insert(nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada!);
		}
		for (var nfeNfReferenciadaGrouped in object.nfeNfReferenciadaGroupedList!) {
			nfeNfReferenciadaGrouped.nfeNfReferenciada = nfeNfReferenciadaGrouped.nfeNfReferenciada?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeNfReferenciadas).insert(nfeNfReferenciadaGrouped.nfeNfReferenciada!);
		}
		for (var nfeProcessoReferenciadoGrouped in object.nfeProcessoReferenciadoGroupedList!) {
			nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado = nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeProcessoReferenciados).insert(nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado!);
		}
		for (var nfeAcessoXmlGrouped in object.nfeAcessoXmlGroupedList!) {
			nfeAcessoXmlGrouped.nfeAcessoXml = nfeAcessoXmlGrouped.nfeAcessoXml?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeAcessoXmls).insert(nfeAcessoXmlGrouped.nfeAcessoXml!);
		}
		for (var nfeInformacaoPagamentoGrouped in object.nfeInformacaoPagamentoGroupedList!) {
			nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento = nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeInformacaoPagamentos).insert(nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento!);
		}
		for (var nfeResponsavelTecnicoGrouped in object.nfeResponsavelTecnicoGroupedList!) {
			nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico = nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeResponsavelTecnicos).insert(nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico!);
		}
		for (var nfeCteReferenciadoGrouped in object.nfeCteReferenciadoGroupedList!) {
			nfeCteReferenciadoGrouped.nfeCteReferenciado = nfeCteReferenciadoGrouped.nfeCteReferenciado?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeCteReferenciados).insert(nfeCteReferenciadoGrouped.nfeCteReferenciado!);
		}
		for (var nfeCupomFiscalReferenciadoGrouped in object.nfeCupomFiscalReferenciadoGroupedList!) {
			nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado = nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.copyWith(
				id: const Value(null),
				idNfeCabecalho: Value(object.nfeCabecalho!.id),
			);
			await into(nfeCupomFiscalReferenciados).insert(nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado!);
		}
	}
	
	Future<void> deleteChildren(NfeCabecalhoGrouped object) async {
		await (delete(nfeReferenciadas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeEmitentes)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeDestinatarios)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeLocalRetiradas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeLocalEntregas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeTransportes)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeFaturas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeCanas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeProdRuralReferenciadas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeNfReferenciadas)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeProcessoReferenciados)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeAcessoXmls)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeInformacaoPagamentos)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeResponsavelTecnicos)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeCteReferenciados)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
		await (delete(nfeCupomFiscalReferenciados)..where((t) => t.idNfeCabecalho.equals(object.nfeCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}