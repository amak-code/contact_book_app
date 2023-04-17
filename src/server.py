from flask import Flask, request
import crud
app = Flask(__name__)

@app.route("/contacts")
def get_contacts():
    
    return crud.get_contacts()


@app.route("/contact", methods=["POST"])
def add_contact():

   data = request.json
   name = data.get('name', '')
   phone = data.get('phone', 'no phone data')
   email = data.get('email', '')
   
   return crud.add_contact(name, phone, email)


@app.route("/contacts/<id>", methods = ["POST"])
def edit_contact(id):
    
    return crud.edit_contact(int(id))

@app.route("/contacts/<id>", methods = ["DELETE"])
def delete_contact(id):
    
    crud.delete_contact(int(id))
    return ('', 204)

if __name__ == '__main__':
    crud.add_contact(name="Alex", phone="415-333-4567", email="a@gmail.com")
    crud.add_contact(name="JoaHn", phone="415-333-7777", email="j@gmail.com")
    crud.get_contacts()
    app.debug = True
    app.run(host='0.0.0.0')