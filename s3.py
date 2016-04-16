import json
import requests
import time
import copy
from pprint import pprint
jsonform = []
with open('s2.json') as file:
	payloads = json.load(file);
with open('s1.json') as data_file:
	data = json.load(data_file)
	for urls in data["urls"]:
		url = urls["url"]
		if urls["loginrequired"] == "true":
			# Fill in your details here to be posted to the login form.
			# Get log in details from config file
			#loginpayload = {
			#	'_qf__login_form':'',
			#	'login': 'student',
			#	'password': 'student',
			#	'submit_login':'Login'
			#}
			loginpayload = urls["loginpayload"]
			loginurl = urls["loginurl"]
			# Log in first
			# get log in url from config file
			with requests.Session() as s:
				p = s.post(loginurl, data=loginpayload, verify=False)
				# print the html returned or something more intelligent to see if it's a successful login page.
				if p.status_code != 200:
					print "Error while log in"
				else:
					# An authorised request.
					initialLoad = copy.deepcopy(urls["param"])
					if(urls["type"]=="GET"):
						start = time.time()
						initialRequest = s.get(url,params = initialLoad, verify = False)
					else:
						start = time.time()
						initialRequest = s.post(url,data = initialLoad, verify = False)
					initialRequest.content
					initialTrip = time.time() - start
					initialLength = int(initialRequest.headers["Content-Length"])
					initialStatus = initialRequest.status_code
					initialEndingUrl = initialRequest.url
					print "initial trip:" + str(initialTrip)
					print "initial length:"+ str(initialLength)
					print "initial status:"+str(initialStatus)
					for param in initialLoad:
						for payload in payloads:
							#replace each parameter with the payload to test
							load = copy.deepcopy(initialLoad)
							load[param] = load[param]+payload
							if(urls["type"]=="GET"):
								start = time.time()
								r = s.get(url,params = load, verify = False)
							else:
								start = time.time()
								r = s.post(url,data = load, verify = False)
							r.content
							trip = time.time() - start
							length = int(r.headers["Content-Length"])
							status = r.status_code
							newEndingUrl = r.url
							# only if the content lenght is larger, and the status code is 200
							# or the response time is much longger say 5 seconds for Time-based blind SQL injection
							# we consider it's a valid attack
							print "new trip:" + str(trip)
							print "new length:" + str(length)
							print "new status:" + str(status)
							print r.url
							print load
							if (((length > initialLength) & (status == 200)) | ((trip - initialTrip) > 5)) & ("error" not in str(r.url)):
								initialUrl = copy.deepcopy(urls)
								initialUrl["param"] = load
								jsonform.append(initialUrl)

		else:
			# No need to log in.
			initialLoad = copy.deepcopy(urls["param"])
			if (urls["type"] == "GET"):
				start = time.time()
				initialRequest = requests.get(url, params=initialLoad, verify=False)
			else:
				start = time.time()
				initialRequest = requests.post(url, data=initialLoad, verify=False)
			initialRequest.content
			initialTrip = time.time() - start
			initialLength = int(initialRequest.headers["Content-Length"])
			initialStatus = initialRequest.status_code
			initialEndingUrl = initialRequest.url
			print "initial trip:" + str(initialTrip)
			print "initial length:" + str(initialLength)
			print "initial status:" + str(initialStatus)
			for param in initialLoad:
				for payload in payloads:
					# replace each parameter with the payload to test
					load = copy.deepcopy(initialLoad)
					load[param] =  load[param]+payload
					print urls["type"]
					if (urls["type"] == "GET"):
						start = time.time()
						r = requests.get(url, params=load, verify=False)
					else:
						start = time.time()
						r = requests.post(url, data=load, verify=False)
					r.content
					trip = time.time() - start
					length = int(r.headers["Content-Length"])
					status = r.status_code
					newEndingUrl = r.url
					# only if the content lenght is larger, and the status code is 200
					# or the response time is much longger say 5 seconds for Time-based blind SQL injection
					# we consider it's a valid attack
					print "new trip:" + str(trip)
					print "new length:" + str(length)
					print "new status:" + str(status)
					print r.url
					print load
					if (((length > initialLength) & (status == 200)) |  ((trip - initialTrip) > 5))& ("error" not in str(r.url)):
						initialUrl = copy.deepcopy(urls)
						initialUrl["param"] = load
						jsonform.append(initialUrl)


with open("phase3_output.json",'w') as outfile:	
    json.dump(jsonform,outfile,indent=2)
			