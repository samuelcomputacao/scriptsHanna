class Notificacao:

    def notificaErro(self, msg):
        print("[ERRO] --> %s" % msg)
    
    def notificaSucesso(self,msg):
        print("[SUCESSO] --> %s" % msg)