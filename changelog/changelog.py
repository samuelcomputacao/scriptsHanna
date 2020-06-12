import sys
import os
import time

args = sys.argv[1:]

class Parametros:
    
    tipo = None
    dados = None
    nome = None
    ok = None

    TIPO_TABELA = '-t'
    TIPO_PROCEDURE = '-p'
    TIPO_INSERT = '-i'
    TIPO_HELP = '--help'

    def __init__(self,args):
        try:
            tipo = args[0]
            if(tipo == self.TIPO_TABELA or tipo == self.TIPO_PROCEDURE or tipo == self.TIPO_INSERT or tipo == self.TIPO_HELP):
                self.tipo = tipo
                if(self.tipo == self.TIPO_HELP):
                    self.printHelp()
                    self.ok = False
                    return
                
                for i in range(1,len(args),2):
                    arg = args[i]
                    valor = args[i+1]
                    if(arg == '-d'):
                        self.dados = valor
                    elif(arg == '-n'):
                        self.nome = valor
                if(self.nome != None and self.dados != None):
                    self.ok = True
                else:
                    self.printErro('Parâmetros incompletos')
            else:
                self.printErro('O tipo: %s não válido!' % tipo)      
        except Exception:
            self.printErro('Parâmetros incorretos')
           
    def printErro(self,msg):
        print('[ERRO] - %s' % msg)
        print('\n\n')
        self.printHelp()
            
    def printHelp(self):
        print('Uso:\n')
        print('-i         Utilizado para gerar changelog de inserts e requer os parâmetros:')
        print('')
        print('           -d {path dos dados de onde será gerado os inserts(tabela extraida do banco em csv ou xls que possua separador = ;)}')
        print('           -n {nome da tabela onde será inserido o arquivo}')
        print('           Exemplo: python3 changelog.py -i -n "OBRIGACOES_COD_MUN_BA" -d "/home/samuel/Documents/municipio.csv"')
        print('\n\n')
        print('-p         Utilizado para gerar changelog de procedures e requer os parâmetros:')
        print('')
        print('           -d {path dos dados de onde será gerado os arquivos(ddl extraido do banco)}')
        print('           -n {nome da procedure que será gerado os dados}')
        print('           Exemplo: python3 changelog.py -p -d "/home/samuel/Documents/procedure.sql" -n "P_GERA_DMD_BA"')
        print('\n\n')
        print('-t         Utilizado para gerar changelog de tabelas e requer os parâmetros:')
        print('')
        print('           -d {path dos dados de onde será gerado o arquivo(ddl extraido do banco)}')
        print('           -n {nome da tabela que será gerado os dados}')
        print('           Exemplo: python3 changelog.py -t -d "/home/samuel/Documents/create.sql" -n "DIF_TO_SEGMENTO_K"')
        print('\n\n')
    def getOk(self):
        return self.ok
    def getTipo(self):
        return self.tipo
    def getDados(self):
        return self.dados
    def getNome(self):
        return self.nome 

class Path:

    file = None
    DIRETORIO = 'changelog'

    def __init__(self,filePath):
        if not os.path.isdir(self.DIRETORIO):
            os.makedirs(self.DIRETORIO)
        self.file = filePath
        
    def getPath(self):
        return '%s/%s' % (self.DIRETORIO,self.file)

    def getFilePath(self):
        return self.file

def getTempoId():
    timeStruct = time.localtime(time.time())
    tempo = "%4i%02i%02i%02i%02i%02i" %(timeStruct.tm_year,timeStruct.tm_mon,timeStruct.tm_mday,timeStruct.tm_hour,timeStruct.tm_min,timeStruct.tm_sec)   
    return tempo


def carregarPlanilha(path):
    try:
        arquivo = open(path,'r')
        flag = True
        
        colunas = []
        dados = []
        for linha in arquivo:
            linha = linha.split(';')[1:]
            if(flag):
                for coluna in linha:
                    colunas.append('"%s"' % coluna.strip())
                flag = False
            else:
                dado = []
                for coluna in linha:
                    dado.append("'%s'" % coluna.strip())
                dados.append(dado)
        arquivo.close()
        return (colunas,dados)
    except FileNotFoundError:
        printErro('Arquivo: %s não foi encontrado.' % path)
        return None
    except Exception:
        print('Ocorreu um erro durante o processamento')
        return None

def printErro(msg):
    print('[ERRO] - %s' % msg)


def changelogInsert(params):
    retorno = carregarPlanilha(params.dados)
    if(retorno != None):
        colunas,dados = retorno

        formatInsert = 'INSERT INTO "${synchro.schema}"."/SYN/%s"(%s) VALUES(%s);'
        formatDelete = 'DELETE FROM "${synchro.schema}"."/SYN/%s" WHERE %s;'

        pathInsert = Path('insert-%s.xml' % (params.getNome().lower().replace('_','-')))

        saida = open(pathInsert.getPath(),'w')
        saida.write('%s\n' % ('<changeSet id="%s" author="synchro">' % getTempoId()))
        saida.write('\t%s\n' % '<sql>')
        for i in range(len(dados)):
            dado = dados[i]
            colunasStr = ','.join(colunas)
            dadosStr = ','.join(dado)
            linha = formatInsert % (params.getNome(),colunasStr,dadosStr)
            saida.write('\t\t%s\n' % linha)
        saida.write('\t%s\n' % '</sql>')
        saida.write('\t%s\n' % '<rollback>')
        for i in range(len(dados)):
            dado = dados[i]
            condicoes = []
            for j in range(len(colunas)):
                condicoes.append('%s=%s' % (colunas[j],dado[j]))

            where = ' AND '.join(condicoes)
            linha = formatDelete % (params.getNome(),where)
            saida.write('\t\t%s\n' % linha)
        saida.write('\t%s\n' % '</rollback>')
        saida.write('</changeSet>')
        saida.close()
        print('Changelog: %s' % pathInsert.getPath())

def changelogTabela(params):

    pathCreate = Path('create-%s.xml' % (params.getNome().lower().replace("_",'-')))

    drop = 'DROP TABLE FROM "${synchro.schema}"."/SYN/%s";' % params.getNome()
    try:
        saida = open(pathCreate.getPath(),'w')
        origem = open(params.getDados(),'r')
        saida.write('%s\n' % ('<changeSet id="%s" author="synchro">' % getTempoId()))
        saida.write('\t%s\n' % '<sql>')
        for linha in origem:
            if('SYN4TDF_EVOLUCAO' in linha):
                if('"SYN4TDF_EVOLUCAO"' in linha):
                    linha  = linha.replace('"SYN4TDF_EVOLUCAO"','"${synchro.schema}"')
                else:
                    linha  = linha.replace('SYN4TDF_EVOLUCAO','"${synchro.schema}"')
            saida.write('\t\t%s' % linha)
        saida.write('\n\t%s\n' % '</sql>')
        saida.write('\t%s\n' % '<rollback>')
        saida.write('\t\t%s\n' % drop)
        saida.write('\t%s\n' % '</rollback>')
        saida.write('</changeSet>')
        saida.close()
        origem.close()
        print('Changelog: %s' % pathCreate.getPath())
    except FileNotFoundError:
        printErro('Arquivo: %s não foi encontrado.' % params.getDados())

def changelogProcedure(params):
    try:
        origem = open(params.getDados(),'r')
        pathCreate = Path('create-procedure-%s.sql' % params.getNome().lower().replace('_','-'))
        pathCasca = Path('create-procedure.xml')
        pathChangelog = Path('changelog-procedure.xml')

        create = open(pathCreate.getPath(),'w')
        crateCasca = open(pathCasca.getPath(),'w')
        changelog = open(pathChangelog.getPath(),'w')

        crateCasca.write('%s\n' % ('<changeSet id="%s" author="synchro">' % getTempoId()))
        crateCasca.write('\t%s\n' % ('<createProcedure procedureName="/SYN/%s"' % params.getNome()))
        crateCasca.write('\t\t%s\n' % 'catalogName="${synchro.catalog}"')
        crateCasca.write('\t\t%s\n' % 'schemaName="${synchro.schema}"')
        crateCasca.write('\t\t%s\n' % 'encoding="utf8">')

        changelog.write('%s\n' % ('<changeSet id="%s" author="synchro" runOnChange="true">' % getTempoId()))
        
        changelog.write('\t%s\n' % '<sql>')
        changelog.write('\t\t%s\n' %('DROP PROCEDURE "${synchro.schema}"."/SYN/%s"' % params.getNome()))
        changelog.write('\t%s\n' % '</sql>')

        changelog.write('\t%s\n' % ('<createProcedure procedureName="/SYN/%s"' % params.getNome()))
        changelog.write('\t\t%s\n' % 'catalogName="${synchro.catalog}"')
        changelog.write('\t\t%s\n' % ('path="migrations/%s"' % pathCreate.getPath()))
        changelog.write('\t\t%s\n' % 'schemaName="${synchro.schema}"')
        changelog.write('\t\t%s\n' % 'encoding="utf8"')
        changelog.write('\t\t%s\n' % 'relativeToChangelogFile="true"/>')

        changelog.write('\t%s\n' % '<rollback/>')
        changelog.write('%s\n' % '</changeSet>')

        auxCasca = True
        for linha in origem:
            if('SYN4TDF_EVOLUCAO' in linha):
                if('"SYN4TDF_EVOLUCAO"' in linha):
                    linha  = linha.replace('"SYN4TDF_EVOLUCAO"','"${synchro.schema}"')
                else:
                    linha  = linha.replace('SYN4TDF_EVOLUCAO','"${synchro.schema}"')
            if(auxCasca):        
                if(('begin' in linha) or ('BEGIN' in linha)):
                    crateCasca.write('\t\t%s' % linha)
                    crateCasca.write('\t\t%s' % 'END')
                    auxCasca = False
                else:
                    crateCasca.write('\t\t%s' % linha) 
            create.write('%s' % linha)
        crateCasca.write('\n\t%s\n' % '</createProcedure>')
        crateCasca.write('\t%s\n' % '<rollback>')
        crateCasca.write('\t\t%s\n' %('DROP PROCEDURE "${synchro.schema}"."/SYN/%s"' % params.getNome()))
        crateCasca.write('\t%s\n' % '</rollback>')
        crateCasca.write('%s' % '</changeSet>')
        crateCasca.close()
        changelog.close()
        create.close()
        origem.close()

        print('Changelog(create): %s' % pathCreate.getPath())
        print('Changelog(casca): %s' % pathCasca.getPath())
        print('Changelog: %s' % pathChangelog.getPath())
    except FileNotFoundError:
        printErro('Arquivo: %s não foi encontrado.' % params.getDados())


params = Parametros(args)

if(params.ok):
    if params.getTipo() == '-i':
        changelogInsert(params)
    elif params.getTipo() == '-t':
        changelogTabela(params)
    elif params.getTipo() == '-p':
        changelogProcedure(params)



