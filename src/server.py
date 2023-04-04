from flask import Flask, request
import crud
app = Flask(__name__)

@app.route("/contacts")
def get_contacts():
    
    return crud.get_contacts()


@app.route("/contact", methods=["POST"])
def add_contact():

    name = request.form.get('name', '')
    phone = request.form.get('phone', '')
    email = request.form.get('email', '')
    
    return crud.add_contact(name=name, phone=phone, email=email)

if __name__ == '__main__':
    app.debug = True
    app.run(host='0.0.0.0')