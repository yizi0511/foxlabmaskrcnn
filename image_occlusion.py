
from matplotlib import pyplot as plt
import numpy as np
import PIL
from PIL import Image 
import os
from glob import glob


def Vmask(im, y):
    vmask = im.copy()
    vmask[:, np.sin(y) < -.9, 0:3] = 0
    return vmask

def Cmask(im, x, y):
    vmask = im.copy()
    vmask[:,np.sin(y) < -.9, 0:3] = 0
    
    cmask = vmask.copy()
    cmask[np.sin(x)< -.9, :, 0:3] = 0
    return cmask

def Dmask(im, x, y):
    dmask = im.copy()
    for i in x:
        for j in y:
            if np.sin((i+j)/8) < -.9:
                dmask[i,j, 0:3] = 0
            if np.sin((i-j)/8) < -.9:
                dmask[i,j, 0:3] = 0
    
    return dmask

def main():
    try:
        path = '/Users/yizizhang/Desktop/foxlabmaskrcnn/train/*.png'   
        files = glob(path)
        
        for file in files:
            img = plt.imread(file)

            x = list(range(0, img.shape[0]))
            for i in x:
                x[i] = x[i] / 5

            y = list(range(0, img.shape[1]))
            for i in y:
                y[i] = y[i] / 5
            
            vmask = Vmask(img, y)
            cmask = Cmask(img, x, y)
        
            x = list(range(0, img.shape[0]))
            y = list(range(0, img.shape[1]))
            dmask = Dmask(img, x, y)
        
            base = os.path.basename(file) 
        
            plt.imsave("/Users/yizizhang/Desktop/foxlabmaskrcnn/occluded/" + "vert_bars_" + base, vmask)
            plt.imsave("/Users/yizizhang/Desktop/foxlabmaskrcnn/occluded/" + "cross_bars_" + base, cmask)
            plt.imsave("/Users/yizizhang/Desktop/foxlabmaskrcnn/occluded/" + "diag_bars_" + base, dmask) 
        
    except IOError:
        pass 

main()

