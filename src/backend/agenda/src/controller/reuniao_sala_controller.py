from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.reuniao_sala_service import ReuniaoSalaService

reuniao_sala_bp = Blueprint('reuniao-sala', __name__)
service = ReuniaoSalaService()

@reuniao_sala_bp.route('/reuniao-sala', methods=['GET'])
@reuniao_sala_bp.route('/reuniao-sala/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@reuniao_sala_bp.route('/reuniao-sala/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@reuniao_sala_bp.route('/reuniao-sala', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@reuniao_sala_bp.route('/reuniao-sala', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@reuniao_sala_bp.route('/reuniao-sala/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})