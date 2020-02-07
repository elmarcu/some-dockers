import os
import mysql.connector
import time
time.sleep(5)#some time for mysql to load

mydb = mysql.connector.connect(
  host="mysql",
  user=os.environ['MYSQL_USER'],
  passwd=os.environ['MYSQL_PASSWORD'],
  database="example"
)

print(mydb)
mycursor = mydb.cursor()
mycursor.execute("SELECT * FROM Table_Example")
myresult = mycursor.fetchall()
for x in myresult:
  print(x)
