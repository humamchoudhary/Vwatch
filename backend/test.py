class test():
    def __del__(self):
        print("delete")
    
test= test()
del test
print(test)