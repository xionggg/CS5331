import yaml
import json
import requests
import time
import copy
from pprint import pprint
jsonform = []
with open('s2.json') as file:
	payloads = yaml.safe_load(file);
with open('s1.json') as data_file:
	data = json.load(data_file)
	for urls in data["urls"]:
		url = urls["url"]
		header = urls["header"]
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
						initialRequest = s.get(url,params = initialLoad, headers=header, verify = False)
					else:
						start = time.time()
						initialRequest = s.post(url,data = initialLoad, headers=header, verify = False)
					initialRequest.content
					initialTrip = time.time() - start
					initialLength = int(initialRequest.headers["Content-Length"])
					initialStatus = initialRequest.status_code
					initialEndingUrl = initialRequest.url
					print "initial trip:" + str(initialTrip)
					print "initial length:"+ str(initialLength)
					print "initial status:"+str(initialStatus)
					print initialEndingUrl
					# check for each param change the payload
					for param in initialLoad:
						for payload in payloads:
							#replace each parameter with the payload to test
							load = copy.deepcopy(initialLoad)
							load[param] = load[param]+payload
							if(urls["type"]=="GET"):
								start = time.time()
								r = s.get(url,params = load, headers=header, verify = False)
							else:
								start = time.time()
								r = s.post(url,data = load, headers=header, verify = False)
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
					#check for header parameter, change to payload
					#check if the header referer is used
					newHeader = copy.deepcopy(header)
					load = copy.deepcopy(initialLoad)
					newHeader["Referer"] = "http://google.com";
					if(urls["type"]=="GET"):
						r = s.get(url,params = load, headers=newHeader, verify = False)
					else:
						r = s.post(url,data = load, headers=newHeader, verify = False)
					r.content						
					length = int(r.headers["Content-Length"])
					status = r.status_code
					newEndingUrl = r.url
					print "after changing header length"+str(length)
					print "initial length"+str(initialLength)
					print "after changing header status"+str(status)
					print "after changing header ending url"+str(newEndingUrl)
					print "initial ending url"+str(initialEndingUrl)
					print (length!=initialLength)
					print (status!=200)
					print (newEndingUrl != initialEndingUrl)
					parsedInitialEndingUrl=initialEndingUrl
					if("?" in initialEndingUrl):
						index = int(initialEndingUrl.find("?"))
						print index
						parsedInitialEndingUrl = initialEndingUrl[0:index]
					parsedNewEndingUrl = newEndingUrl
					if("?" in newEndingUrl):
						index = int(newEndingUrl.find("?"))
						print index
						parsedNewEndingUrl = newEndingUrl[0:index]
					#if the content different or url is different or status code is different, the referer is used
					if((length!=initialLength)|(status!=200)|(parsedNewEndingUrl != parsedInitialEndingUrl)):
						print "referer is used here"
						print newEndingUrl
						#referer is used, change the referer to different payload to test
						for payload in payloads:
						#replace each parameter with the payload to test
							load = copy.deepcopy(initialLoad)
							newHeader = copy.deepcopy(header)
							newHeader["Referer"] = newHeader["Referer"]+payload
							if(urls["type"]=="GET"):
								start = time.time()
								r = s.get(url,params = load, headers=newHeader, verify = False)
							else:
								start = time.time()
								r = s.post(url,data = load, headers=newHeader, verify = False)
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
							if (((length >= initialLength) & (status == 200)) | ((trip - initialTrip) > 5)) & ("error" not in str(r.url)):
								initialUrl = copy.deepcopy(urls)
								initialUrl["header"] = newHeader
								jsonform.append(initialUrl)
		else:
			# No need to log in.
			initialLoad = copy.deepcopy(urls["param"])
			if (urls["type"] == "GET"):
				start = time.time()
				initialRequest = requests.get(url, params=initialLoad, headers=header, verify=False)
			else:
				start = time.time()
				initialRequest = requests.post(url, data=initialLoad, headers=header, verify=False)
			initialRequest.content
			initialTrip = time.time() - start
			initialLength = int(initialRequest.headers["Content-Length"])
			initialStatus = initialRequest.status_code
			initialEndingUrl = initialRequest.url
			print "initial trip:" + str(initialTrip)
			print "initial length:" + str(initialLength)
			print "initial status:" + str(initialStatus)
			print initialEndingUrl
			for param in initialLoad:
			# check for each param change the payload
				for payload in payloads:
					# replace each parameter with the payload to test
					load = copy.deepcopy(initialLoad)
					load[param] =  load[param]+payload
					print urls["type"]
					if (urls["type"] == "GET"):
						start = time.time()
						r = requests.get(url, params=load, headers=header, verify=False)
					else:
						start = time.time()
						r = requests.post(url, data=load, headers=header, verify=False)
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
			
			#check for header parameter, change to payload
			#check if the header referer is used
			newHeader = copy.deepcopy(header)
			load = copy.deepcopy(initialLoad)
			newHeader["Referer"] = "http://google.com";
			if (urls["type"] == "GET"):
				initialRequest = requests.get(url, params=load, headers=header, verify=False)
			else:
				initialRequest = requests.post(url, data=load, headers=header, verify=False)
			r.content						
			length = int(r.headers["Content-Length"])
			status = r.status_code
			newEndingUrl = r.url
			print "after changing header length"+str(length)
			print "after changing header status"+str(status)
			print "after changing header ending url"+str(initialEndingUrl)
			#if the content different or url is different or status code is different, the referer is used
			parsedInitialEndingUrl=initialEndingUrl
			if("?" in initialEndingUrl):
				index = int(initialEndingUrl.find("?"))
				parsedInitialEndingUrl = initialEndingUrl[0:index]
			parsedNewEndingUrl = newEndingUrl
			if("?" in newEndingUrl):
				index = int(newEndingUrl.find("?"))
				print index
				parsedNewEndingUrl = newEndingUrl[0:index]
			#if the content different or url is different or status code is different, the referer is used
			if((length!=initialLength)|(status!=200)|(parsedNewEndingUrl != parsedInitialEndingUrl)):
				print "referer is used here"
				print newEndingUrl
				#referer is used, change the referer to different payload to test
				for payload in payloads:
				#replace each parameter with the payload to test
					load = copy.deepcopy(initialLoad)
					newHeader = copy.deepcopy(header)
					newHeader["Referer"] += payload
					if (urls["type"] == "GET"):
						start = time.time()
						r = requests.get(url, params=load, headers=newHeader, verify=False)
					else:
						start = time.time()
						r = requests.post(url, data=load, headers=newHeader, verify=False)
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
					if (((length >= initialLength) & (status == 200)) | ((trip - initialTrip) > 5)) & ("error" not in str(r.url)):
						initialUrl = copy.deepcopy(urls)
						initialUrl["header"] = newHeader
						jsonform.append(initialUrl)

with open("phase3_output.json",'w') as outfile:	
    json.dump(jsonform,outfile,indent=2)
			