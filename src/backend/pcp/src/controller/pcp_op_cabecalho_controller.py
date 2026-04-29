from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.pcp_op_cabecalho_service import PcpOpCabecalhoService

pcp_op_cabecalho_bp = Blueprint('pcp-op-cabecalho', __name__)
service = PcpOpCabecalhoService()

@pcp_op_cabecalho_bp.route('/pcp-op-cabecalho', methods=['GET'])
@pcp_op_cabecalho_bp.route('/pcp-op-cabecalho/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@pcp_op_cabecalho_bp.route('/pcp-op-cabecalho/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@pcp_op_cabecalho_bp.route('/pcp-op-cabecalho', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@pcp_op_cabecalho_bp.route('/pcp-op-cabecalho', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@pcp_op_cabecalho_bp.route('/pcp-op-cabecalho/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})