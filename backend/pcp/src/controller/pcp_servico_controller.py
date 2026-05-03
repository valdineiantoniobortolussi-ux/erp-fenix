from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.pcp_servico_service import PcpServicoService

pcp_servico_bp = Blueprint('pcp-servico', __name__)
service = PcpServicoService()

@pcp_servico_bp.route('/pcp-servico', methods=['GET'])
@pcp_servico_bp.route('/pcp-servico/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@pcp_servico_bp.route('/pcp-servico/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@pcp_servico_bp.route('/pcp-servico', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@pcp_servico_bp.route('/pcp-servico', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@pcp_servico_bp.route('/pcp-servico/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})