from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.orcamento_periodo_service import OrcamentoPeriodoService

orcamento_periodo_bp = Blueprint('orcamento-periodo', __name__)
service = OrcamentoPeriodoService()

@orcamento_periodo_bp.route('/orcamento-periodo', methods=['GET'])
@orcamento_periodo_bp.route('/orcamento-periodo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@orcamento_periodo_bp.route('/orcamento-periodo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@orcamento_periodo_bp.route('/orcamento-periodo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@orcamento_periodo_bp.route('/orcamento-periodo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@orcamento_periodo_bp.route('/orcamento-periodo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})