import sys
from hdbcli import dbapi
class Hanna:

    conn = None

    address = None
    port = None
    user = None
    password = None 

    FILE_PROCEDURE = '.procedure.sql'
    FILE_TABLE = '.table.sql'
    
    def __init__(self,address,port,user,password):
        self.address = address
        self.port = port
        self.user = user
        self.password = password
   
    def conectar(self):
        self.conn = dbapi.connect(address=self.address, port=self.port, user=self.user, password=self.password)
        return self.conn.isconnected()

    def getValor(self, tipo, valor):
        retorno = ''
        if 'current_' in str(valor).lower() or '()' in str(valor).lower():
            retorno = str(valor)
        elif tipo in ['INTEGER','NUMBER','DECIMAL','DOUBLE','FLOAT']:
            retorno = str(valor)
        elif tipo in ['NVARCHAR','VARCHAR','DATE','BIGINT']:
            retorno = "'%s'" % str(valor)
        else:
            raise Exception('Existe uma coluna na entidade que ainda não é compatível com o script!!')
        return retorno

    def getProcedureSQL(self,schema,nomeProcedure):
        retorno = False
        if(self.conn.isconnected()):
            sql = "SELECT \"DEFINITION\" FROM \"SYS\".\"PROCEDURES\" WHERE SCHEMA_NAME = '%s' AND PROCEDURE_NAME = '/SYN/%s'" % (schema,nomeProcedure)
            cursor = self.conn.cursor()
            cursor.execute(sql)
            ddl, = cursor.fetchone()
            cursor.close()
            arquivo = open(self.FILE_PROCEDURE,'w')
            arquivo.write(ddl)
            arquivo.close()
            retorno = True
        else:
            print("Erro de conexao")
        return self.FILE_PROCEDURE

    def criaColuna(self, row):
        saida = ''
        nome,tipo,tamanho,scala,nulavel,default,maxValue, minValue = row
        saida += '"%s" %s' % (nome,tipo)
        if tamanho != None :
            saida += '(%d' % tamanho
            if scala != None:
                saida += ',%d)' % scala
            else:
                saida += ')'
        if nulavel == 'FALSE':
            saida += ' NOT NULL'
        if default != None:
            saida += ' DEFAULT %s' % self.getValor(tipo,default)
        return saida
        
    def createTableSQL(self,colunas,schema,nameTable):
        arquivo = open(self.FILE_TABLE, 'w')
        arquivo.write('CREATE COLUMN TABLE  "%s"."/SYN/%s"(\n'%(schema,nameTable))
        for i in range(len(colunas) - 1):
            arquivo.write('\t%s,\n' % colunas[i])
        arquivo.write('\t%s' % colunas[len(colunas) - 1])
        arquivo.write(') UNLOAD PRIORITY 5 AUTO MERGE')
        arquivo.close()
 
    def getTableSQL(self, schema, nameTable):
        colunas = []
        if(self.conn.isconnected()):
            sql = "SELECT COLUMN_NAME, DATA_TYPE_NAME, LENGTH, SCALE, IS_NULLABLE, DEFAULT_VALUE, MAX_VALUE, MIN_VALUE FROM \"SYS\".\"TABLE_COLUMNS\" WHERE SCHEMA_NAME = '%s' AND TABLE_NAME = '/SYN/%s' ORDER BY POSITION" % (schema, nameTable)
            cursor = self.conn.cursor()
            cursor.execute(sql)
            for row in cursor:
                colunas.append(self.criaColuna(row))
            cursor.close()
        self.createTableSQL(colunas,schema,nameTable)
        return self.FILE_TABLE
    
    def getDadosTableCSV(self, schema, nameTable):
        colunas = []
        dados = []
        tipos = []
        if(self.conn.isconnected()):
            sql = "SELECT COLUMN_NAME, DATA_TYPE_NAME FROM \"SYS\".\"TABLE_COLUMNS\" WHERE SCHEMA_NAME = '%s' AND TABLE_NAME = '/SYN/%s' ORDER BY POSITION" % (schema, nameTable)
            cursor = self.conn.cursor()
            cursor.execute(sql)
            for row in cursor:
                colunas.append('"%s"' % row[0])
                tipos.append(row[1])
            cursor.close()
            colunmsStr = ','.join(['%s' % c for c in colunas])
            sql = "SELECT %s FROM \"%s\".\"/SYN/%s\"" % (colunmsStr,schema,nameTable)
            cursor.execute(sql)
            for row in cursor:
                dado = []
                for i in range(len(row)):
                    d = self.getValor(tipos[i],row[i])
                    dado.append(d)
                dados.append(dado)
            cursor.close()
        return (colunas,dados)


