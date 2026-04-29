from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.cte_ferroviario_ferrovia_service import CteFerroviarioFerroviaService

cte_ferroviario_ferrovia_bp = Blueprint('cte-ferroviario-ferrovia', __name__)
service = CteFerroviarioFerroviaService()

@cte_ferroviario_ferrovia_bp.route('/cte-ferroviario-ferrovia', methods=['GET'])
@cte_ferroviario_ferrovia_bp.route('/cte-ferroviario-ferrovia/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@cte_ferroviario_ferrovia_bp.route('/cte-ferroviario-ferrovia/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@cte_ferroviario_ferrovia_bp.route('/cte-ferroviario-ferrovia', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@cte_ferroviario_ferrovia_bp.route('/cte-ferroviario-ferrovia', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@cte_ferroviario_ferrovia_bp.route('/cte-ferroviario-ferrovia/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})