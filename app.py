from flask import Flask, jsonify, request
app = Flask(__name__)

books = []


@app.route('/books', methods=['GET', 'POST'])
def all_books():
    if request.method == 'POST':
        book = request.get_json()
        books.append(book)
        return jsonify(book)
    else:
        return jsonify(books)


@app.route('/books/<int:id>', methods=['GET', 'PUT', 'DELETE'])
def book_by_id(id):
    if request.method == 'GET':
        return jsonify(books[id])
    elif request.method == 'PUT':
        book = request.get_json()
        books[id] = book
        return jsonify(book)
    elif request.method == 'DELETE':
        books.pop(id)
        return jsonify({'result': True})
