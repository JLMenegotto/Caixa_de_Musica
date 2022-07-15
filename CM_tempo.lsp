;;                                                                                         
;; Inicia os tempos                                                                        
;;                                                                                         
;;                                                                                         
(defun Cx:ini_tempo ()
           
      (setq
            *rtm_pulsos*      "40"
            *rtm_ritmo*       0
            *rtm_veloc*       1.0
            *rtm_tempobase*   (if (Cx:progres?)
                                   '(("1.0000" "0.7500"  "0.5000") ("0.2500"  "0.1250" "0.0625"))
                                   '(("1.0000" "0.7500"  "1.0000") ("0.5000"  "1.0000" "0.5000"))
                              )
            *rtm_tempos*      (list
                                    (Cx:N_lst   *rtm_tempobase*)
                                    (Cx:R_lst   *rtm_tempobase*)
                                    (Cx:E_lst   *rtm_tempobase*)
                                    (Cx:ER_lst  *rtm_tempobase*)
                              )
            *rtm_tempo_vozes* (list '("Normal      "  0   1.0    1)
                                    '("Piano       "  0   2.0    1)
                                    '("Rápido      "  0   0.5    1)
                                    '("Normal Retro"  0   1.0   -1)
                                    '("Piano  Retro"  0   2.0   -1)
                                    '("Rápido Retro"  0   0.5   -1)
                              )
      )
      (Cx:Grad_tempo  *rtm_ritmo*  1)
)

(defun Cx:progres? () (= *rtm_proges* "1"))

;; Prepara o eixo X graduando os tempos na variável *rtm_T_tempos_i*                       
;; #i Indice da lista de tempos                                                            
;; #r Fator de retrogradação 1 = normal  -1 = tempo retrogradado                           

(defun Cx:Grad_tempo (#i #r)
      (setq *rtm_T_tempos_i* (Cx:veloc_da_voz  #i  #r))
      (Cx:set_tempos *rtm_T_tempos_i*)
)

(defun Cx:veloc_da_voz (#i #r) (Cx:Ajusta_veloc (nth #i *rtm_tempos*) #r))

(defun Cx:Ajusta_veloc (#l #r)
      (mapcar '(lambda (d)
                          (rtos (* *rtm_veloc* (atof d)) 2 4)
               )
               #l
      )
)

;;                                                                                         
;; Operações de transformação da lista de tempos.                                          
;; O parâmetro #l não deve ter elementos repetidos.                                        
;;                                                                                         
(defun Cx:N_lst (#l)
            (append              ;; Abre lista de tempos normal
                  (nth 0 #l)
                  (nth 1 #l)
            )         
)

(defun Cx:E_lst (#l)
      (append
            (reverse (nth 0 #l)) ;; Captura 1° metade espelhada
            (reverse (nth 1 #l)) ;; Captura 2° metade espelhada
      )
)

(defun Cx:R_lst  (#l)
      (reverse                   ;; Espelha 1° e 2° metade     
               (append
                     (nth 0 #l)
                     (nth 1 #l)
               )
      )
)

(defun Cx:ER_lst (#l) (reverse (Cx:E_lst #l)))

;;                                                                                         
;; Gradua o eixo X com a lista de tempo                                                    
;; #lt lista de tempos                                                                     

(defun Cx:set_tempos (#lt)

      (setq *rtm_L_tempos* #lt
            *rtm_M_tempos* (length *rtm_L_tempos*)
            *rtm_dura*     (nth 0  *rtm_L_tempos*)
      )
)