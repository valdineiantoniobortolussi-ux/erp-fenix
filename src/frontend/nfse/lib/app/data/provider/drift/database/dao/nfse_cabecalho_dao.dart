import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/provider/drift/database/database_imports.dart';

part 'nfse_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	NfseCabecalhos,
	NfseDetalhes,
	NfseListaServicos,
	NfseIntermediarios,
	ViewPessoaClientes,
	OsAberturas,
])
class NfseCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$NfseCabecalhoDaoMixin {
	final AppDatabase db;

	List<NfseCabecalho> nfseCabecalhoList = []; 
	List<NfseCabecalhoGrouped> nfseCabecalhoGroupedList = []; 

	NfseCabecalhoDao(this.db) : super(db);

	Future<List<NfseCabecalho>> getList() async {
		nfseCabecalhoList = await select(nfseCabecalhos).get();
		return nfseCabecalhoList;
	}

	Future<List<NfseCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfseCabecalhoList = await (select(nfseCabecalhos)..where((t) => expression)).get();
		return nfseCabecalhoList;	 
	}

	Future<List<NfseCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfseCabecalhos)
			.join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(nfseCabecalhos.idCliente)), 
			]).join([ 
				leftOuterJoin(osAberturas, osAberturas.id.equalsExp(nfseCabecalhos.idOsAbertura)), 
			]);

		if (field != null && field != '') { 
			final column = nfseCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfseCabecalhoGroupedList = await query.map((row) {
			final nfseCabecalho = row.readTableOrNull(nfseCabecalhos); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 
			final osAbertura = row.readTableOrNull(osAberturas); 

			return NfseCabecalhoGrouped(
				nfseCabecalho: nfseCabecalho, 
				viewPessoaCliente: viewPessoaCliente, 
				osAbertura: osAbertura, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var nfseCabecalhoGrouped in nfseCabecalhoGroupedList) {
			nfseCabecalhoGrouped.nfseDetalheGroupedList = [];
			final queryNfseDetalhe = ' id_nfse_cabecalho = ${nfseCabecalhoGrouped.nfseCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfseDetalhe);
			final nfseDetalheList = await (select(nfseDetalhes)..where((t) => expression)).get();
			for (var nfseDetalhe in nfseDetalheList) {
				NfseDetalheGrouped nfseDetalheGrouped = NfseDetalheGrouped(
					nfseDetalhe: nfseDetalhe,
					nfseListaServico: await (select(nfseListaServicos)..where((t) => t.id.equals(nfseDetalhe.idNfseListaServico!))).getSingleOrNull(),
				);
				nfseCabecalhoGrouped.nfseDetalheGroupedList!.add(nfseDetalheGrouped);
			}

			nfseCabecalhoGrouped.nfseIntermediarioGroupedList = [];
			final queryNfseIntermediario = ' id_nfse_cabecalho = ${nfseCabecalhoGrouped.nfseCabecalho!.id}';
			expression = CustomExpression<bool>(queryNfseIntermediario);
			final nfseIntermediarioList = await (select(nfseIntermediarios)..where((t) => expression)).get();
			for (var nfseIntermediario in nfseIntermediarioList) {
				NfseIntermediarioGrouped nfseIntermediarioGrouped = NfseIntermediarioGrouped(
					nfseIntermediario: nfseIntermediario,
				);
				nfseCabecalhoGrouped.nfseIntermediarioGroupedList!.add(nfseIntermediarioGrouped);
			}

		}		

		return nfseCabecalhoGroupedList;	
	}

	Future<NfseCabecalho?> getObject(dynamic pk) async {
		return await (select(nfseCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfseCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfse_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfseCabecalho;		 
	} 

	Future<NfseCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfseCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfseCabecalho = object.nfseCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfseCabecalhos).insert(object.nfseCabecalho!);
			object.nfseCabecalho = object.nfseCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfseCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfseCabecalhos).replace(object.nfseCabecalho!);
		});	 
	} 

	Future<int> deleteObject(NfseCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfseCabecalhos).delete(object.nfseCabecalho!);
		});		
	}

	Future<void> insertChildren(NfseCabecalhoGrouped object) async {
		for (var nfseDetalheGrouped in object.nfseDetalheGroupedList!) {
			nfseDetalheGrouped.nfseDetalhe = nfseDetalheGrouped.nfseDetalhe?.copyWith(
				id: const Value(null),
				idNfseCabecalho: Value(object.nfseCabecalho!.id),
			);
			await into(nfseDetalhes).insert(nfseDetalheGrouped.nfseDetalhe!);
		}
		for (var nfseIntermediarioGrouped in object.nfseIntermediarioGroupedList!) {
			nfseIntermediarioGrouped.nfseIntermediario = nfseIntermediarioGrouped.nfseIntermediario?.copyWith(
				id: const Value(null),
				idNfseCabecalho: Value(object.nfseCabecalho!.id),
			);
			await into(nfseIntermediarios).insert(nfseIntermediarioGrouped.nfseIntermediario!);
		}
	}
	
	Future<void> deleteChildren(NfseCabecalhoGrouped object) async {
		await (delete(nfseDetalhes)..where((t) => t.idNfseCabecalho.equals(object.nfseCabecalho!.id!))).go();
		await (delete(nfseIntermediarios)..where((t) => t.idNfseCabecalho.equals(object.nfseCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfse_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}