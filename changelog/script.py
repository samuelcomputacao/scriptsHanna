inserts = open('insert.sql','r')

changeLogInsert = open('changeLogInsert.sql','w')
changeLogRollback = open('changeLogRollback.sql','w')

formatInsert = "INSERT INTO \"${synchro.schema}\".\"/SYN/OBRIGACOES_COD_MUN_BA\" VALUES(%s,%s);\n"
formatDelete = "DELETE FROM \"${synchro.schema}\".\"/SYN/OBRIGACOES_COD_MUN_BA\" WHERE COD_MUN IN (%s);\n"

cods = ''

for linha in inserts:
    values = linha.split('VALUES')[1].strip()
    values = values.replace('(','').replace(')','').replace(';','').split(',')
    codMun = values[0]
    codIBGE = values[1]
    cods+= codMun + ','

    linha = formatInsert % (codMun,codIBGE)
    changeLogInsert.write(linha)

changeLogRollback.write(formatDelete % (cods[:-1]))
changeLogRollback.close()
changeLogInsert.close()
