import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/provider/drift/database/database_imports.dart';

part 'contrato_solicitacao_servico_dao.g.dart';

@DriftAccessor(tables: [
	ContratoSolicitacaoServicos,
	ViewPessoaColaboradors,
	ViewPessoaClientes,
	ViewPessoaFornecedors,
	Setors,
	ContratoTipoServicos,
])
class ContratoSolicitacaoServicoDao extends DatabaseAccessor<AppDatabase> with _$ContratoSolicitacaoServicoDaoMixin {
	final AppDatabase db;

	List<ContratoSolicitacaoServico> contratoSolicitacaoServicoList = []; 
	List<ContratoSolicitacaoServicoGrouped> contratoSolicitacaoServicoGroupedList = []; 

	ContratoSolicitacaoServicoDao(this.db) : super(db);

	Future<List<ContratoSolicitacaoServico>> getList() async {
		contratoSolicitacaoServicoList = await select(contratoSolicitacaoServicos).get();
		return contratoSolicitacaoServicoList;
	}

	Future<List<ContratoSolicitacaoServico>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contratoSolicitacaoServicoList = await (select(contratoSolicitacaoServicos)..where((t) => expression)).get();
		return contratoSolicitacaoServicoList;	 
	}

	Future<List<ContratoSolicitacaoServicoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contratoSolicitacaoServicos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(contratoSolicitacaoServicos.idColaborador)), 
			]).join([ 
				leftOuterJoin(viewPessoaClientes, viewPessoaClientes.id.equalsExp(contratoSolicitacaoServicos.idCliente)), 
			]).join([ 
				leftOuterJoin(viewPessoaFornecedors, viewPessoaFornecedors.id.equalsExp(contratoSolicitacaoServicos.idFornecedor)), 
			]).join([ 
				leftOuterJoin(setors, setors.id.equalsExp(contratoSolicitacaoServicos.idSetor)), 
			]).join([ 
				leftOuterJoin(contratoTipoServicos, contratoTipoServicos.id.equalsExp(contratoSolicitacaoServicos.idContratoTipoServico)), 
			]);

		if (field != null && field != '') { 
			final column = contratoSolicitacaoServicos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contratoSolicitacaoServicoGroupedList = await query.map((row) {
			final contratoSolicitacaoServico = row.readTableOrNull(contratoSolicitacaoServicos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 
			final viewPessoaFornecedor = row.readTableOrNull(viewPessoaFornecedors); 
			final setor = row.readTableOrNull(setors); 
			final contratoTipoServico = row.readTableOrNull(contratoTipoServicos); 

			return ContratoSolicitacaoServicoGrouped(
				contratoSolicitacaoServico: contratoSolicitacaoServico, 
				viewPessoaColaborador: viewPessoaColaborador, 
				viewPessoaCliente: viewPessoaCliente, 
				viewPessoaFornecedor: viewPessoaFornecedor, 
				setor: setor, 
				contratoTipoServico: contratoTipoServico, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contratoSolicitacaoServicoGrouped in contratoSolicitacaoServicoGroupedList) {
		//}		

		return contratoSolicitacaoServicoGroupedList;	
	}

	Future<ContratoSolicitacaoServico?> getObject(dynamic pk) async {
		return await (select(contratoSolicitacaoServicos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContratoSolicitacaoServico?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contrato_solicitacao_servico WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContratoSolicitacaoServico;		 
	} 

	Future<ContratoSolicitacaoServicoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContratoSolicitacaoServicoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contratoSolicitacaoServico = object.contratoSolicitacaoServico!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contratoSolicitacaoServicos).insert(object.contratoSolicitacaoServico!);
			object.contratoSolicitacaoServico = object.contratoSolicitacaoServico!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContratoSolicitacaoServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contratoSolicitacaoServicos).replace(object.contratoSolicitacaoServico!);
		});	 
	} 

	Future<int> deleteObject(ContratoSolicitacaoServicoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contratoSolicitacaoServicos).delete(object.contratoSolicitacaoServico!);
		});		
	}

	Future<void> insertChildren(ContratoSolicitacaoServicoGrouped object) async {
	}
	
	Future<void> deleteChildren(ContratoSolicitacaoServicoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contrato_solicitacao_servico").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}