import os
from path import Path
from notificacao import Notificacao
from hanna import Hanna
from parametros import Parametros
from myTime import Time

class Changelog:

    parametros = None
    hanna = None
    notificacoes = None
    time = None

    def __init__(self,parametros):
        self.parametros = parametros
        self.hanna = Hanna(parametros.address,parametros.port,parametros.user,parametros.password)
        self.hanna.conectar()
        self.time = Time()

    def changelogInsert(self,params):
        retorno = self.hanna.getDadosTableCSV(params.schema,params.nome)
       # print(retorno)
        if(retorno != None):
            colunas,dados = retorno

            formatInsert = 'INSERT INTO "${synchro.schema}"."/SYN/%s"(%s) VALUES(%s);'
            formatDelete = 'DELETE FROM "${synchro.schema}"."/SYN/%s" WHERE %s;'

            pathInsert = Path('insert-%s.xml' % (params.nome.lower().replace('_','-')))

            saida = open(pathInsert.getPath(),'w')
            saida.write('%s\n' % ('<changeSet id="%s" author="synchro">' % self.time.getTempoId()))
            saida.write('\t%s\n' % '<sql>')
            for i in range(len(dados)):
                dado = dados[i]
                colunasStr = ','.join(colunas)
                dadosStr = ','.join([str(d) for d in dado])
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
                linha = formatDelete % (params.nome,where)
                saida.write('\t\t%s\n' % linha)
            saida.write('\t%s\n' % '</rollback>')
            saida.write('</changeSet>')
            saida.close()
            print('Changelog: %s' % pathInsert.getPath())

    def changelogTabela(self,params):
        pathOrigem = self.hanna.getTableSQL(params.schema,params.nome)
        pathCreate = Path('create-%s.xml' % (params.nome.lower().replace("_",'-')))
        drop = 'DROP TABLE "${synchro.schema}"."/SYN/%s";' % params.nome

        saida = open(pathCreate.getPath(),'w')
        origem = open(pathOrigem,'r')
        saida.write('%s\n' % ('<changeSet id="%s" author="synchro">' % self.time.getTempoId()))
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
        os.remove(pathOrigem)
        print('Changelog: %s' % pathCreate.getPath())
        

    def changelogProcedure(self,params):
       
        pathOrigem = self.hanna.getProcedureSQL(params.schema,params.nome)
        origem = open(pathOrigem,'r')
        pathCreate = Path('create-procedure-%s.sql' % params.nome.lower().replace('_','-'))
        pathCasca = Path('create-procedure.xml')
        pathChangelog = Path('changelog-procedure.xml')

        create = open(pathCreate.getPath(),'w')
        crateCasca = open(pathCasca.getPath(),'w')
        changelog = open(pathChangelog.getPath(),'w')

        crateCasca.write('%s\n' % ('<changeSet id="%s" author="synchro">' % self.time.getTempoId()))
        crateCasca.write('\t%s\n' % ('<createProcedure procedureName="/SYN/%s"' % params.nome))
        crateCasca.write('\t\t%s\n' % 'catalogName="${synchro.catalog}"')
        crateCasca.write('\t\t%s\n' % 'schemaName="${synchro.schema}"')
        crateCasca.write('\t\t%s\n' % 'encoding="utf8">')

        changelog.write('%s\n' % ('<changeSet id="%s" author="synchro" runOnChange="true">' % self.time.getTempoId()))
            
        changelog.write('\t%s\n' % '<sql>')
        changelog.write('\t\t%s\n' %('DROP PROCEDURE "${synchro.schema}"."/SYN/%s"' % params.nome))
        changelog.write('\t%s\n' % '</sql>')

        changelog.write('\t%s\n' % ('<createProcedure procedureName="/SYN/%s"' % params.nome))
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
        crateCasca.write('\t\t%s\n' %('DROP PROCEDURE "${synchro.schema}"."/SYN/%s"' % params.nome))
        crateCasca.write('\t%s\n' % '</rollback>')
        crateCasca.write('%s' % '</changeSet>')
        crateCasca.close()
        changelog.close()
        create.close()
        origem.close()
        os.remove(pathOrigem)
        print('Changelog(create): %s' % pathCreate.getPath())
        print('Changelog(casca): %s' % pathCasca.getPath())
        print('Changelog: %s' % pathChangelog.getPath())
        




