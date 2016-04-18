import yaml
import json
import requests
import time
import copy
from pprint import pprint
jsonform = []
loginPayloadDict = {}
header = {
			"Referer": "https://app5.com/www/index.php",
			"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36"
		}
with open('s2.json') as file:
	payloads = yaml.safe_load(file);
with open('login.json') as file:
	data = json.load(file)
	for loginurls in data["loginurls"]:
		loginurl = loginurls["loginurl"]
		loginPayload = loginurls["loginpayload"]
		if(loginurl in loginPayloadDict):
			payloadList = loginPayloadDict[loginurl]
			payloadList.append(loginPayload)
		else:			
			loginPayloadDict[loginurl] = loginPayload

with open('phase1.json') as data_file:
	data = json.load(data_file)
	for urls in data["urls"]:	
		url = urls["url"]
		if url in loginPayloadDict:	
			#process login urls firstif url in loginPayloadDict:
			#it's a log in url
			#get all log in accounts and password
			crendentials = loginPayloadDict[url]
			newCredentials = []
			initialLoad = copy.deepcopy(urls["param"])
			#get first log in credential to test is enough
			#assign param to crendentials
			for param in crendentials:
				initialLoad[param] = [crendentials[param]]
			credential = copy.deepcopy(initialLoad)
			#print "Credential"
			#print credential
			newCredentials.append(credential)
			#print newCredentials
			loginPayloadDict[url] = newCredentials
for urls in data["urls"]:		
		url = urls["url"]
		if urls["loginrequired"] != "true":
			#print "Login is not required"
			# No need to log in.
			initialLoad = copy.deepcopy(urls["param"])
			isLoginURL = False
			if (urls["type"] == "GET"):
				start = time.time()
				initialRequest = requests.get(url, params=initialLoad, headers=header, verify=False)
			else:
				# check if it's a login url
				if url in loginPayloadDict:
					isLoginURL = True					
					initialLoad = loginPayloadDict[url][0]
				else:
					for param in initialLoad:
						if (not initialLoad[param]) | (initialLoad[param][0] is None) | (initialLoad[param][0] == ""):
							initialLoad[param] =  ["student"]
				# replace the params
				start = time.time()
				initialRequest = requests.post(url, data=initialLoad, headers=header, verify=False)
			#print initialLoad
			initialRequest.content
			initialTrip = time.time() - start
			initialLength = len(initialRequest.content)#int(initialRequest.headers["Content-Length"])
			initialStatus = initialRequest.status_code
			initialEndingUrl = initialRequest.url
			#print "initial trip:" + str(initialTrip)
			#print "initial length:" + str(initialLength)
			#print "initial status:" + str(initialStatus)
			#print initialEndingUrl
			isLoginParam = False
			for param in initialLoad:
			# check for each param change the payload
				if param in ["login","password","username"]:
					isLoginParam = True
				else:
					isLoginParam = False
				for payload in payloads:
					# replace each parameter with the payload to test
					load = copy.deepcopy(initialLoad)					
					print "-----------New Load-----------------------------"
					print load
					print param
					print load[param]
					print "----------------------------------------"
					if (not load[param]) | (load[param][0] is None):
						load[param] =  [payload]
					else:
						load[param][0] =  load[param][0]+payload
					#print urls["type"]
					if (urls["type"] == "GET"):
						start = time.time()
						r = requests.get(url, params=load, headers=header, verify=False)
					else:
						start = time.time()
						r = requests.post(url, data=load, headers=header, verify=False)
					r.content
					trip = time.time() - start
					length = len(r.content)#int(r.headers["Content-Length"])
					status = r.status_code
					newEndingUrl = r.url
					# only if the content lenght is larger, and the status code is 200
					# or the response time is much longger say 5 seconds for Time-based blind SQL injection
					# we consider it's a valid attack
					#print "new trip:" + str(trip)
					#print "new length:" + str(length)
					#print "new status:" + str(status)
					#print r.url
					#print load
					parsedInitialEndingUrl=initialEndingUrl
					if("?" in initialEndingUrl):
						index = int(initialEndingUrl.find("?"))
						parsedInitialEndingUrl = initialEndingUrl[0:index]
					parsedNewEndingUrl = newEndingUrl
					if("?" in newEndingUrl):
						index = int(newEndingUrl.find("?"))
						#print index
						parsedNewEndingUrl = newEndingUrl[0:index]
					if ((((length > initialLength)|((isLoginURL) & (length == initialLength) & (isLoginParam))) & (status == 200)) |  ((trip - initialTrip) > 5))& ("error" not in str(r.url)) & (parsedNewEndingUrl == parsedInitialEndingUrl):
						initialUrl = copy.deepcopy(urls)
						initialUrl["param"] = load
						jsonform.append(initialUrl)
								
						print "----------------------------------------"
						print length
						print initialLength
						print parsedNewEndingUrl
						print parsedInitialEndingUrl
						print "----------------------------------------"
			
			#check for header parameter, change to payload
			#check if the header referer is used
			newHeader = copy.deepcopy(header)
			load = copy.deepcopy(initialLoad)
			newHeader["Referer"] = "http://google.com";
			if (urls["type"] == "GET"):
				initialRequest = requests.get(url, params=load, headers=header, verify=False)
			else:
				# check if it's a login url
				if url in loginPayloadDict:
					#it's a log in url
					#get all log in accounts and password
					load = loginPayloadDict[url][0]
				# replace the params
				initialRequest = requests.post(url, data=load, headers=header, verify=False)
			r.content						
			length = len(r.content)#int(r.headers["Content-Length"])
			status = r.status_code
			newEndingUrl = r.url
			#print "after changing header length"+str(length)
			#print "after changing header status"+str(status)
			#print "after changing header ending url"+str(initialEndingUrl)
			#if the content different or url is different or status code is different, the referer is used
			parsedInitialEndingUrl=initialEndingUrl
			if("?" in initialEndingUrl):
				index = int(initialEndingUrl.find("?"))
				parsedInitialEndingUrl = initialEndingUrl[0:index]
			parsedNewEndingUrl = newEndingUrl
			if("?" in newEndingUrl):
				index = int(newEndingUrl.find("?"))
				#print index
				parsedNewEndingUrl = newEndingUrl[0:index]
			#if the content different or url is different or status code is different, the referer is used
			if((abs(length-initialLength)>100)|(status!=200)|(parsedNewEndingUrl != parsedInitialEndingUrl)):
				#print "referer is used here"
				#print newEndingUrl
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
						# check if it's a login url
						if url in loginPayloadDict:
							#it's a log in url
							#get all log in accounts and password
							load = loginPayloadDict[url][0]
						# replace the params
						initialRequest = requests.post(url, data=load, headers=header, verify=False)
					r.content
					trip = time.time() - start
					length = len(r.content)#int(r.headers["Content-Length"])
					status = r.status_code
					newEndingUrl = r.url
					# only if the content lenght is larger, and the status code is 200
					# or the response time is much longger say 5 seconds for Time-based blind SQL injection
					# we consider it's a valid attack
					#print "new trip:" + str(trip)
					#print "new length:" + str(length)
					#print "new status:" + str(status)
					#print r.url
					#print load
					if (((length >= initialLength) & (status == 200)) | ((trip - initialTrip) > 5)) & ("error" not in str(r.url)):
						initialUrl = copy.deepcopy(urls)
						initialUrl["header"] = newHeader
						jsonform.append(initialUrl)
						print "----------------------------------------"
						print length
						print initialLength
						print "----------------------------------------"

	for urls in data["urls"]:	
		url = urls["url"]
		if urls["loginrequired"] == "true":
			#print "Login is required"
			# Fill in your details here to be posted to the login form.
			# Get log in details from config file
			loginurl = urls["loginurl"]
			# Log in first
			# get log in url from config file
			if loginurl in loginPayloadDict:
				#it's a log in url
				crendentials = loginPayloadDict[loginurl]
				#get first log in credential to test is enough
				for credential in crendentials:
					loginpayload = credential					
					with requests.Session() as s:
						p = s.post(loginurl, data=loginpayload, verify=False)
						# #print the html returned or something more intelligent to see if it's a successful login page.
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
								# check if it's a login url
								if url not in loginPayloadDict:
									for param in initialLoad:
										if (not initialLoad[param]) | (initialLoad[param][0] is None) | (initialLoad[param][0] == ""):
											initialLoad[param] =  ["student"]
								initialRequest = s.post(url,data = initialLoad, headers=header, verify = False)
							initialRequest.content
							initialTrip = time.time() - start
							print "-------------------Initial Request---------------------"
							print initialRequest.headers
							print url
							print initialLoad
							print "----------------------------------------"
							
								
							initialLength = len(initialRequest.content)#int(initialRequest.headers["Content-Length"])
							initialStatus = initialRequest.status_code
							initialEndingUrl = initialRequest.url
							#print "initial trip:" + str(initialTrip)
							#print "initial length:"+ str(initialLength)
							#print "initial status:"+str(initialStatus)
							#print initialEndingUrl
							# check for each param change the payload
							for param in initialLoad:
								for payload in payloads:
									#replace each parameter with the payload to test
									load = copy.deepcopy(initialLoad)
									#print load[param]
									#print param
									#print type(load[param])
									print "---------------New Load-------------------------"
									print load
									print param
									print load[param]										
									print "----------------------------------------"
									if (not load[param]) | (load[param][0] is None):
										load[param] =  [payload]
									else:
										load[param][0] =  load[param][0]+payload
									if(urls["type"]=="GET"):
										start = time.time()
										r = s.get(url,params = load, headers=header, verify = False)
									else:
										start = time.time()
										r = s.post(url,data = load, headers=header, verify = False)
									r.content
									trip = time.time() - start
									length = len(r.content)#int(r.headers["Content-Length"])
									status = r.status_code
									newEndingUrl = r.url
									# only if the content lenght is larger, and the status code is 200
									# or the response time is much longger say 5 seconds for Time-based blind SQL injection
									# we consider it's a valid attack
									#print "new trip:" + str(trip)
									#print "new length:" + str(length)
									#print "new status:" + str(status)
									#print r.url
									#print load
									parsedInitialEndingUrl=initialEndingUrl
									if("?" in initialEndingUrl):
										index = int(initialEndingUrl.find("?"))
										parsedInitialEndingUrl = initialEndingUrl[0:index]
									parsedNewEndingUrl = newEndingUrl
									if("?" in newEndingUrl):
										index = int(newEndingUrl.find("?"))
										#print index
										parsedNewEndingUrl = newEndingUrl[0:index]
									if (((length > initialLength) & (status == 200)) | ((trip - initialTrip) > 5)) & ("error" not in str(r.url))& (parsedNewEndingUrl == parsedInitialEndingUrl):
										initialUrl = copy.deepcopy(urls)
										initialUrl["param"] = load
										initialUrl["loginpayload"] = loginpayload
										jsonform.append(initialUrl)								
										print "----------------------------------------"
										print length
										print initialLength
										print parsedNewEndingUrl
										print parsedInitialEndingUrl
										print "----------------------------------------"
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
							length = len(r.content)#int(r.headers["Content-Length"])
							status = r.status_code
							newEndingUrl = r.url
							#print "after changing header length"+str(length)
							#print "initial length"+str(initialLength)
							#print "after changing header status"+str(status)
							#print "after changing header ending url"+str(newEndingUrl)
							#print "initial ending url"+str(initialEndingUrl)
							#print (length!=initialLength)
							#print (status!=200)
							#print (newEndingUrl != initialEndingUrl)
							parsedInitialEndingUrl=initialEndingUrl
							if("?" in initialEndingUrl):
								index = int(initialEndingUrl.find("?"))
								#print index
								parsedInitialEndingUrl = initialEndingUrl[0:index]
							parsedNewEndingUrl = newEndingUrl
							if("?" in newEndingUrl):
								index = int(newEndingUrl.find("?"))
								#print index
								parsedNewEndingUrl = newEndingUrl[0:index]
							#if the content different or url is different or status code is different, the referer is used
							if((abs(length-initialLength)>100)|(status!=200)|(parsedNewEndingUrl != parsedInitialEndingUrl)):
								#print "referer is used here"
								#print newEndingUrl
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
									length = len(r.content)#int(r.headers["Content-Length"])
									status = r.status_code
									newEndingUrl = r.url
									# only if the content lenght is larger, and the status code is 200
									# or the response time is much longger say 5 seconds for Time-based blind SQL injection
									# we consider it's a valid attack
									#print "new trip:" + str(trip)
									#print "new length:" + str(length)
									#print "new status:" + str(status)
									#print r.url
									#print load
									parsedInitialEndingUrl=initialEndingUrl
									if("?" in initialEndingUrl):
										index = int(initialEndingUrl.find("?"))
										parsedInitialEndingUrl = initialEndingUrl[0:index]
									parsedNewEndingUrl = newEndingUrl
									if("?" in newEndingUrl):
										index = int(newEndingUrl.find("?"))
										#print index
										parsedNewEndingUrl = newEndingUrl[0:index]
									if (((length >= initialLength) & (status == 200)) | ((trip - initialTrip) > 5)) & ("error" not in str(r.url))& (parsedNewEndingUrl == parsedInitialEndingUrl):
										initialUrl = copy.deepcopy(urls)
										initialUrl["header"] = newHeader
										initialUrl["loginpayload"] = loginpayload
										jsonform.append(initialUrl)	
												
										print "----------------------------------------"
										print length
										print initialLength
										print parsedNewEndingUrl
										print parsedInitialEndingUrl
										print "----------------------------------------"											
										
with open("phase3_output.json",'w') as outfile:	
    json.dump(jsonform,outfile,indent=2)