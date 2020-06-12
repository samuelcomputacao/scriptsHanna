import sys
from parametros import Parametros
from changelog import Changelog

args = sys.argv[1:]
params = Parametros(args=args,address='vhs4h1809', port=30050, user='SYN4TDF_EVOLUCAO', password='Syn4Tdf_01',schema='SYN4TDF_EVOLUCAO')

gerador = Changelog(params)

if(params.ok):
    if params.getTipo() == '-i':
        gerador.changelogInsert(params)
    elif params.getTipo() == '-t':
        gerador.changelogTabela(params)
    elif params.getTipo() == '-p':
        gerador.changelogProcedure(params)

# hanna = Hanna(address='vhs4h1809', port=30050, user='SYN4TDF_EVOLUCAO', password='Syn4Tdf_01')
# hanna.conectar()
# procedure = hanna.getProcedureSQL('SYN4TDF_EVOLUCAO','P_GERA_DIEF_PI')
# table = hanna.getTableSQL('SYN4TDF_EVOLUCAO','DIEF_PI_REGISTRO_TIPO_50')
# insert = hanna.getDadosTableCSV('SYN4TDF_EVOLUCAO','OBRIGACOES_COD_MUN_BA')
# print(insert)
