from t9functions import readTextFile
from t9functions import getNandRMatrix
from t9functions import getQMatrix
from t9functions import maxProductAlgo
import numpy

filename = 'woodturning.txt'
#read text file and return clean text
text = readTextFile(filename)
#get N and R matrix from text read
N, R = getNandRMatrix(text)
P = N
#get Q matrix
Q = getQMatrix()
print("Sum of the rows of P = ")
print(numpy.sum(N, axis=0))

print("Sum of the rows of Q = ")
print(numpy.sum(Q, axis=0))

print("Sum of the rows of R = ")
print(numpy.sum(R, axis=0))

print("Sum over the columns of P = ")
print(numpy.sum(P, axis=1))

print("Sum over the columns of Q = ")
print(numpy.sum(Q, axis=1))

print("Sum over the columns of R = ")
print(numpy.sum(R, axis=1))

 
new_v = '6224463' #text keyed in
#compute most likely h
maxProductAlgo(new_v,P, Q , R)
new_v = '53276464' #text keyed in
maxProductAlgo(new_v,P, Q , R)
#6224463
#53276464

