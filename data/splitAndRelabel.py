import os
import io
import shutil

import os, errno

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc: # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: raise



def copyAccordingly(srcFolder,targetFolder,listFile,mapping):

    if not os.path.isfile(listFile):
        print "ERROR: File " + listFile + " does not exist"
        return -1


    with open(listFile) as f:
        for line in f:
            ascii_class = line.replace("/" + os.path.basename(line), "")

            #newName = line.replace(line.split('/')[0],mapping)
            #print line.strip() + " ->" + asciiClass + "->" + str(mapping[asciiClass])
            newName = targetFolder + "/" + line.strip().replace(ascii_class, str(mapping[ascii_class]),1)

            print line.strip() + "->" + newName
            mkdir_p(os.path.dirname(newName))
            shutil.copyfile(srcFolder + "/" + line.strip(), newName)



    return 0


__author__ = 'tbergmueller'

foldername = 'raw'
targetFolder='db'
mappingFile = targetFolder + "/mapping.txt"
mappingSepchar=','
nrClassesInDb = 67

fnameListTest="TestImages.txt"
fnameListTrain="TrainImages.txt"

# create mapping

mapping = {}

classNr = 0
for dirname, dirnames, filenames in os.walk(foldername):
    if dirname == foldername:
        continue
    mapping[dirname.replace(foldername + "/","")] = classNr
    classNr += 1


if len(mapping) != nrClassesInDb:
    print "ERROR: Then number of classes is expected to be " + str(nrClassesInDb) + " but we have " + str(len(mapping)) + " found... something's wrong"
    exit(-1)




shutil.rmtree(targetFolder, 1)

mkdir_p(os.path.dirname(mappingFile))
fh = open(mappingFile, 'w')
for m in mapping:
    fh.write(m + mappingSepchar + str(mapping[m]) + "\n")
fh.close()





if copyAccordingly(foldername, targetFolder + "/test", fnameListTest, mapping) != 0:
    exit(-1)
if copyAccordingly(foldername, targetFolder + "/train", fnameListTrain, mapping) != 0:
    exit(-1)





# ok, now go for the train data


print "Successful, thanks!"

exit(0)