from flask import Flask, render_template, request
from interpretador_candlestick import interpretar_patrones

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    resultados = []
    if request.method == "POST":
        ticker = request.form.get("ticker")
        if ticker:
            resultados = interpretar_patrones(ticker.upper())
    return render_template("index.html", resultados=resultados)
