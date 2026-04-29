from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.ferias_periodo_aquisitivo_service import FeriasPeriodoAquisitivoService

ferias_periodo_aquisitivo_bp = Blueprint('ferias-periodo-aquisitivo', __name__)
service = FeriasPeriodoAquisitivoService()

@ferias_periodo_aquisitivo_bp.route('/ferias-periodo-aquisitivo', methods=['GET'])
@ferias_periodo_aquisitivo_bp.route('/ferias-periodo-aquisitivo/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@ferias_periodo_aquisitivo_bp.route('/ferias-periodo-aquisitivo/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@ferias_periodo_aquisitivo_bp.route('/ferias-periodo-aquisitivo', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@ferias_periodo_aquisitivo_bp.route('/ferias-periodo-aquisitivo', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@ferias_periodo_aquisitivo_bp.route('/ferias-periodo-aquisitivo/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})