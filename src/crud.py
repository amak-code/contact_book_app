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
    