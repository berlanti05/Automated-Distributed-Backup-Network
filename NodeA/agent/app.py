from flask import Flask, render_template, jsonify
import subprocess
import json
import os

app = Flask(__name__)

LOG_FILE = "log.json"


# initialize log file if not exists
if not os.path.exists(LOG_FILE):
    with open(LOG_FILE, "w") as f:
        json.dump({"success": 0, "fail": 0}, f)


def update_log(status):
    with open(LOG_FILE, "r") as f:
        data = json.load(f)

    if status == "success":
        data["success"] += 1
    else:
        data["fail"] += 1

    with open(LOG_FILE, "w") as f:
        json.dump(data, f)

    return data


def read_log():
    with open(LOG_FILE, "r") as f:
        return json.load(f)


@app.route('/')
def home():
    return render_template("index.html")


@app.route('/stats')
def stats():
    return jsonify(read_log())


@app.route('/backup')
def backup():
    try:
        subprocess.run(["bash", "../Dashbackup.sh"])
        data = update_log("success")
        return jsonify({"status": "success", "stats": data})
    except:
        data = update_log("fail")
        return jsonify({"status": "error", "stats": data})


@app.route('/restore')
def restore():
    try:
        subprocess.run(["bash", "../restore.sh"])
        data = update_log("success")
        return jsonify({"status": "success", "stats": data})
    except:
        data = update_log("fail")
        return jsonify({"status": "error", "stats": data})


if __name__ == '__main__':
    app.run(debug=True)
