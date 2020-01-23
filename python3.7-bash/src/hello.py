import requests
print(requests.get("http://www.google.com/?=hello world").text)
