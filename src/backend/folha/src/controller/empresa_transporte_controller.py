from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.empresa_transporte_service import EmpresaTransporteService

empresa_transporte_bp = Blueprint('empresa-transporte', __name__)
service = EmpresaTransporteService()

@empresa_transporte_bp.route('/empresa-transporte', methods=['GET'])
@empresa_transporte_bp.route('/empresa-transporte/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@empresa_transporte_bp.route('/empresa-transporte/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@empresa_transporte_bp.route('/empresa-transporte', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@empresa_transporte_bp.route('/empresa-transporte', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@empresa_transporte_bp.route('/empresa-transporte/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})