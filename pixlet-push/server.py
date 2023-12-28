import os
import subprocess

from flask import Flask, request, jsonify

app = Flask(__name__)

PIXLET_BINARY = "/pixlet/pixlet"
TEMP_STORAGE = "/tmp/flask"
RENDER_FILE_NAME = f"{TEMP_STORAGE}/rendered.webp"


@app.route('/push', methods=['POST'])
def push():
    device_id = request.form.get('device_id')
    api_key = request.form.get('api_key')

    if not device_id or not api_key:
        return jsonify({'error': 'Missing parameters'}), 400

    uploaded_file = request.files.get('file')
    if not uploaded_file:
        return jsonify({'error': 'No file uploaded'}), 400

    temp_file_path = os.path.join(TEMP_STORAGE, uploaded_file.filename)
    uploaded_file.save(temp_file_path)

    response = jsonify({'message': 'Success'})
    response_code = 200
    skip_send = False

    try:
        subprocess.run([f"{PIXLET_BINARY}", "render", temp_file_path, "-o", RENDER_FILE_NAME], check=True)
    except subprocess.CalledProcessError as e:
        response = jsonify({'error': 'Failed to render file'})
        response_code = 500
        skip_send = True

    if not skip_send:
        try:
            subprocess.run([f"{PIXLET_BINARY}", "push", "--api-token", api_key, device_id, RENDER_FILE_NAME],
                           check=True)
        except subprocess.CalledProcessError as e:
            response = jsonify({'error': 'Failed to display image'})
            response_code = 500

    # Delete all files in the temp storage
    for file in os.listdir(TEMP_STORAGE):
        os.remove(os.path.join(TEMP_STORAGE, file))

    return response, response_code


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
