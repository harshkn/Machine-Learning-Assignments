#Returns clean text, i.e punctuation, \n,\t replaced by single space

def readTextFile(file):
        import string
        import codecs
        import re

        fl = codecs.open( file, "r", "utf-8" )
        txt = fl.read() # Returns a Unicode string from the UTF-8 bytes in the file
    
        fl.close()

        cText = txt.lower() #convert to lower case
        cText = cText.strip('\n')
        cText = re.sub('[^A-Za-z]+', ' ', cText)
        cText = re.sub('\s{2,}', ' ', cText)
 #       cText = cText.compile(r'\W*\b\w{1,3}\b')
        return cText

#######################################################################


#get N matrix H x H = 26x26 Transition matrix
#get R matrix = H x 1 = 26 x 1 Initial Matrix
#Choosing how each word starts i.e transition from space to character

def getNandRMatrix(text):
        import numpy
        N = numpy.zeros((26, 26))
        R = numpy.zeros((26,1))
        sp = 0;
        for i, c in enumerate(text[:-1]) :
                cval = ord(c)
                cvalp = ord(text[i + 1])
                if (cval >=97) & (cval <= 122) & (cvalp >=97) & (cvalp <= 122) :
                        m = cval - 97;
                        n = cvalp - 97;
                        N[m,n] = N[m,n] + 1
                elif (cval ==32) & (cvalp >=97) & (cvalp <= 122):
                        n = cvalp - 97;
                        R[n] = R[n] + 1
                        sp = sp + 1
                elif (cvalp == 32) :
                        sp = sp
                else:
                        print(c)
                        print("error")
        #Normalise N
        denN = numpy.sum(N, axis = 1)
        NormN = N / denN[:,None]

        NormR = R/(numpy.sum(R))
##        print(numpy.sum(NormN, axis = 1))
##        print(denN)
##        print(N[25,:]/sum(N[25,:]))
        return NormN, NormR

#######################################################################

#get Q matrix = V x H = 8 x 26 Emmission Matrix
#Choosing equal probability for each character given a key is pressed
def getQMatrix():
        import numpy
        Q = numpy.zeros((8,26))
        #2, 3 ,4 ,5 ,6, 7,  8, 9    <- V
        #ABCDEFGHIJKLMNOPQRSTUVWXYZ <- H
        #012345678901234567890123456
        
        Q[0,0:3] = 1   #2, ABC
        Q[1,3:6] = 1   #3, DEF
        Q[2,6:9] = 1   #4, GHI
        Q[3,9:12] = 1  #5, JKL
        Q[4,12:15] = 1 #6, MNO
        Q[5,15:19] = 1 #7, PQRS
        Q[6,19:22] = 1 #8, TUV
        Q[7,22:26] = 1 #9, WXYZ
        #space is not considered.
        denQ = numpy.sum(Q, axis = 1)
        NormQ = Q / denQ[:,None]
        return NormQ

######################################################################

#get all the states(hidden)
def printHStates(hstate):
        import numpy
        import sys
        h_states = numpy.chararray((1,26))
        h_states = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm','n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        sys.stdout.write("Most likely h - ")
        for c in hstate[:-1]:
                sys.stdout.write(h_states[c])
        sys.stdout.write("\n")
        return h_states

######################################################################

def maxProductAlgo(newv, P, Q, R):
        import numpy
        print("Given sequence - " + newv)
        if (newv[0] >= '2') & (newv[0] <= '9'):
                inval = ord(newv[0]) - 50
 #       R.fill(0.33)
        sTable = numpy.zeros((26, len(newv)+1))
        Qrow = Q[[inval], :].T
        sTable[:,[0]] = numpy.multiply(R, Qrow)
        
        for i, eachv in enumerate(newv[1:]) :  #for each button pressed
                if (eachv >= '2') & (eachv <= '9'):
                        vval = ord(eachv) - 50
                
                for new_state in range(0,25):
                        for state in range(0,25):
                                score = sTable[state,i] * Q[vval,new_state] * P[state, new_state]
                                if (score > sTable[new_state,i+1]):
                                        sTable[new_state,i+1] = score
        print(sTable)
        bestH= numpy.argmax(sTable,axis=0)
        #print(sTable)
        printHStates(bestH)
        #print(P)
        #print(P[0,2])
                                
                                
                        
                
        
        
        






