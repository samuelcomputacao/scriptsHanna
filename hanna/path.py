import os
from myTime import Time
class Path:

    file = None
    time = None
    DIRETORIO = 'changelog/'
   
    def __init__(self,filePath):
        self.time = Time()
        self.DIRETORIO += self.time.getTempoId()
        if not os.path.isdir(self.DIRETORIO):
            os.makedirs(self.DIRETORIO)
        self.file = filePath
        
    def getPath(self):
        return '%s/%s' % (self.DIRETORIO,self.file)

    def getFilePath(self):
        return self.file