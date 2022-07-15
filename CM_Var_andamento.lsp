;; Variações do período                                                                    
(defun Cx:4per  () (fix (* *rtm_periodo*   4.0)))
(defun Cx:3per  () (fix (* *rtm_periodo*   3.0)))
(defun Cx:2per  () (fix (* *rtm_periodo*   2.0)))
(defun Cx:4Qper () (fix (* *rtm_periodo*   1.000)))
(defun Cx:3Qper () (fix (* *rtm_periodo*   0.750)))
(defun Cx:2Qper () (fix (* *rtm_periodo*   0.500)))
(defun Cx:1Qper () (fix (* *rtm_periodo*   0.250)))
(defun Cx:1oper () (fix (* *rtm_periodo*   0.125)))
;; Variações do tamanho modular da caixa                                                   
(defun Cx:MX01  ()      (* *rtm_unidad*    1))
(defun Cx:MX02  ()      (* *rtm_unidad*    2))
(defun Cx:MX03  ()      (* *rtm_unidad*    2.5))
(defun Cx:MX04  ()      (* *rtm_unidad*    4))
(defun Cx:MX05  ()      (* *rtm_unidad*    5))
(defun Cx:MX10  ()      (* *rtm_unidad*   10))
(defun Cx:M/2   ()      (* *rtm_unidad*    0.5))
(defun Cx:M/3   ()      (* *rtm_unidad*    0.33333))
(defun Cx:M/4   ()      (* *rtm_unidad*    0.25))
(defun Cx:M/5   ()      (* *rtm_unidad*    0.20))
(defun Cx:M/6   ()      (* *rtm_unidad*    0.16666))
(defun Cx:M/8   ()      (* *rtm_unidad*    0.125))
(defun Cx:M-DM  ()      (* *rtm_unidad*    0.1))
(defun Cx:M-CM  ()      (* *rtm_unidad*    0.01))
(defun Cx:M-MM  ()      (* *rtm_unidad*    0.001))
(defun Cx:M-MC  ()      (* *rtm_unidad*    0.0001))
(defun Cx:TR    ()      (* *rtm_mod_tramo* 1.00))
(defun Cx:TR/2  ()      (* *rtm_mod_tramo* 0.50))
(defun Cx:TR/4  ()      (* *rtm_mod_tramo* 0.25))

;; Grava padrão de modificações                                                            
(defun Cx:control (#c) (setq ctrl_vario (strcat (if ctrl_vario ctrl_vario "[Padrao]") #c)))

(defun Cx:trecho (#u2 #n) (= #u2 (setq face (fix (* *total_faces* (/ #n (Cx:4Qper)))))))

(defun Cx:Control_andamento1 (#u1 / fac)
      (setq fac (strcat "\n;;[" (itoa #u1) "]"))
      (cond
            ((Cx:es_mult? #u1 (Cx:4Qper)) (Cx:somaL *rtm_padraoM* 7) (Cx:control (strcat fac " -A- ")) (Cx:Alter_escala "I" ) (Cx:Alter_Ritmo 0 1) (Cx:Alter_inter t))
            ((Cx:es_mult? #u1 (Cx:3Qper)) (Cx:somaL *rtm_padraoM* 7) (Cx:control (strcat fac " -B- ")) (Cx:Alter_escala "R" ) (Cx:Alter_Ritmo 0 1) (Cx:Alter_inter t))
            ((Cx:es_mult? #u1 (Cx:2Qper)) (Cx:somaL *rtm_padraoM* 7) (Cx:control (strcat fac " -C- ")) (Cx:Alter_escala "T" ) (Cx:Alter_Ritmo 0 1) (Cx:Alter_inter nil))
            ((Cx:es_mult? #u1 (Cx:1Qper)) (Cx:somaL *rtm_padraoM* 7) (Cx:control (strcat fac " -D- ")) (Cx:Alter_escala "RI") (Cx:Alter_Ritmo 0 1) (Cx:Alter_inter nil))
      )
)

;;                                                                                         
;;                                                                                         
;;                           Variação por trechos                                          
;;                                                                                         
;;                                     Cx:Alter  velo  dina  módulo  "control"             
(defun Cx:Control_andamento_trechos (#u2)
      (setq fac (strcat "\n;;{" (itoa #u2) "}"))
      (cond
            ((Cx:trecho40 #u2  1.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr  1")))
            ((Cx:trecho40 #u2  2.0)  (Cx:Alter  1.50  1.50   (Cx:MX01) (strcat fac " tr  2")))
            ((Cx:trecho40 #u2  3.0)  (Cx:Alter  1.20  nil    nil       (strcat fac " tr  3")))
            ((Cx:trecho40 #u2  4.0)  (Cx:Alter  0.50  1.00   (Cx:MX01) (strcat fac " tr  4")))
            ((Cx:trecho40 #u2  5.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr  5")))
            ((Cx:trecho40 #u2  6.0)  (Cx:Alter  nil   2.50   (Cx:MX01) (strcat fac " tr  6")))
            ((Cx:trecho40 #u2  7.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr  7")))
            ((Cx:trecho40 #u2  8.0)  (Cx:Alter  nil   nil    (Cx:MX01) (strcat fac " tr  8")))
            ((Cx:trecho40 #u2  9.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr  9")))
            ((Cx:trecho40 #u2 10.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 10")))
            ((Cx:trecho40 #u2 11.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 11")))
            ((Cx:trecho40 #u2 12.0)  (Cx:Alter  0.80  0.10   nil       (strcat fac " tr 12")))
            ((Cx:trecho40 #u2 13.0)  (Cx:Alter  nil   2.40   nil       (strcat fac " tr 13")))
            ((Cx:trecho40 #u2 14.0)  (Cx:Alter  nil   1.50   (Cx:MX01) (strcat fac " tr 14")))
            ((Cx:trecho40 #u2 15.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 15")))
            ((Cx:trecho40 #u2 16.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 16")))
            ((Cx:trecho40 #u2 17.0)  (Cx:Alter  0.60  1.10   nil       (strcat fac " tr 17")))
            ((Cx:trecho40 #u2 18.0)  (Cx:Alter  nil   1.20   nil       (strcat fac " tr 18")))
            ((Cx:trecho40 #u2 19.0)  (Cx:Alter  nil   1.30   nil       (strcat fac " tr 19")))
            ((Cx:trecho40 #u2 20.0)  (Cx:Alter  nil   1.40   nil       (strcat fac " tr 20")))
            ((Cx:trecho40 #u2 21.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 21")))
            ((Cx:trecho40 #u2 22.0)  (Cx:Alter  1.20  1.10   (Cx:MX01) (strcat fac " tr 22")))
            ((Cx:trecho40 #u2 23.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 23")))
            ((Cx:trecho40 #u2 24.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 24")))
            ((Cx:trecho40 #u2 25.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 25")))
            ((Cx:trecho40 #u2 26.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 26")))
            ((Cx:trecho40 #u2 27.0)  (Cx:Alter  0.95  nil    (Cx:MX01) (strcat fac " tr 27")))
            ((Cx:trecho40 #u2 28.0)  (Cx:Alter  0.90  2.10   nil       (strcat fac " tr 28")))
            ((Cx:trecho40 #u2 29.0)  (Cx:Alter  0.85  nil    nil       (strcat fac " tr 29")))
            ((Cx:trecho40 #u2 30.0)  (Cx:Alter  0.80  nil    nil       (strcat fac " tr 30")))
            ((Cx:trecho40 #u2 31.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 31")))
            ((Cx:trecho40 #u2 32.0)  (Cx:Alter  2.00  1.20   nil       (strcat fac " tr 32")))
            ((Cx:trecho40 #u2 33.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 33")))
            ((Cx:trecho40 #u2 34.0)  (Cx:Alter  nil   1.30   (Cx:M/5)  (strcat fac " tr 34")))
            ((Cx:trecho40 #u2 35.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 35")))
            ((Cx:trecho40 #u2 36.0)  (Cx:Alter  nil   2.40   nil       (strcat fac " tr 36")))
            ((Cx:trecho40 #u2 37.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 37")))
            ((Cx:trecho40 #u2 38.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 38")))
            ((Cx:trecho40 #u2 39.0)  (Cx:Alter  nil   4.40   nil       (strcat fac " tr 39")))
            ((Cx:trecho40 #u2 40.0)  (Cx:Alter  nil   nil    nil       (strcat fac " tr 40")))
      ) 
)

(defun Cx:trecho40 (#u2 #n) (= #u2 (fix (* *total_faces* (/ #n *rtm_periodo*)))))

;;                                                                                         
;; Alteracion de Velocidade e dinâmica e escala durante a peça                             
;;                                                                                         

(defun Cx:Alter (#vel #din #mod #ctrl)
            (cond (#vel (Cx:Alter_veloc #vel)))
            (cond (#din (Cx:Alter_dinam #din)))
            (cond (#mod (Cx:Alter_modul #mod)))
            (Cx:control #ctrl)
)

(defun Cx:Alter_modul (#e) (Cx:Unidade #e nil)  (Cx:Mnsg_transform "Alterou módulo da caixa" nil))

(defun Cx:Alter_Ritmo (#i #r)
      (setq *rtm_ritmo* (cond
                              ((= #i 0) (Cx:ModV                  *rtm_ritro*  (length *rtm_tempos*)))
                              ((= #i 1) (Cx:ModV (+ 1 *rtm_ritmo* *rtm_ritro*) (length *rtm_tempos*)))
                        )
      )
      (Cx:Grad_tempo  *rtm_ritmo*  #r)
      (Cx:Mnsg_transform "Alterou o Ritmo" nil)
)

(defun Cx:Alter_veloc (#v)
      (setq *rtm_veloc*    #v
            *rtm_L_tempos* (mapcar '(lambda (d)
                                          (rtos (* *rtm_veloc* (atof d)) 2 4)
                                    )
                                   *rtm_T_tempos_i*
                           )
      )
      (Cx:set_tempos *rtm_L_tempos*)
      (Cx:Mnsg_transform "Alterou aceleracão" nil)
)

;; Modula entre as diversas escalas definidas na lista *rtm_escala*                        
(defun Cx:Alter_escala (#i / escal notas msg)
      (cond
            ((Cx:diatonico?)
             (cond
                   ((= #i "I")
                    (setq *rtm_escala_U* (Cx:I_escala *rtm_escala_U*))
                    (Cx:set_escalas *rtm_escala_U*)
                    (setq msg (strcat "Inverteu escala diatônica " (Cx:unir_str *rtm_escala_U*)))                  
                    (Cx:Mnsg_transform msg nil)
                   )
                   ((= #i "T")
                    (setq *rtm_escala_U* (Cx:T_escala *rtm_escala_U* 7))
                    (Cx:set_escalas *rtm_escala_U*)
                    (setq msg (strcat "Transpôs escala diatônica " (Cx:unir_str *rtm_escala_U*)))
                    (Cx:Mnsg_transform msg nil)
                   )
                   ((= #i "R")
                    (setq *rtm_escala_U* (reverse *rtm_escala_U*))
                    (Cx:set_escalas *rtm_escala_U*)
                    (setq msg (strcat "Retrogadou escala diatônica " (Cx:unir_str *rtm_escala_U*)))
                    (Cx:Mnsg_transform msg nil)
                   )
                   ((= #i "RI")
                    (setq *rtm_escala_U* (reverse (Cx:I_escala *rtm_escala_U*)))
                    (Cx:set_escalas *rtm_escala_U*)
                    (setq msg (strcat "Retrogadou Inverteu escala diatônica " (Cx:unir_str *rtm_escala_U*)))
                    (Cx:Mnsg_transform msg nil)
                   )
             ))
            ((Cx:dodecafonica?)
             (cond
                   ((= #i "I")
                    (setq *rtm_escala_U* *rtm_clasalt_I*)
                    (Cx:set_escalas *rtm_escala_U*)
                    (Cx:Mnsg_transform (strcat "Inverteu série dodecafônica ") nil)
                   )
                   ((= #i "T")
                    (setq *rtm_escala_U*  *rtm_clasalt_O*)
                    (Cx:set_escalas *rtm_escala_U*)
                    (Cx:Mnsg_transform (strcat "Série dodecafónica original ") nil)
                   )
                   ((= #i "R")
                    (setq *rtm_escala_U* *rtm_clasalt_R*)
                    (Cx:set_escalas *rtm_escala_U*)
                    (Cx:Mnsg_transform (strcat "Retrogadou série dodecafónica ") nil)
                   )
                   ((= #i "RI")
                    (setq *rtm_escala_U* *rtm_clasalt_RI*) 
                    (Cx:set_escalas *rtm_escala_U*)
                    (Cx:Mnsg_transform (strcat "Retrogadou Inverteu série dodecafónica ") nil)
                   )
             ))
      )
)


(defun Cx:Alter_inter (#i)

      (cond ((Cx:diatonico?)
             (setq *rtm_inter* (Cx:ModV (1+ *rtm_inter*) 5))
             (if (= *rtm_interva* "1")
                   (cond
                         (#i (Cx:Alter_grau "II"))
                         ((= *rtm_inter* 0) (Cx:Alter_grau "III"))
                         ((= *rtm_inter* 1) (Cx:Alter_grau "IV"))
                         ((= *rtm_inter* 2) (Cx:Alter_grau "V"))
                         ((= *rtm_inter* 3) (Cx:Alter_grau "VI"))
                         ((= *rtm_inter* 4) (Cx:Alter_grau "VII"))
                         (t (Cx:Alter_grau "II"))
                   )
             )
            )
      )
)

;;Usa so alguns graus da escala. Parâmetro #grau pode ser "II" "III" "IV" "V" "VI" "VII"   

(defun Cx:Alter_grau (#graus)
      (setq *rtm_escala_I* (Cx:intervalos2 *rtm_escala_U* #graus))
      (Cx:set_escalas *rtm_escala_I*)
      (Cx:Mnsg_transform (strcat "Alterou para " #graus) nil)
)

(defun Cx:Alter_dinam (#d)
      (setq  *rtm_dinanda*  #d               ;; dinamica  0 a 30
             *rtm_fdina*   (+ *rtm_fdina* 2) ;; dinamica 30 a 60
      )
      (Cx:Mnsg_transform "Alterou a dinâmica" nil)
)

;; Alteração das séries dodecafónicas se faz cada vez que se traduz um ponto               
;; Verifica se a lista com a série dodecafónica esvaziou                                   
;; Caso haja ainda elementos retira o que acabou de ser tocado                             

(defun Cx:Ciclos_12 (/ novoindice)

      (setq novoindice (Cx:randomico 12))
      
      (cond
            ((Cx:fim_ciclo1?)    (setq *rtm_ciclo12* 2  *rtm_escala_U*  *rtm_clasalt_I*))
            ((Cx:fim_ciclo2?)    (setq *rtm_ciclo12* 3  *rtm_escala_U*  *rtm_clasalt_R*))
            ((Cx:fim_ciclo3?)    (setq *rtm_ciclo12* 4  *rtm_escala_U*  *rtm_clasalt_RI*))
            ((Cx:fim_ciclo4?)    (setq *rtm_ciclo12* 1  *rtm_escala_U*  (Cx:Muda_series_dodecafonicas (nth novoindice *rtm_croma*))))
            ((Cx:dodecafonica?)  (setq *rtm_escala_U*  (Cx:retira_elemento *rtm_ClAl*  *rtm_escala_U*)))     
      )
      (Cx:set_escalas *rtm_escala_U*) ;; reseta a escala
)
