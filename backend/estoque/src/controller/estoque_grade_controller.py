from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.estoque_grade_service import EstoqueGradeService

estoque_grade_bp = Blueprint('estoque-grade', __name__)
service = EstoqueGradeService()

@estoque_grade_bp.route('/estoque-grade', methods=['GET'])
@estoque_grade_bp.route('/estoque-grade/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@estoque_grade_bp.route('/estoque-grade/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@estoque_grade_bp.route('/estoque-grade', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@estoque_grade_bp.route('/estoque-grade', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@estoque_grade_bp.route('/estoque-grade/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})