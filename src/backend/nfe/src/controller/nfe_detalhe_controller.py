from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nfe_detalhe_service import NfeDetalheService

nfe_detalhe_bp = Blueprint('nfe-detalhe', __name__)
service = NfeDetalheService()

@nfe_detalhe_bp.route('/nfe-detalhe', methods=['GET'])
@nfe_detalhe_bp.route('/nfe-detalhe/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nfe_detalhe_bp.route('/nfe-detalhe/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nfe_detalhe_bp.route('/nfe-detalhe', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nfe_detalhe_bp.route('/nfe-detalhe', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nfe_detalhe_bp.route('/nfe-detalhe/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})