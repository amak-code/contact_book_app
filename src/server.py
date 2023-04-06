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
    crud.add_contact(name="Alex", phone="415-333-4567", email="a@gmail.com")
    crud.add_contact(name="JoaHn", phone="415-333-7777", email="j@gmail.com")
    app.debug = True
    app.run(host='0.0.0.0')