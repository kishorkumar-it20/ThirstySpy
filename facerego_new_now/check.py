import arduino as rp
data = rp.get()
# dataenc = data.encode('utf-8')
# print(str(data))
finale = ""
for i in data:
    if(i != "b''"):
        finale = i
print(finale)
