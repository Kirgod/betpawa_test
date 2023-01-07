from flask import Flask, render_template, request
import mysql.connector, os

app = Flask(__name__)

if __name__ == "__main__":
  app.run(debug=True)

mydb = mysql.connector.connect(
  database = os.environ.get('MYSQL_DATABASE'),
  password = os.environ.get('MYSQL_PASSWORD'), 
  user     = os.environ.get('MYSQL_USER'),
  host     = os.environ.get('MYSQL_HOST')
)

@app.route('/')
def index():
  return render_template('index.html')

@app.route('/', methods=['GET', 'POST'])
def addValueToDB():
  text=request.form.get('text')
  mycursor = mydb.cursor()
  insert_operation = "INSERT INTO " + os.environ.get('MYSQL_DATABASE') + " (RandomText) VALUES ('" + text + "');"
  mycursor.execute(insert_operation)
  mydb.commit()
  return render_template('index.html')

@app.route('/result', methods=['GET', 'POST'])
def result():
  mycursor = mydb.cursor()
  select_operation = "SELECT * FROM " + os.environ.get('MYSQL_DATABASE')
  mycursor.execute(select_operation)
  result = mycursor.fetchall()
  return render_template('result.html', result = result)