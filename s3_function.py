import requests
from difflib import Differ
def self_checkIfCanLogin(payload, loginurl, header):
	request = requests.post(loginurl, data=payload, headers=header, verify=False)
	content = request.content.lower().replace(" ", "")
	if ("logout" in content) and (request.status_code == 200):
		for param in payload:
			if ("name='"+param+"'" in content) or ('name="'+param+'"' in content):
				return False
		return True
	else:
		return False

def self_checkStillLoggedIn(loginpayload, content):
	content = content.lower().replace(" ", "")
	if ("logout" in content):
		for param in loginpayload:
			if ("name='"+str(param)+"'" in content) or ('name="'+str(param)+'"' in content):
				return False
		return True
	else:
		return False
	
def self_post(load, url, header):
	request = requests.post(url, data=load, headers=header, verify=False)
	return request
	
def self_get(load, url, header):
	request = requests.get(url, params=load, headers=header, verify=False)
	return request
	
def self_gotsqlsyntaxerror(content):
	if ("You have an error in your SQL syntax" in content) | ("Invalid id" in content):	
		return True
	return False
