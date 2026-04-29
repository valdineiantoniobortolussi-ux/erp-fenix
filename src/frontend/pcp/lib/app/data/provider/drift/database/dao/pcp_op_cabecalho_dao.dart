import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/provider/drift/database/database_imports.dart';

part 'pcp_op_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	PcpOpCabecalhos,
	PcpOpDetalhes,
	Produtos,
	PcpInstrucaoOps,
	PcpInstrucaos,
])
class PcpOpCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$PcpOpCabecalhoDaoMixin {
	final AppDatabase db;

	List<PcpOpCabecalho> pcpOpCabecalhoList = []; 
	List<PcpOpCabecalhoGrouped> pcpOpCabecalhoGroupedList = []; 

	PcpOpCabecalhoDao(this.db) : super(db);

	Future<List<PcpOpCabecalho>> getList() async {
		pcpOpCabecalhoList = await select(pcpOpCabecalhos).get();
		return pcpOpCabecalhoList;
	}

	Future<List<PcpOpCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pcpOpCabecalhoList = await (select(pcpOpCabecalhos)..where((t) => expression)).get();
		return pcpOpCabecalhoList;	 
	}

	Future<List<PcpOpCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pcpOpCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = pcpOpCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pcpOpCabecalhoGroupedList = await query.map((row) {
			final pcpOpCabecalho = row.readTableOrNull(pcpOpCabecalhos); 

			return PcpOpCabecalhoGrouped(
				pcpOpCabecalho: pcpOpCabecalho, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var pcpOpCabecalhoGrouped in pcpOpCabecalhoGroupedList) {
			pcpOpCabecalhoGrouped.pcpOpDetalheGroupedList = [];
			final queryPcpOpDetalhe = ' id_pcp_op_cabecalho = ${pcpOpCabecalhoGrouped.pcpOpCabecalho!.id}';
			expression = CustomExpression<bool>(queryPcpOpDetalhe);
			final pcpOpDetalheList = await (select(pcpOpDetalhes)..where((t) => expression)).get();
			for (var pcpOpDetalhe in pcpOpDetalheList) {
				PcpOpDetalheGrouped pcpOpDetalheGrouped = PcpOpDetalheGrouped(
					pcpOpDetalhe: pcpOpDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(pcpOpDetalhe.idProduto!))).getSingleOrNull(),
				);
				pcpOpCabecalhoGrouped.pcpOpDetalheGroupedList!.add(pcpOpDetalheGrouped);
			}

			pcpOpCabecalhoGrouped.pcpInstrucaoOpGroupedList = [];
			final queryPcpInstrucaoOp = ' id_pcp_op_cabecalho = ${pcpOpCabecalhoGrouped.pcpOpCabecalho!.id}';
			expression = CustomExpression<bool>(queryPcpInstrucaoOp);
			final pcpInstrucaoOpList = await (select(pcpInstrucaoOps)..where((t) => expression)).get();
			for (var pcpInstrucaoOp in pcpInstrucaoOpList) {
				PcpInstrucaoOpGrouped pcpInstrucaoOpGrouped = PcpInstrucaoOpGrouped(
					pcpInstrucaoOp: pcpInstrucaoOp,
					pcpInstrucao: await (select(pcpInstrucaos)..where((t) => t.id.equals(pcpInstrucaoOp.idPcpInstrucao!))).getSingleOrNull(),
				);
				pcpOpCabecalhoGrouped.pcpInstrucaoOpGroupedList!.add(pcpInstrucaoOpGrouped);
			}

		}		

		return pcpOpCabecalhoGroupedList;	
	}

	Future<PcpOpCabecalho?> getObject(dynamic pk) async {
		return await (select(pcpOpCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PcpOpCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM pcp_op_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PcpOpCabecalho;		 
	} 

	Future<PcpOpCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PcpOpCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pcpOpCabecalho = object.pcpOpCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pcpOpCabecalhos).insert(object.pcpOpCabecalho!);
			object.pcpOpCabecalho = object.pcpOpCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PcpOpCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pcpOpCabecalhos).replace(object.pcpOpCabecalho!);
		});	 
	} 

	Future<int> deleteObject(PcpOpCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pcpOpCabecalhos).delete(object.pcpOpCabecalho!);
		});		
	}

	Future<void> insertChildren(PcpOpCabecalhoGrouped object) async {
		for (var pcpOpDetalheGrouped in object.pcpOpDetalheGroupedList!) {
			pcpOpDetalheGrouped.pcpOpDetalhe = pcpOpDetalheGrouped.pcpOpDetalhe?.copyWith(
				id: const Value(null),
				idPcpOpCabecalho: Value(object.pcpOpCabecalho!.id),
			);
			await into(pcpOpDetalhes).insert(pcpOpDetalheGrouped.pcpOpDetalhe!);
		}
		for (var pcpInstrucaoOpGrouped in object.pcpInstrucaoOpGroupedList!) {
			pcpInstrucaoOpGrouped.pcpInstrucaoOp = pcpInstrucaoOpGrouped.pcpInstrucaoOp?.copyWith(
				id: const Value(null),
				idPcpOpCabecalho: Value(object.pcpOpCabecalho!.id),
			);
			await into(pcpInstrucaoOps).insert(pcpInstrucaoOpGrouped.pcpInstrucaoOp!);
		}
	}
	
	Future<void> deleteChildren(PcpOpCabecalhoGrouped object) async {
		await (delete(pcpOpDetalhes)..where((t) => t.idPcpOpCabecalho.equals(object.pcpOpCabecalho!.id!))).go();
		await (delete(pcpInstrucaoOps)..where((t) => t.idPcpOpCabecalho.equals(object.pcpOpCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from pcp_op_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}