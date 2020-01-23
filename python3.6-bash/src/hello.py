import requests
print(str(requests.get("http://www.google.com/?=hello world").text))
