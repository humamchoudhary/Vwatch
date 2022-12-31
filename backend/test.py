# from randimage import get_random_image, show_array
# import matplotlib

# img_size = (64,64)
# for i in range(12):
#     img = get_random_image(img_size)  #returns numpy array
#     # show_array(img) #shows the image
#     matplotlib.image.imsave(f"randimage{i}.png", img)
x = []
for i in range(12):
    x.append(f"randimage{i}.png")
print(x)