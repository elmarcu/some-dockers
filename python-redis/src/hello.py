import redis
r = redis.StrictRedis(host='redis', port=6379, db=0)

#one insert
text = ['Hello',' ','world','!!']
r.lpush("text", *text)

print(r.lrange("text", 0, 5))
