from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fiscal_estadual_regime_service import FiscalEstadualRegimeService

fiscal_estadual_regime_bp = Blueprint('fiscal-estadual-regime', __name__)
service = FiscalEstadualRegimeService()

@fiscal_estadual_regime_bp.route('/fiscal-estadual-regime', methods=['GET'])
@fiscal_estadual_regime_bp.route('/fiscal-estadual-regime/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fiscal_estadual_regime_bp.route('/fiscal-estadual-regime/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fiscal_estadual_regime_bp.route('/fiscal-estadual-regime', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fiscal_estadual_regime_bp.route('/fiscal-estadual-regime', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fiscal_estadual_regime_bp.route('/fiscal-estadual-regime/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})