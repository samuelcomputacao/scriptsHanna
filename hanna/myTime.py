import time

class Time:

    def getTempoId(self):
        timeStruct = time.localtime(time.time())
        tempo = "%4i%02i%02i%02i%02i%02i" %(timeStruct.tm_year,timeStruct.tm_mon,timeStruct.tm_mday,timeStruct.tm_hour,timeStruct.tm_min,timeStruct.tm_sec)   
        return tempo