from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.folha_tipo_afastamento_service import FolhaTipoAfastamentoService

folha_tipo_afastamento_bp = Blueprint('folha-tipo-afastamento', __name__)
service = FolhaTipoAfastamentoService()

@folha_tipo_afastamento_bp.route('/folha-tipo-afastamento', methods=['GET'])
@folha_tipo_afastamento_bp.route('/folha-tipo-afastamento/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@folha_tipo_afastamento_bp.route('/folha-tipo-afastamento/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@folha_tipo_afastamento_bp.route('/folha-tipo-afastamento', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@folha_tipo_afastamento_bp.route('/folha-tipo-afastamento', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@folha_tipo_afastamento_bp.route('/folha-tipo-afastamento/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})