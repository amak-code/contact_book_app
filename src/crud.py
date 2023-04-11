DATA = {}
id = 0

# id
# name
# phone
# email

def get_contacts():
    return list(DATA.values())
    
    
    
def add_contact(name, phone, email):
    global id
    id = id + 1
    contact = {
        'id': id,
        'name':name,
        'phone':phone,
        'email':email, 
    }
    DATA[id] = contact
    
    return contact


    
def edit_contact(id, name=None, phone=None, email=None):
    if id in DATA:
        contact = DATA[id]
        if name:
            contact['name'] = name
        if phone:
            contact['phone'] = phone
        if email:
            contact['email'] = email
        DATA[id] = contact
        return contact
    else:
        return None
    
def delete_contact(id):
    
    if id in DATA:
        del DATA[id]
    
    print("DATA after removing contact")   
    print(DATA)