from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.orcamento_empresarial_service import OrcamentoEmpresarialService

orcamento_empresarial_bp = Blueprint('orcamento-empresarial', __name__)
service = OrcamentoEmpresarialService()

@orcamento_empresarial_bp.route('/orcamento-empresarial', methods=['GET'])
@orcamento_empresarial_bp.route('/orcamento-empresarial/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@orcamento_empresarial_bp.route('/orcamento-empresarial/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@orcamento_empresarial_bp.route('/orcamento-empresarial', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@orcamento_empresarial_bp.route('/orcamento-empresarial', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@orcamento_empresarial_bp.route('/orcamento-empresarial/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})