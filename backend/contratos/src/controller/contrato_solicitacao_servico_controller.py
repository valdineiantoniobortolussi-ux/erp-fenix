from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contrato_solicitacao_servico_service import ContratoSolicitacaoServicoService

contrato_solicitacao_servico_bp = Blueprint('contrato-solicitacao-servico', __name__)
service = ContratoSolicitacaoServicoService()

@contrato_solicitacao_servico_bp.route('/contrato-solicitacao-servico', methods=['GET'])
@contrato_solicitacao_servico_bp.route('/contrato-solicitacao-servico/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contrato_solicitacao_servico_bp.route('/contrato-solicitacao-servico/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contrato_solicitacao_servico_bp.route('/contrato-solicitacao-servico', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contrato_solicitacao_servico_bp.route('/contrato-solicitacao-servico', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contrato_solicitacao_servico_bp.route('/contrato-solicitacao-servico/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})