from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.wms_agendamento_service import WmsAgendamentoService

wms_agendamento_bp = Blueprint('wms-agendamento', __name__)
service = WmsAgendamentoService()

@wms_agendamento_bp.route('/wms-agendamento', methods=['GET'])
@wms_agendamento_bp.route('/wms-agendamento/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@wms_agendamento_bp.route('/wms-agendamento/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@wms_agendamento_bp.route('/wms-agendamento', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@wms_agendamento_bp.route('/wms-agendamento', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@wms_agendamento_bp.route('/wms-agendamento/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})