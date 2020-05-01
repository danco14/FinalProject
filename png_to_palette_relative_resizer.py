# https://github.com/Atrifex/ECE385-HelperTools

from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
filename = input("What's the image name? ")
new_w, new_h = map(int, input("What's the new height x width? Like 28 28. ").split(' '))
palette_hex = ['0xFB00FF', '0x000000', '0xFFFFFF', '0xD63100', '0xFF2910',
                '0xFF5A00', '0xC58C21', '0xC5A519', '0xEFD629', '0x42CE5A',
                '0x314A7B', '0x3A5AD6', '0x425AFF', '0x5A528C', '0x5A2973',
                '0x4A0084', '0xCE52CE', '0xFF7BFF', '0xEF3A73',
                '0x6C1301','0x7B1702','0xA32103','0xD72F06',
                '0xDC3106','0xEA3407','0xF83808','0xF79750',
                '0xF89850','0x38B818','0x5048F8',
                '0xE9E9F0','0x797979','0xD9D9D9','0xA1A1AA',
                '0xC9C9D1','0xA14F3E','0xC17146','0xF84600',
                '0xE1A160','0xE1B246','0xF8D181',
                '0xB9B971','0xF8F081','0xF8F8B2','0x99C1C9',
                '0xA9D1D9','0x6091C1','0x89C1E1','0x81AAD9',
                '0x4F4F68','0x9981C9','0xB199D9']
palette_rgb = [hex_to_rgb(color) for color in palette_hex]

pixel_tree = KDTree(palette_rgb)
im = Image.open("./sprite_originals/" + filename+ ".png") #Can be many different formats.
im = im.convert("RGBA")
im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize
pix = im.load()
pix_freqs = Counter([pix[x, y] for x in range(im.size[0]) for y in range(im.size[1])])
pix_freqs_sorted = sorted(pix_freqs.items(), key=lambda x: x[1])
pix_freqs_sorted.reverse()
print(pix)
outImg = Image.new('RGB', im.size, color='white')
outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
i = 0
for y in range(im.size[1]):
    for x in range(im.size[0]):
        pixel = im.getpixel((x,y))
        print(pixel)
        if(pixel[3] < 200):
            outImg.putpixel((x,y), palette_rgb[0])
            outFile.write("%x\n" % (0))
            print(i)
        else:
            index = pixel_tree.query(pixel[:3])[1]
            outImg.putpixel((x,y), palette_rgb[index])
            outFile.write("%x\n" % (index))
        i += 1
outFile.close()
outImg.save("./sprite_converted/" + filename + ".png")
