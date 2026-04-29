from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cte_rodoviario_lacre_service import CteRodoviarioLacreService

cte_rodoviario_lacre_bp = Blueprint('cte-rodoviario-lacre', __name__)
service = CteRodoviarioLacreService()

@cte_rodoviario_lacre_bp.route('/cte-rodoviario-lacre', methods=['GET'])
@cte_rodoviario_lacre_bp.route('/cte-rodoviario-lacre/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cte_rodoviario_lacre_bp.route('/cte-rodoviario-lacre/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cte_rodoviario_lacre_bp.route('/cte-rodoviario-lacre', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cte_rodoviario_lacre_bp.route('/cte-rodoviario-lacre', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cte_rodoviario_lacre_bp.route('/cte-rodoviario-lacre/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})