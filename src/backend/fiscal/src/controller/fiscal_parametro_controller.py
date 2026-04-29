from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fiscal_parametro_service import FiscalParametroService

fiscal_parametro_bp = Blueprint('fiscal-parametro', __name__)
service = FiscalParametroService()

@fiscal_parametro_bp.route('/fiscal-parametro', methods=['GET'])
@fiscal_parametro_bp.route('/fiscal-parametro/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fiscal_parametro_bp.route('/fiscal-parametro/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fiscal_parametro_bp.route('/fiscal-parametro', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fiscal_parametro_bp.route('/fiscal-parametro', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fiscal_parametro_bp.route('/fiscal-parametro/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})