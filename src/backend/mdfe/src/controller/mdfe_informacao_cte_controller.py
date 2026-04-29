from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.mdfe_informacao_cte_service import MdfeInformacaoCteService

mdfe_informacao_cte_bp = Blueprint('mdfe-informacao-cte', __name__)
service = MdfeInformacaoCteService()

@mdfe_informacao_cte_bp.route('/mdfe-informacao-cte', methods=['GET'])
@mdfe_informacao_cte_bp.route('/mdfe-informacao-cte/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@mdfe_informacao_cte_bp.route('/mdfe-informacao-cte/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@mdfe_informacao_cte_bp.route('/mdfe-informacao-cte', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@mdfe_informacao_cte_bp.route('/mdfe-informacao-cte', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@mdfe_informacao_cte_bp.route('/mdfe-informacao-cte/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})