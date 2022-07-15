;; #p representa a nota da variável *rtm_paso1*                                            
(defun Cx:es_mult? (#p #n)
      (and (not (zerop #p))
           (zerop (rem #p #n))
      )
)
(defun Cx:no_mult?   (#p #n) (not (zerop (rem #p #n))))

;;                                                                                         
;;  Toca de acordo com algum Método                                                        
;;                                                                                         
;; #l Lista con as coordenadas a serem traduzidas                                          
(defun Cx:tocar (#l)

      (Cx:Control_andamento1         *rtm_paso1*)   
      (Cx:Control_andamento_trechos  *rtm_paso2*)
      
      (cond
            ((=  "0" *rtm_metodo*) (Cx:Distribuir_por_morfologia #l  *rtm_paso1* "S"))
            ((=  "1" *rtm_metodo*) (Cx:Distribuir_por_morfologia #l  *rtm_paso1* "T"))
            ((=  "2" *rtm_metodo*) (Cx:Distribuir_I                  *rtm_paso1*))
            ((=  "3" *rtm_metodo*) (Cx:Distribuir_M                  *rtm_paso1*))
            ((=  "4" *rtm_metodo*) (Cx:Distribuir_Q                  *rtm_paso1*))
            ((=  "5" *rtm_metodo*) (Cx:Distribuir_P                  *rtm_paso1*))
            ((=  "6" *rtm_metodo*) (Cx:Distribuir_Serie_21           *rtm_paso1*))
            ((=  "7" *rtm_metodo*) (Cx:Distribuir_Serie_321          *rtm_paso1*))
            ((=  "8" *rtm_metodo*) (Cx:Distribuir_Serie_4321         *rtm_paso1*))
            ((=  "9" *rtm_metodo*) (Cx:Distribuir_Serie_54321        *rtm_paso1*))
            ((= "10" *rtm_metodo*) (Cx:Distribuir_Serie_105321       *rtm_paso1*))
            ((= "11" *rtm_metodo*) (Cx:Distribuir_Serie_faces        *rtm_paso1*))
            ((= "12" *rtm_metodo*) (Cx:Distribuir_Serie_01           *rtm_paso1*))
            ((= "13" *rtm_metodo*) (Cx:Distribuir_Centros            *rtm_paso1*))
            ((= "14" *rtm_metodo*) (Cx:Coordenada->frequencia        *rtm_paso1*))
            (t                     (Cx:Distribuir_por_morfologia #l  *rtm_paso1* "S"))
      )
      
      (setq *rtm_paso1* (Cx:ModV (1+ *rtm_paso1*) (Cx:4Qper)))
      (setq *rtm_paso2* (Cx:ModV (1+ *rtm_paso2*) (Cx:4per)))
      
      (Cx:Toca_ponto #l *rtm_padraoM*)
)

;; Distribuição da lista de pontos e direções dos pontos                                   
;; Forma a lista de pontos tocados segundo o padrão de toque #seq                          
;; Traduz a lista de pontos tocados pts_seq                                                
;; #l    Lista con as coordenadas a serem traduzidas                                       
;; #seq  Lista com os graus a serem produzidos como uma frase                              
 
(defun Cx:Toca_ponto (#l #seq)
      (setq teste #seq)
      (Cx:error "tocar_08")
      (setq
          pts_seq               (mapcar '(lambda (s)  (Cx:Punto #l  s)) #seq)
          *rtm_L_tocadas* (cons (mapcar '(lambda (pt) (Cx:XYZ->CMO pt)) pts_seq) *rtm_L_tocadas*)
      )
      (Cx:error "tocar_09")
)


(defun Cx:Inicie_paso ()
             (setq
                   *rtm_paso1* 1
                   *rtm_paso2* 1
             )
             (Cx:control "*P1-2*")
)