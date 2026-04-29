from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cte_documento_anterior_id_service import CteDocumentoAnteriorIdService

cte_documento_anterior_id_bp = Blueprint('cte-documento-anterior-id', __name__)
service = CteDocumentoAnteriorIdService()

@cte_documento_anterior_id_bp.route('/cte-documento-anterior-id', methods=['GET'])
@cte_documento_anterior_id_bp.route('/cte-documento-anterior-id/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cte_documento_anterior_id_bp.route('/cte-documento-anterior-id/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cte_documento_anterior_id_bp.route('/cte-documento-anterior-id', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cte_documento_anterior_id_bp.route('/cte-documento-anterior-id', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cte_documento_anterior_id_bp.route('/cte-documento-anterior-id/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})