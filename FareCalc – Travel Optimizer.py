rates = {'Economy': 10, 'Premium': 18, 'SUV': 25}

def calculate_fare(km, t, h):
    if t not in rates:
        return None
    
    base = km * rates[t]
    
    if 17 <= h <= 20:
        base *= 1.5
    
    return base

while True:
    name = input("\nEnter Customer Name (or Exit): ")
    if name.lower() == "exit":
        break
    
    try:
        km = float(input("Enter Distance (km): "))
        t = input("Enter Vehicle Type (Economy/Premium/SUV): ")
        h = int(input("Enter Hour (0-23): "))
        
        fare = calculate_fare(km, t, h)
        
        if fare is None:
            print("Service Not Available")
            continue
        
        print("\n===== CITYCAB PRICE RECEIPT =====")
        print("Customer Name :", name)
        print("Distance      :", km, "km")
        print("Vehicle Type  :", t)
        print("Hour          :", h)
        print("Final Fare    : ₹", round(fare, 2))
        
    except:
        print("Invalid Input! Please enter correct values.")