from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fiscal_estadual_porte_service import FiscalEstadualPorteService

fiscal_estadual_porte_bp = Blueprint('fiscal-estadual-porte', __name__)
service = FiscalEstadualPorteService()

@fiscal_estadual_porte_bp.route('/fiscal-estadual-porte', methods=['GET'])
@fiscal_estadual_porte_bp.route('/fiscal-estadual-porte/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fiscal_estadual_porte_bp.route('/fiscal-estadual-porte/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fiscal_estadual_porte_bp.route('/fiscal-estadual-porte', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fiscal_estadual_porte_bp.route('/fiscal-estadual-porte', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fiscal_estadual_porte_bp.route('/fiscal-estadual-porte/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})