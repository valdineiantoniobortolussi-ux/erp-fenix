import 'package:drift/drift.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/provider/drift/database/database_imports.dart';

part 'pcp_servico_dao.g.dart';

@DriftAccessor(tables: [
	PcpServicos,
	PcpServicoColaboradors,
	ViewPessoaColaboradors,
	PcpServicoEquipamentos,
	PatrimBems,
	PcpOpDetalhes,
])
class PcpServicoDao extends DatabaseAccessor<AppDatabase> with _$PcpServicoDaoMixin {
	final AppDatabase db;

	List<PcpServico> pcpServicoList = []; 
	List<PcpServicoGrouped> pcpServicoGroupedList = []; 

	PcpServicoDao(this.db) : super(db);

	Future<List<PcpServico>> getList() async {
		pcpServicoList = await select(pcpServicos).get();
		return pcpServicoList;
	}

	Future<List<PcpServico>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		pcpServicoList = await (select(pcpServicos)..where((t) => expression)).get();
		return pcpServicoList;	 
	}

	Future<List<PcpServicoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(pcpServicos)
			.join([ 
				leftOuterJoin(pcpOpDetalhes, pcpOpDetalhes.id.equalsExp(pcpServicos.idPcpOpDetalhe)), 
			]);

		if (field != null && field != '') { 
			final column = pcpServicos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		pcpServicoGroupedList = await query.map((row) {
			final pcpServico = row.readTableOrNull(pcpServicos); 
			final pcpOpDetalhe = row.readTableOrNull(pcpOpDetalhes); 

			return PcpServicoGrouped(
				pcpServico: pcpServico, 
				pcpOpDetalhe: pcpOpDetalhe, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var pcpServicoGrouped in pcpServicoGroupedList) {
			pcpServicoGrouped.pcpServicoColaboradorGroupedList = [];
			final queryPcpServicoColaborador = ' id_pcp_servico = ${pcpServicoGrouped.pcpServico!.id}';
			expression = CustomExpression<bool>(queryPcpServicoColaborador);
			final pcpServicoColaboradorList = await (select(pcpServicoColaboradors)..where((t) => expression)).get();
			for (var pcpServicoColaborador in pcpServicoColaboradorList) {
				PcpServicoColaboradorGrouped pcpServicoColaboradorGrouped = PcpServicoColaboradorGrouped(
					pcpServicoColaborador: pcpServicoColaborador,
					viewPessoaColaborador: await (select(viewPessoaColaboradors)..where((t) => t.id.equals(pcpServicoColaborador.idColaborador!))).getSingleOrNull(),
				);
				pcpServicoGrouped.pcpServicoColaboradorGroupedList!.add(pcpServicoColaboradorGrouped);
			}

			pcpServicoGrouped.pcpServicoEquipamentoGroupedList = [];
			final queryPcpServicoEquipamento = ' id_pcp_servico = ${pcpServicoGrouped.pcpServico!.id}';
			expression = CustomExpression<bool>(queryPcpServicoEquipamento);
			final pcpServicoEquipamentoList = await (select(pcpServicoEquipamentos)..where((t) => expression)).get();
			for (var pcpServicoEquipamento in pcpServicoEquipamentoList) {
				PcpServicoEquipamentoGrouped pcpServicoEquipamentoGrouped = PcpServicoEquipamentoGrouped(
					pcpServicoEquipamento: pcpServicoEquipamento,
					patrimBem: await (select(patrimBems)..where((t) => t.id.equals(pcpServicoEquipamento.idPatrimBem!))).getSingleOrNull(),
				);
				pcpServicoGrouped.pcpServicoEquipamentoGroupedList!.add(pcpServicoEquipamentoGrouped);
			}

		}		

		return pcpServicoGroupedList;	
	}

	Future<PcpServico?> getObject(dynamic pk) async {
		return await (select(pcpServicos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<PcpServico?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM pcp_servico WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as PcpServico;		 
	} 

	Future<PcpServicoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(PcpServicoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.pcpServico = object.pcpServico!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(pcpServicos).insert(object.pcpServico!);
			object.pcpServico = object.pcpServico!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(PcpServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(pcpServicos).replace(object.pcpServico!);
		});	 
	} 

	Future<int> deleteObject(PcpServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(pcpServicos).delete(object.pcpServico!);
		});		
	}

	Future<void> insertChildren(PcpServicoGrouped object) async {
		for (var pcpServicoColaboradorGrouped in object.pcpServicoColaboradorGroupedList!) {
			pcpServicoColaboradorGrouped.pcpServicoColaborador = pcpServicoColaboradorGrouped.pcpServicoColaborador?.copyWith(
				id: const Value(null),
				idPcpServico: Value(object.pcpServico!.id),
			);
			await into(pcpServicoColaboradors).insert(pcpServicoColaboradorGrouped.pcpServicoColaborador!);
		}
		for (var pcpServicoEquipamentoGrouped in object.pcpServicoEquipamentoGroupedList!) {
			pcpServicoEquipamentoGrouped.pcpServicoEquipamento = pcpServicoEquipamentoGrouped.pcpServicoEquipamento?.copyWith(
				id: const Value(null),
				idPcpServico: Value(object.pcpServico!.id),
			);
			await into(pcpServicoEquipamentos).insert(pcpServicoEquipamentoGrouped.pcpServicoEquipamento!);
		}
	}
	
	Future<void> deleteChildren(PcpServicoGrouped object) async {
		await (delete(pcpServicoColaboradors)..where((t) => t.idPcpServico.equals(object.pcpServico!.id!))).go();
		await (delete(pcpServicoEquipamentos)..where((t) => t.idPcpServico.equals(object.pcpServico!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from pcp_servico").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}