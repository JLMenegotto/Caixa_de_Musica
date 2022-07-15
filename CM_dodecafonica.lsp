;;;                                                                                        
;;; Forma a matriz dodecafónica com as classes de altura originais                         
;;; utilizando a função randômica. o Parâmetro #fat pode tomar o valor 12  ou 6 para       
;;; organizar hexacordes                                                                   
;;;                                                                                        
(defun Cx:Forma_serie_dodecafonica (#fat / cla)
      (setq *rtm_serie12* '())
      ;; inicia a lista serial                                                             
      (while (< (length *rtm_serie12*) #fat)

            (setq cla (nth (Cx:mod12 (Cx:randomico #fat)) *rtm_croma*))  
            (if (not (member cla *rtm_serie12*))
                  (setq *rtm_serie12* (cons cla *rtm_serie12*))
            )
      )
      ;; completa o 2° hexacorde caso seja necessário                                      
      (while (< (length *rtm_serie12*) 12)
            (setq cla (nth (Cx:mod12 (Cx:randomico 12)) *rtm_croma*))  
            (if (not (member cla *rtm_serie12*))
                  (setq *rtm_serie12* (cons cla *rtm_serie12*))
            )
      )     
      (Cx:Extrair_Indices_O *rtm_serie12*)
)
;;;                                                                                        
;;; Forma as listas de indices O_I com as 12 classes de altura dadas peça função           
;;; randômica e forma as listas O-I-R-RI                                                   
;;;                                                                                        
(defun Cx:Extrair_Indices_O (#l / i lista_base)

      (setq in_CA_base (Cx:I->CA (car #l)))
      (setq lista_base (Cx:Escala *rtm_croma* (car #l) nil))
      
      ;;Indices da primeira linha e coluna dodecafónica                                    
      (setq *rtm_indices_O* (mapcar '(lambda (e)
                                           (setq i (- (Cx:I->CA e) in_CA_base))
                                           (if (<= 0 i)
                                                 i
                                               (+ 12 i)
                                           )
                                     )
                                    #l
                            )
      )
      (setq *rtm_indices_I* (mapcar '(lambda (e) (Cx:mod12 (- 12 e))) *rtm_indices_O*))
      ;; Classes de alturas O - I - R - RI                                                 
      (Cx:O_I_R_RI lista_base)
)

;; Retira um elemento de uma lista                                                         
;; A lista não deve ter elementos repetidos                                                
(defun Cx:retira_elemento (#e #lista)
      (if #lista
            (if (member #e #lista)
                  (append (reverse (cdr (member #e (reverse #lista))))
                          (cdr (member #e #lista))
                  )
                  #lista
            )
      )
)

;;;                                                                                        
;;; Forma as listas listas O-I-R-RI com as 12 classes de alturas a partir                  
;;; dos índices da matriz dodecafónica                                                     
;;;                                                                                        
(defun Cx:Muda_series_dodecafonicas (#ca)
      (setq nota_base (if (numberp #ca)
                            (nth (Cx:mod12 #ca) *rtm_croma*)
                            #ca
                      )
      )
      (Cx:O_I_R_RI (Cx:Escala *rtm_croma* nota_base nil))
      
)

(defun Cx:O_I_R_RI (#l)
      (setq
            *rtm_clasalt_O*  (Cx:formar_12 *rtm_indices_O* #l)
            *rtm_clasalt_I*  (Cx:formar_12 *rtm_indices_I* #l)
            *rtm_clasalt_R*  (reverse *rtm_clasalt_O*)
            *rtm_clasalt_RI* (reverse *rtm_clasalt_I*)
      )
      
)

;;;                                                                                        
;;; Forma a lista de classes de altura com os índices e a lista de classes de altura de    
;;; referência fornecidos como parâmetro                                                   
(defun Cx:formar_12 (#lindices #lbase)
      (mapcar '(lambda (i) (nth i #lbase)) #lindices)
)

(defun Cx:Mod12 (#n / md)
       (abs (- #n (* 12 (rem (/ #n 12)))))
)

;;; Função de aritmética modular para módulo 12                                            
(defun Cx:Mod12 (#n)     (abs (- #n (* 12 (rem (/ #n 12))))))

;;; Função de aritmética modular para módulo variável                                      
(defun Cx:ModV  (#n #m)  (abs (- #n (* #m (rem (/ #n #m))))))

;;; Seleciona índice da classe de altura                                                   
(defun Cx:I->CA (#ca)
      (cond
            ((= ":c"  #ca)  0)
            ((= ":cs" #ca)  1)
            ((= ":d"  #ca)  2)
            ((= ":ds" #ca)  3)
            ((= ":e"  #ca)  4)
            ((= ":f"  #ca)  5)
            ((= ":fs" #ca)  6)
            ((= ":g"  #ca)  7)
            ((= ":gs" #ca)  8)
            ((= ":a"  #ca)  9)
            ((= ":as" #ca) 10)
            ((= ":b"  #ca) 11)
      )
)

;; Função randómica adaptada de http://www.cadforum.cz/cadforum_en/qaID.asp?tip=1366       
;; Para formar hexacordes colocar o fator = 5, para formar escala de 12 ST fator = 12      
;; Utiliza variável global *rtm_randomico*                                                 

(defun Cx:randomico (#fat / mod mul inc ran fat)
  
      (setq 
            mod 14545
            mul 12231
            inc 12384
            *rtm_randomico* (rem (+ (* mul *rtm_randomico*) inc) mod)
            ran             (fix (* #fat (/ *rtm_randomico* mod)))
      )
)

(defun Cx:mudamodul?     () (= *rtm_modular* "1"))
(defun Cx:no_usaFRQ?     () (= *rtm_usafreq* "0"))
(defun Cx:no_usaMAX?     () (= *rtm_usaMAX*  "0"))
(defun Cx:usaMAX?        () (= *rtm_usaMAX*  "1"))
(defun Cx:usaFRQ?        () (= *rtm_usafreq* "1"))
(defun Cx:dodecafonica?  () (= *rtm_atonal*  "1"))
(defun Cx:diatonico?     () (= *rtm_atonal*  "0"))
(defun Cx:ultimodaserie? () (and (Cx:dodecafonica?) (= (length *rtm_escala_U*) 1)))
(defun Cx:fim_ciclo1?    () (and (Cx:dodecafonica?) (= (length *rtm_escala_U*) 1) (= *rtm_ciclo12* 1)))
(defun Cx:fim_ciclo2?    () (and (Cx:dodecafonica?) (= (length *rtm_escala_U*) 1) (= *rtm_ciclo12* 2)))
(defun Cx:fim_ciclo3?    () (and (Cx:dodecafonica?) (= (length *rtm_escala_U*) 1) (= *rtm_ciclo12* 3)))
(defun Cx:fim_ciclo4?    () (and (Cx:dodecafonica?) (= (length *rtm_escala_U*) 1) (= *rtm_ciclo12* 4)))