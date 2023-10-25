from flask import Flask, request, jsonify
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

class DatabaseConnector:
    def __init__(self):
        self.db_config = {
            'user': 'root',
            'password': '',
            'host': 'localhost',
            'database': 'fbx'
        }

    def get_db_connection(self):
        return mysql.connector.connect(**self.db_config)


class PostHandler:
    def __init__(self, db_connector):
        self.db_connector = db_connector

    def create_post(self, data):
        conn = self.db_connector.get_db_connection()
        cursor = conn.cursor()

        if data.get('location_id') is not None:
            cursor.execute("INSERT INTO posts (content, user_id, location_id) VALUES (%s, %s, %s)",
                           (data['content'], data['user_id'], data['location_id']))
        else:
            cursor.execute("INSERT INTO posts (content, user_id) VALUES (%s, %s)",
                           (data['content'], data['user_id']))

        post_id = cursor.lastrowid

        for friend_id in data.get('tagged_friends', []):
            cursor.execute("INSERT INTO posttags (post_id, user_id) VALUES (%s, %s)", (post_id, friend_id))

        conn.commit()
        cursor.close()
        conn.close()

        return {"message": "Post created successfully!"}, 201


class ViewHandler:
    def __init__(self, db_connector):
        self.db_connector = db_connector

    def view_all_posts(self):
        conn = self.db_connector.get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM posts")
        columns = [desc[0] for desc in cursor.description]
        posts = [dict(zip(columns, row)) for row in cursor.fetchall()]

        for post in posts:
            cursor.execute("SELECT user_id FROM posttags WHERE post_id = %s", (post['post_id'],))
            post['tagged_friends'] = [row[0] for row in cursor.fetchall()]

        cleaned_posts = [{k: v for k, v in post.items() if v is not None} for post in posts]

        cursor.close()
        conn.close()

        return {"data": cleaned_posts}

    def view_user_posts(self, user_id):
        conn = self.db_connector.get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM posts WHERE user_id = %s", (user_id,))
        authored_posts = cursor.fetchall()

        cursor.execute("SELECT post_id FROM posttags WHERE user_id = %s", (user_id,))
        tagged_post_ids = [row[0] for row in cursor.fetchall()]

        if tagged_post_ids:
            format_strings = ','.join(['%s'] * len(tagged_post_ids))
            cursor.execute("SELECT * FROM posts WHERE post_id IN (%s)" % format_strings, tuple(tagged_post_ids))
            tagged_posts = cursor.fetchall()
        else:
            tagged_posts = []

        all_posts = authored_posts + tagged_posts

        result = []
        for post_row in all_posts:
            post_dict = {
                "post_id": post_row[0],
                "user_id": post_row[1],
                "content": post_row[2],
                "location_id": post_row[3]
            }
            cursor.execute("SELECT user_id FROM posttags WHERE post_id = %s", (post_dict['post_id'],))
            post_dict['tagged_friends'] = [row[0] for row in cursor.fetchall()]
            result.append(post_dict)

        cursor.close()
        conn.close()

        return result

    def view_location_posts(self, location_id):
        conn = self.db_connector.get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM posts WHERE location_id = %s", (location_id,))
        columns = [desc[0] for desc in cursor.description]
        posts = [dict(zip(columns, row)) for row in cursor.fetchall()]

        for post in posts:
            cursor.execute("SELECT user_id FROM posttags WHERE post_id = %s", (post['post_id'],))
            post['tagged_friends'] = [row[0] for row in cursor.fetchall()]

        cleaned_posts = [{k: v for k, v in post.items() if v is not None} for post in posts]

        cursor.close()
        conn.close()

        return {"data": cleaned_posts}

db_connector = DatabaseConnector()
post_handler = PostHandler(db_connector)
view_handler = ViewHandler(db_connector)

@app.route('/post', methods=['POST'])
def create_post():
    data = request.json
    response, status_code = post_handler.create_post(data)
    return jsonify(response), status_code

@app.route('/view', methods=['GET'])
def view_all_posts():
    response = view_handler.view_all_posts()
    return jsonify(response)

@app.route('/view/user/<int:user_id>', methods=['GET'])
def view_user_posts(user_id):
    response = view_handler.view_user_posts(user_id)
    return jsonify(response)

@app.route('/view/location/<int:location_id>', methods=['GET'])
def view_location_posts(location_id):
    response = view_handler.view_location_posts(location_id)
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
