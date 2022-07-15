;;                                                                                         
;; Inicia as escalas                                                                       
;;                                                                                         

(defun Cx:ini_escalas ()
      (Cx:error "esca_01")
      (setq *rtm_escalas* (list
                                (list "C+"    (Cx:Escala *rtm_croma* ":c"  0))
                                (list "C#+"   (Cx:Escala *rtm_croma* ":cs" 0))
                                (list "D+"    (Cx:Escala *rtm_croma* ":d"  0))
                                (list "D#+"   (Cx:Escala *rtm_croma* ":ds" 0))
                                (list "E+"    (Cx:Escala *rtm_croma* ":e"  0))
                                (list "F+"    (Cx:Escala *rtm_croma* ":f"  0))
                                (list "F#+"   (Cx:Escala *rtm_croma* ":fs" 0))
                                (list "G+"    (Cx:Escala *rtm_croma* ":g"  0))
                                (list "G#+"   (Cx:Escala *rtm_croma* ":gs" 0))
                                (list "A+"    (Cx:Escala *rtm_croma* ":a"  0))
                                (list "A#+"   (Cx:Escala *rtm_croma* ":a"  0))
                                (list "B+"    (Cx:Escala *rtm_croma* ":b"  0))
                                (list "C-"    (Cx:Escala *rtm_croma* ":c"  1))
                                (list "C#-"   (Cx:Escala *rtm_croma* ":cs" 1))
                                (list "D-"    (Cx:Escala *rtm_croma* ":d"  1))
                                (list "D#-"   (Cx:Escala *rtm_croma* ":ds" 1))
                                (list "E-"    (Cx:Escala *rtm_croma* ":e"  1))
                                (list "F-"    (Cx:Escala *rtm_croma* ":f"  1))
                                (list "F#-"   (Cx:Escala *rtm_croma* ":fs" 1))
                                (list "G-"    (Cx:Escala *rtm_croma* ":g"  1))
                                (list "G#-"   (Cx:Escala *rtm_croma* ":gs" 1))
                                (list "A-"    (Cx:Escala *rtm_croma* ":a"  1))
                                (list "A#-"   (Cx:Escala *rtm_croma* ":a"  1))
                                (list "B-"    (Cx:Escala *rtm_croma* ":b"  1))
                                (list "Croma" (Cx:Escala *rtm_croma* ":c"  3))
                           )
      )
      (Cx:Forma_serie_dodecafonica 6)
      (Cx:escala_U "C+") 
)

(defun Cx:escala_U (#chave)
      
      (setq *rtm_escala_U*
                 (if (Cx:dodecafonica?)
                       *rtm_serie12*                        ;;Usa série dodecafónica      
                       (cadr (assoc #chave *rtm_escalas*))  ;;Usa a lista dada pela chave 
                 )
      )
      (Cx:set_escalas *rtm_escala_U*)
)

;;                                                                                         
;; #e      lista com a escala cromâtica completa                                           
;; #tonica indica a nota tônica da escala                                                  
;; #i      índice 0 escala Maior 1 escala Menor                                            
;; (Cx:Escala *rtm_croma*  ":c"  0)                                                        

(defun Cx:Escala (#es #tonica #i)
      (mapcar '(lambda (i)
                     (nth i (Cx:parte_lst #tonica #es))
               )
               (cond
                    ((= #i 0) '(0 2 4 5 7 9 11))            ; Maior                 
                    ((= #i 1) '(0 2 3 5 7 8 10))            ; Menor                 
                    ((= #i 4) '(0 2 4 6 8 10))              ; Tons Int. Debussy     
                    (t        '(0 1 2 3 4 5 6 7 8 9 10 11)) ; Cromática dodecafónica
               )
      )
)

(defun Cx:intervalos (#es #i)
      (mapcar '(lambda (i)
                     (nth i #es)
               )
               (cond
                    ((= #i "II")  '(0 1 2 3 4 5 6))  ; Segundas diatônicas
                    ((= #i "III") '(0 2 4 6 1 3 5))  ; Terças   diatônicas
                    ((= #i "IV")  '(0 3 6 2 5 1 4))  ; Quartas  diatônicas
                    ((= #i "V")   '(0 4 1 5 2 6 3))  ; Quinta   diatônica 
                    ((= #i "VI")  '(0 5 3 1 6 4 2))  ; Sexta    diatônica 
                    ((= #i "VII") '(0 6 5 4 3 2 1))  ; Sétima   diatônica 
                    (t            '(0 1 2 3 4 5 6))  ; Maior              
               )
      )
)

(defun Cx:intervalos2 (#es #i)
      (mapcar '(lambda (i)
                     (nth i #es)
               )
               (cond
                    ((= #i "II")  '(0 1 2 3 4 5 6))  ; Segundas diatônicas
                    ((= #i "III") '(0 2 4 6))        ; Terças   diatônicas
                    ((= #i "IV")  '(0 3 6))          ; Quartas  diatônicas
                    ((= #i "V")   '(0 4))            ; Quinta   diatônica 
                    ((= #i "VI")  '(0 5))            ; Sexta    diatônica 
                    ((= #i "VII") '(0 6))            ; Sétima   diatônica 
                    (t            '(0 1 2 3 4 5 6))  ; Maior              
               )
      )
)

(defun Cx:I_escala (#esca)   
         (setq
               *rtm_indesc_O* (mapcar 'Cx:I->CA #esca)
               *rtm_indesc_I* (mapcar '(lambda (e) (Cx:mod12 (- 12 e))) *rtm_indesc_O*)
               *rtm_CALesc_I* (mapcar '(lambda (i) (nth i *rtm_croma*)) *rtm_indesc_I*)
         )
)

(defun Cx:T_escala (#esca #salto)   
         (setq
               *rtm_indesc_O* (mapcar 'Cx:I->CA #esca)
               *rtm_indesc_T* (mapcar '(lambda (e) (Cx:mod12 (+ #salto e))) *rtm_indesc_O*)
               *rtm_CALesc_T* (mapcar '(lambda (i) (nth i *rtm_croma*))     *rtm_indesc_T*)
         )
)

;; Parte a lista no indice fornecido como argumento                                        
;; Função utilizada para formar a escala                                                   
(defun Cx:parte_lst (#i #lst)
      (append
            (member #i #lst)
            (reverse (cdr (member #i (reverse #lst))))
      )
)

;; Prepara a lista de modos do eixo Y e o índice modular dessa lista                       
;; #lm lista do modo utilizada                                                             
(defun Cx:set_escalas (#lm)
      (setq
            *rtm_L_escala* #lm
            *rtm_M_escala* (length *rtm_L_escala*)
            *rtm_ClAl*     (nth 0 *rtm_L_escala*)
      )
)

;; Retrograda a lista de modo                                                              
(defun Cx:Retro_Modo (#lm) (Cx:set_escalas (reverse #lm)))
;; Prepara a lista de oitavas do eixo Z e o índice modular dessa lista                     
;; #lo lista do oitavas utilizada                                                          
(defun Cx:Set_oitavas (#lo)
      (setq
            *rtm_L_oitava* #lo
            *rtm_M_oitava* (length *rtm_L_oitava*)
      )
)
