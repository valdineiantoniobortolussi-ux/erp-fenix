from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.nfe_transporte_reboque_service import NfeTransporteReboqueService

nfe_transporte_reboque_bp = Blueprint('nfe-transporte-reboque', __name__)
service = NfeTransporteReboqueService()

@nfe_transporte_reboque_bp.route('/nfe-transporte-reboque', methods=['GET'])
@nfe_transporte_reboque_bp.route('/nfe-transporte-reboque/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@nfe_transporte_reboque_bp.route('/nfe-transporte-reboque/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@nfe_transporte_reboque_bp.route('/nfe-transporte-reboque', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@nfe_transporte_reboque_bp.route('/nfe-transporte-reboque', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@nfe_transporte_reboque_bp.route('/nfe-transporte-reboque/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})