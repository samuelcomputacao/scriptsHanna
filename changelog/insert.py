
arquivo = open('COD_MUN.csv','r')

insertFormat = "INSERT INTO \"SYN4TDF_EVOLUCAO\".\"/SYN/DIF_COD_CFOP_TO\" VALUES('%s','%s');\n"

arquivoInsert = open('insert.sql','w')

for l in arquivo:
    linha = l.split(' ')
    cod = linha[0].strip()

    cfops = linha[1].split(',')
    print(cfops)
    for cfop in cfops:
        cfop = cfop.strip()
      
        if(len(cfop) > 0):
            linha = insertFormat % (cod,cfop)
            arquivoInsert.write(linha)

arquivoInsert.close()
arquivo.close()

   