;;                                                                                                            
;;    Define os parâmetros de unidade da caixa                                                                
;;                                                                                                            
;; Gradua a unidade modular da caixa                                                                          
;; #u Valor do módulo da caixa                                                                                
;;                                                                                                            
(defun Cx:Grad_unidade (#u #fe)
                          (setq  *rtm_unidad*   (* #u #fe)
                                 *rtm_unidai*   *rtm_unidad*
		          )		 
                          (Cx:Unidade  *rtm_unidad*  nil)
)

;; #m é a variável *rtm_unidad*                                                                               
;; #f um tag que indica se se deve ou não desenhar a regra graduada en cada eixo                              
(defun Cx:Unidade  (#m #f / ent_uni  oen_uni)

                              (Cx:error "unid_01")
                              (setq ent_uni  (ssget "X" (list (cons  0  "3DSOLID") (cons  8  *rtm_Caixa*))))
			      (cond   (ent_uni
				               (setq oen_uni (vlax-ename->vla-object (ssname  ent_uni  0)))
			                       (vla-getboundingbox  oen_uni  'cs  'ci)
			  	               (setq *rtm_pcx1* (vlax-safearray->list  ci))
					       (setq *rtm_pcx2* (vlax-safearray->list  cs))
				      )
				      (t
				               (setq *rtm_pcx1* (list 0  0  0))
					       (setq *rtm_pcx2* (list 1  1  1))
				      )
			      )
                              (Cx:error "unid_02")
  
                              (setq  *Lx*            (Cx:DistX     *rtm_pcx1*   *rtm_pcx2*)
				     *Ly*            (Cx:DistY     *rtm_pcx1*   *rtm_pcx2*)
				     *Lz*            (Cx:DistZ     *rtm_pcx1*   *rtm_pcx2*)
				     *raio_esfera*   (* 0.01      (/ (max *Lx* *Ly* *Lz*) (min *Lx* *Ly* *Lz*)))
				     *regla*         *raio_esfera*
				     *Gra_dina*      *rtm_M_dinamica*
		              )
  
                              (Cx:error "unid_03")
  
                              (cond
				     ((and
				          #f
				          (not (tblsearch "LAYER" (strcat  *rtm_Caixa*  "_"  (Cx:String  *rtm_unidad*))))
				      )
				         (Cx:error "unid_04")
                                         (Cx:Marca_Eje_X  *rtm_pcx1*  *rtm_pcx2*  *rtm_unidad*)
                                         (Cx:Marca_Eje_Y  *rtm_pcx1*  *rtm_pcx2*  *rtm_unidad*)
				     )
			      )
                              (Cx:zonas)
)

(defun Cx:zonas ()
                           (setq
			         zona1          (ssget "X" (list (cons  0  "3DSOLID") (cons  8  "Cx_zona1")))
				 *lista_zonas* '()
		           )
                           (cond
			         (zona1
				        (setq zona1_e (vlax-ename->vla-object (ssname  zona1 0)))
			                (vla-getboundingbox  zona1_e  'cs  'ci)
			  	        (setq *lim1_zona1*  (vlax-safearray->list  ci))
					(setq *lim2_zona1*  (vlax-safearray->list  cs))
				        (setq *lista_zonas* (cons (list "Cx_zona1" *lim1_zona1* *lim2_zona1*) *lista_zonas*))
				 )
			   )
)

;;; Funções para desenhar as linhas do módulo da Caixa de música                                                

(defun Cx:Marca_Eje_X (#p1 #p2 #un)
                                   (setq p1 (Cx:MaiorX   #p1  #p2))
                                   (Cx:linhas_da_Caixa  *Lx*  #un  (list '(1  0  0)
				                                         '(0  1  0)
				                                         '(0  0  1)
							           )
				   )
)

(defun Cx:Marca_Eje_Y (#p1 #p2 #un) 
                                   (setq p1 (Cx:MaiorX  #p1  #p2))
                                   (Cx:linhas_da_Caixa  *Ly*  #un  (list '(0  1  0)
				                                         '(1  0  0)
				                                         '(0  0  1)
							           )
				   )
)

(defun Cx:Marca_Eje_Z (#p1 #p2 #un) 
                                   (setq p1 (Cx:MaiorX  #p1  #p2))
                                   (Cx:linhas_da_Caixa  *Lz*  #un  (list '(0  0  1)
				                                         '(1  0  0)
				                                         '(0  1  0)
							           )
				   )
)
 
(defun Cx:linhas_da_Caixa (#dim #un #mat / matdi matun)
  
                                     (Cx:eco_of)
                                     (setq
				           matun (list #un   #un   #un)
					   matdi (list *Lx*  *Ly*  *Lz*)
			             )
                                     (repeat (fix (/ #dim  #un))
				             (setq
					           p1 (mapcar '+ p1 (mapcar '* (car   #mat) matun))
                                                   p2 (mapcar '+ p1 (mapcar '* (cadr  #mat) matdi))
					           p3 (mapcar '+ p1 (mapcar '* (caddr #mat) matdi))
				             )
				             (Cx:linha (strcat  *rtm_Caixa*  "_"  (Cx:String  #un))  p1  p2)
				     )
                                     (Cx:eco_on)
)

(defun Cx:MaiorX (#p1 #p2)         (if (> (car  #p1) (car  #p2))  #p2  #p1))
(defun Cx:MaiorY (#p1 #p2)         (if (> (cadr #p1) (cadr #p2))  #p2  #p1))

(defun Cx:DistX  (#p1 #p2)         (distance
				             (list (car #p1) (cadr #p1) (caddr #p1))
					     (list (car #p2) (cadr #p1) (caddr #p1))
				   )
)
(defun Cx:DistY  (#p1 #p2)         (distance
		                             (list (car #p1) (cadr #p1) (caddr #p1))
					     (list (car #p1) (cadr #p2) (caddr #p1))
				   )
)
(defun Cx:DistZ  (#p1 #p2)         (distance
				             (list (car #p1) (cadr #p1) (caddr #p1))
					     (list (car #p1) (cadr #p1) (caddr #p2))
				   )
)

;;                                                                                         
;; Captura as coordenadas dos submódulos desenhados                                        
;;                                                                                         
(defun Cx:SubModulos () 
                           (setq *rtm_submodulos*    '("cx_sm1" "cx_sm2" "cx_sm3" "cx_sm4")
                                 *rtm_L_submodulos* '()
                           )
      
                           (mapcar '(lambda (lay_sm)
                                            (setq submod (ssget "X" (list (cons  0  "3DSOLID") (cons 8 lay_sm))))
			                    (cond
                                                  (submod
				                     (setq osubmod (vlax-ename->vla-object (ssname submod 0)))
			                             (vla-getboundingbox  osubmod  'cs  'ci)
			  	                     (setq smp1 (vlax-safearray->list  ci))
					             (setq smp2 (vlax-safearray->list  cs))
                                                     (setq *rtm_L_submodulos* (cons (list lay_sm smp1 smp2) *rtm_L_submodulos*))
				                  )
				                  			                
                                             )
                                    )
                                    *rtm_submodulos*
                           )
;;;                            (mapcar '(lambda (l)
;;;                                                   (command "._layer" "_s" (nth 0 l) "")
;;;                                                   (command "._line" (nth 1 l) (nth 2 l) "")
;;;                                     )
;;;                                     *rtm_L_submodulos*
;;;                            )
)

;;                                                                                         
;; Verifica se o ponto #p está dentro de um submódulo                                      
;;                                                                                         
(defun Cx:PontoIn? (#p)
                            (mapcar '(lambda (l)
                                               (setq
                                                     ie1 (apply '+ (nth 1 l))
                                                     sd1 (apply '+ (nth 2 l))
                                                     pon (apply '+ #p)
                                               )
                                               (if (< ie1 pon sd1)
                                                   (nth 0 l)
                                                   "0"
                                               )
                                     )
                                     *rtm_L_submodulos*
                            )
)

