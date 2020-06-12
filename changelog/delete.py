
tabela = open('resultadoConsultaDoc.csv','r')
#tabela = open('teste.csv','r')

deleteDocFormat = "DELETE FROM outorga.tb_documento WHERE id_documento = %i;\n"
deleteDocReqFormat = "DELETE FROM outorga.tb_documento_requerimento WHERE id_documento_requerimento = %i;\n"
backupFormat = "SELECT * FROM outorga.tb_documento_requerimento docReq JOIN outorga.tb_documento doc ON(docReq.id_documento = doc.id_documento) WHERE docReq.id_documento_requerimento in (%s);"

arquivoDelete = open('delete.sql','w')

def validaLinha(linha):
    if(len(linha[0]) > 0):
        return True
    return False

def gerarDeleteDocReq(linha):
    idDocReq = int(linha[2])
    delete = deleteDocReqFormat % idDocReq
    return delete

def gerarDeleteDoc(linha):
    idDoc = int(linha[3])
    delete = deleteDocFormat % idDoc
    return delete

backup = "";
for l in tabela:
    linha = l.split(",")
    if(validaLinha(linha)):
        deleteReq = gerarDeleteDocReq(linha)
        deleteDoc = gerarDeleteDoc(linha)
        if(len(backup) > 0):
            backup += ","
        backup += str(int(linha[2]));
        arquivoDelete.write(deleteReq)
        arquivoDelete.write(deleteDoc)

backup = backupFormat % backup
print(backup)
arquivoDelete.close()
tabela.close()

   