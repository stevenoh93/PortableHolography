import numpy
import cv2
import glob

# termination criteria
criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001)

# prepare object points, like (0,0,0), (1,0,0), (2,0,0) ....,(6,5,0)
objp = numpy.zeros((6*7,3), numpy.float32)
objp[:,:2] = numpy.mgrid[0:7,0:6].T.reshape(-1,2)

# Arrays to store object points and image points from all the images.
objpoints = [] # 3d point in real world space
imgpoints = [] # 2d points in image plane.

# images = glob.glob('all_images/view_calibration/*.png')
images = glob.glob('all_images\\*.jpg')
for fname in images:
	img = cv2.imread(fname)
	gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
	# cv2.imshow('image',gray)
	# cv2.waitKey(1500)

	# Find the chess board corners
	ret, corners = cv2.findChessboardCorners(gray, (9,6),None)
	# print ret, corners

	# If found, add object points, image points (after refining them)
	if ret == True:
		objpoints.append(objp)

		corners2 = cv2.cornerSubPix(gray,corners,(11,11),(-1,-1),criteria)
		imgpoints.append(corners2)
		print corners2
		# if corners2 != None:
		# Draw and display the corners
		print img.shape
		print corners.shape
		img = cv2.drawChessboardCorners(img, (9,6), corners,ret)
		cv2.imshow('img',img)
		cv2.waitKey(1000)

# cv2.destroyAllWindows()