;;                                                                                         
;;#u1  Representa a variável  *rtm_paso1*                                                  
;;                                                                                         
(defun Cx:Distribuir_I (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 (Cx:4Qper)) (CM_index *rtm_M_Frase* 1 t))
                                ((Cx:es_mult? #u1 (Cx:2Qper)) (CM_index *rtm_M_Frase* 1 nil))
                                ((Cx:es_mult? #u1 (Cx:1Qper)) (CM_index *rtm_M_Frase* 1 t))
                                ((Cx:es_mult? #u1 (Cx:1oper)) (CM_index *rtm_M_Frase* 1 nil))
                                (t                            (CM_index *rtm_M_Frase* 1 t))
                          )
      )
      (Cx:adi_Frase "Inteiro ")
)

(defun Cx:Distribuir_M (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 (Cx:2Qper)) (CM_index *rtm_M_Frase* 2 t))
                                ((Cx:es_mult? #u1 (Cx:1Qper)) (CM_index *rtm_M_Frase* 2 nil))
                                ((Cx:es_mult? #u1 (Cx:1oper)) (CM_index *rtm_M_Frase* 2 t))
                                (t                            (CM_index *rtm_M_Frase* 2 nil))
                          )
      )
      (Cx:adi_Frase "Meio ")
)

(defun Cx:Distribuir_Q (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 (Cx:1Qper)) (CM_index *rtm_M_Frase* 3 nil))
                                ((Cx:es_mult? #u1 (Cx:1oper)) (CM_index *rtm_M_Frase* 3 t))
                                (t                            (CM_index *rtm_M_Frase* 3 nil))
                          )
      )
      (Cx:adi_Frase "Quarto ")
)

(defun Cx:Distribuir_P (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 (Cx:1oper)) (CM_index *rtm_M_Frase* 4 nil))
                                (t                            (CM_index *rtm_M_Frase* 4 t))
                          )
      )
      (Cx:adi_Frase "Oitavo ")
)

;;Padroes de toque fixos de acordo com as tramas de múltiplos                              

(defun Cx:Distribuir_Serie_21 (#u1)
     
      (setq *rtm_padraoM* (cond 
                                ((Cx:es_mult? #u1 2) (Cx:somaL *rtm_padraoM* 2))
                                (t                   (Cx:somaL *rtm_padraoM* 1))
                          )
      )
      (Cx:adi_Frase "Multiplos_21 ")
)

(defun Cx:Distribuir_Serie_321 (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 3) (Cx:somaL *rtm_padraoM* 3))
                                ((Cx:es_mult? #u1 2) (Cx:somaL *rtm_padraoM* 2))
                                (t                   (Cx:somaL *rtm_padraoM* 1))
                          )
      )
      (Cx:adi_Frase "Multiplos_321 ")
)

(defun Cx:Distribuir_Serie_4321 (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 4) (Cx:somaL *rtm_padraoM* 4))
                                ((Cx:es_mult? #u1 3) (Cx:somaL *rtm_padraoM* 3))
                                ((Cx:es_mult? #u1 2) (Cx:somaL *rtm_padraoM* 2))
                                (t                   (Cx:somaL *rtm_padraoM* 1))
                          )
      )
      (Cx:adi_Frase "Multiplos_4321 ")
)

(defun Cx:Distribuir_Serie_54321 (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 5) (Cx:somaL *rtm_padraoM* 5))
                                ((Cx:es_mult? #u1 4) (Cx:somaL *rtm_padraoM* 4))
                                ((Cx:es_mult? #u1 3) (Cx:somaL *rtm_padraoM* 2))
                                (t                   (Cx:somaL *rtm_padraoM* 1))
                          )
      )
      (Cx:adi_Frase "Multiplos_54321 ")
)

(defun Cx:Distribuir_Serie_105321 (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 10) (Cx:somaL *rtm_padraoM* 10))
                                ((Cx:es_mult? #u1  5) (Cx:somaL *rtm_padraoM*  5))
                                ((Cx:es_mult? #u1  3) (Cx:somaL *rtm_padraoM*  3))
                                ((Cx:es_mult? #u1  2) (Cx:somaL *rtm_padraoM*  2))
                                (t                    (Cx:somaL *rtm_padraoM*  1))
                          )
      )
      (Cx:adi_Frase "Multiplos_105321 ")
)

(defun Cx:Distribuir_Serie_faces (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 5) '(0 1 2 3 4 0))
                                ((Cx:es_mult? #u1 4) '(0 5 6 7 0 0))
                                ((Cx:es_mult? #u1 3) '(0 1 2 0 4 0))
                                ((Cx:es_mult? #u1 2) '(0 5 0 7 8 0))
                                ((Cx:es_mult? #u1 1) '(0 0 2 3 4 0))
                                (t                   '(0 1 2 3 4 0))
                          )
      )
      (Cx:adi_Frase "Serie_faces ")
)

(defun Cx:Distribuir_Serie_01 (#u1)
      (setq *rtm_padraoM* (cond
                                ((Cx:es_mult? #u1 6) '(0))
                                ((Cx:es_mult? #u1 5) '(5))
                                ((Cx:es_mult? #u1 4) '(4))
                                ((Cx:es_mult? #u1 3) '(3))
                                ((Cx:es_mult? #u1 2) '(2))
                                ((Cx:es_mult? #u1 1) '(1))
                                (t '(0))
                          )
      )
      (Cx:adi_Frase "Serie_01 ")
)

(defun Cx:Distribuir_Centros (#u1) (setq *rtm_padraoM* '(0)) (Cx:adi_Frase "Centro "))

;; Soma incremento i# aos elementos numéricos da lista #l com limite dado                  
;; O módulo *rtm_M* é utilizado com módulo 9                                               
(defun Cx:somaL (#l #i)
                  (mapcar '(lambda (e)
                                       (Cx:ModV (+ e #i) *rtm_M*)
                           )
                           #l
                  )
                  
)

;; Cria padrão numérico inicial com quantidade de elementos igual a #m                     

(defun Cx:padrao_inicial (#m)
      (repeat #m
            (setq *rtm_padraoM* (cons (Cx:randomico 9) *rtm_padraoM*))
      )
)