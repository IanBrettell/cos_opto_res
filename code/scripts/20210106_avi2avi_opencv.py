#!/usr/bin/env python3

import numpy as np
import cv2 as cv
import os
import sys

# Import file

in_file='/Users/brettell/Documents/Data/20210104_cos_videos/recorded_with_iphone.avi'
out_file='/Users/brettell/Documents/Data/20210104_cos_videos/recorded_with_iphone.mp4'

# Read video from file

cap = cv.VideoCapture(in_file)

# Get size, length and fps of video

wid = int(cap.get(cv.CAP_PROP_FRAME_WIDTH))
hei = int(cap.get(cv.CAP_PROP_FRAME_HEIGHT))
size = (hei, wid)

fps = int(cap.get(cv.CAP_PROP_FPS))

start = 0
end = int(cap.get(cv.CAP_PROP_FRAME_COUNT))

# Define the codec and create VideoWriter object
# Works on local Mac:
fourcc = cv.VideoWriter_fourcc('h', '2', '6', '4')
out = cv.VideoWriter(out_file, fourcc, fps, size, isColor=True)

# Capture frame-by-frame
i = start
while i in range(start,end):
    cap.set(cv.CAP_PROP_POS_FRAMES, i)
    # Capture frame-by-frame
    ret, frame = cap.read()
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    # Flip if tank side is "R"
#    if tank_side == 'R':
#        frame = cv.rotate(frame, cv.ROTATE_180)
    # Crop frame
#    frame = frame[top:bottom, left:right]
    # Write frame
    out.write(frame)
    # Show image
#    cv.imshow('frame', frame)
    # Add to counter
    i += 1
    # Press 'esc' to close video
#    if cv.waitKey(1) == 27:
#        cv.destroyAllWindows()
#        cv.waitKey(1)
#        break

cap.release()
out.release()
out = None
#cv.destroyAllWindows()
#cv.waitKey(1)
