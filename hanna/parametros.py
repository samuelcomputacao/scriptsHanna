class Parametros:
    
    tipo = None
    dados = None
    nome = None
    ok = None

    #dados de acesso ao banco
    schema = None
    address = None
    port = None
    user = None
    password = None

    TIPO_TABELA = '-t'
    TIPO_PROCEDURE = '-p'
    TIPO_INSERT = '-i'
    TIPO_HELP = '--help'

    def __init__(self,args,address,port,user,password,schema):
        try:
            tipo = args[0]
            if(tipo == self.TIPO_TABELA or tipo == self.TIPO_PROCEDURE or tipo == self.TIPO_INSERT or tipo == self.TIPO_HELP):
                self.tipo = tipo
                if(self.tipo == self.TIPO_HELP):
                    self.printHelp()
                    self.ok = False
                    return
                
                arg = args[1]
                valor = args[2]

                if(arg == '-n'):
                    self.nome = valor
                    
                if(self.nome != None):
                    self.ok = True
                    self.address = address
                    self.port = port
                    self.user = user
                    self.password = password
                    self.schema = schema
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