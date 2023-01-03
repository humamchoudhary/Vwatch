# from randimage import get_random_image, show_array
# import matplotlib

# img_size = (64,64)
# for i in range(12):
#     img = get_random_image(img_size)  #returns numpy array
#     # show_array(img) #shows the image
#     matplotlib.image.imsave(f"randimage{i}.png", img)
# x = []
# for i in range(12):
#     x.append(f"randimage{i}.png")
# # print(x)
# import m3u8_To_MP4

# if __name__ == '__main__':
#     # 1. Download mp4 from uri.
#     m3u8_To_MP4.multithread_download("https://wwwx15.gofcdn.com/videos/hls/b-5p-oMHFJnUflYYj5AGJQ/1672690031/25054/027e9529af2b06fe7b4f47e507a787eb/ep.1.1657688710.480.m3u8")

import os

# Path to the folder
folder_path = 'D:\Anime\initial d 4\Initial D Complete\Initial D Stages 1-6\Initial D - Fourth Stage'

# List all the files in the folder
files = os.listdir(folder_path)

# Print the file names
for file in files:
    print(file)