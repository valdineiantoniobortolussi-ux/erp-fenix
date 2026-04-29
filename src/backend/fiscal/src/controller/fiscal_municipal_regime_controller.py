from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fiscal_municipal_regime_service import FiscalMunicipalRegimeService

fiscal_municipal_regime_bp = Blueprint('fiscal-municipal-regime', __name__)
service = FiscalMunicipalRegimeService()

@fiscal_municipal_regime_bp.route('/fiscal-municipal-regime', methods=['GET'])
@fiscal_municipal_regime_bp.route('/fiscal-municipal-regime/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fiscal_municipal_regime_bp.route('/fiscal-municipal-regime/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fiscal_municipal_regime_bp.route('/fiscal-municipal-regime', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fiscal_municipal_regime_bp.route('/fiscal-municipal-regime', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fiscal_municipal_regime_bp.route('/fiscal-municipal-regime/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})