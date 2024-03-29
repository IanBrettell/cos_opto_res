#!/usr/bin/env python3

# Import libraries
import argparse
import numpy as np
import cv2 as cv
import os
import sys

# Get key variables

parser = argparse.ArgumentParser(description = 'Split video by quadrant.')
parser.add_argument("--in_file", help="Input file")
parser.add_argument("--start", help="Start frame")
parser.add_argument("--end", help="End frame")
parser.add_argument("--quadrant", help="Target quadrant")
parser.add_argument("--out_file", help="Output file")

args = parser.parse_args()

in_file = args.in_file
start = int(args.start)
end = int(args.end)
quadrant = args.quadrant
out_file = args.out_file

# Read video from file
cap = cv.VideoCapture(in_file)

# Frame width and height
wid = int(cap.get(cv.CAP_PROP_FRAME_WIDTH))
hei = int(cap.get(cv.CAP_PROP_FRAME_HEIGHT))
# Get total frame length
vid_len = int(cap.get(cv.CAP_PROP_FRAME_COUNT))
# Get frames per second
fps = int(cap.get(cv.CAP_PROP_FPS))
# Adapt basename prefix
in_file_pref = os.path.split(in_file)[1].split('.')[0]
# Get file name without extension
meta_list = os.path.split(in_file)[1].split('.')[0].split('_')

# Get metadata
date = meta_list[0]
time = meta_list[1]
test_line = meta_list[3]
tank_side = meta_list[4]

# Get bounding box coords for target quadrant
if quadrant == 'q1':
    top = 0
    bottom = round(((hei - 1) / 2) + 10)
    left = round((wid - 1) / 2)
    right = wid - 1
elif quadrant == 'q2':
    top = 0
    bottom = round(((hei - 1) / 2) + 10)
    left = 0
    right = round(((wid - 1) / 2) + 10)
elif quadrant == 'q3':
    top = round(((hei - 1) / 2) + 5)
    bottom = hei - 1
    left = 0
    right = round(((wid - 1) / 2) + 10)
elif quadrant == 'q4':
    top = round(((hei - 1) / 2) + 5)
    bottom = hei - 1
    left = round(((wid - 1) / 2) + 5)
    right = wid  - 1
else:
    print('Invalid quadrant')

# Get size of output video
size = (right - left, bottom - top)

# Define the codec and create VideoWriter object
# Works on local Mac:
fourcc = cv.VideoWriter_fourcc('m', 'p', '4', 'v')
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
    if tank_side == 'R':
        frame = cv.rotate(frame, cv.ROTATE_180)
    # Crop frame
    frame = frame[top:bottom, left:right]
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
