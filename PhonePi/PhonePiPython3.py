from flask import Flask 
from flask_sockets import Sockets
import sys
import os

app = Flask(__name__) 
sockets = Sockets(app)
if sys.argv[1]:
	DIR = "./data/" + sys.argv[1] + "/"
	if not os.path.exists(DIR):
		os.mkdir(DIR)
else:
	DIR = ""


@sockets.route('/accelerometer') 
def echo_socket(ws):
	f=open(DIR+"accelerometer.txt","a")
	while True: 
		message = ws.receive()
		# print(message) 
		ws.send(message)
		print(message, file=f)
	f.close()


@sockets.route('/gyroscope')
def echo_socket(ws):
	f=open(DIR+"gyroscope.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()
	
@sockets.route('/magnetometer')
def echo_socket(ws):
	f=open(DIR+"magnetometer.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

@sockets.route('/orientation')
def echo_socket(ws):
	f=open(DIR+"orientation.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

@sockets.route('/stepcounter')
def echo_socket(ws):
	f=open(DIR+"stepcounter.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

@sockets.route('/thermometer')
def echo_socket(ws):
	f=open(DIR+"thermometer.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

@sockets.route('/lightsensor')
def echo_socket(ws):
	f=open(DIR+"lightsensor.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

@sockets.route('/proximity')
def echo_socket(ws):
	f=open(DIR+"proximity.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

@sockets.route('/geolocation')
def echo_socket(ws):
	f=open(DIR+"geolocation.txt","a")
	while True:
		message = ws.receive()
		# print(message)
		ws.send(message)
		print(message, file=f)
	f.close()

	

@app.route('/') 
def hello(): 
	return 'Hello World!'

if __name__ == "__main__":
	from gevent import pywsgi
	from geventwebsocket.handler import WebSocketHandler
	server = pywsgi.WSGIServer(('0.0.0.0', 5000), app, handler_class=WebSocketHandler)
	server.serve_forever()
