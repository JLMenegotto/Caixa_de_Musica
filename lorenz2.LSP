(defun  ambienteX ()
                     (cond (*aobj* (princ "\nAmbiente ActiveX ativo.\n"))      
		           (t      (vl-load-com)                               
                                   (setq *aobj* (vlax-get-acad-object)         
                                         *adoc* (vla-get-activedocument *aobj*)
					 *pref* (vla-get-Preferences    *aobj*)
                                         *spac* (vla-get-modelspace     *adoc*)
                                    )                                          
		           )                                                   
                      )                      
)

(defun lor:ini () (ambienteX)
                  (setvar "cmdecho" 0)
                  (command "._vpoint" "_r" 300  30))


(defun lor:fim () (setvar "cmdecho" 1))


(defun lor:limites (#pt)  
                         (and
			      (< -100000  (car   #pt)  100000)
		              (< -100000  (cadr  #pt)  100000)
		              (< -100000  (caddr #pt)  100000)
		         ))

;;;http://local.wasp.uwa.edu.au/~pbourke/fractals/lorenz/                                     
;;;// N = quantidade de iterações                                                             
;;;// h, a, b, c: parâmetros iniciais                                                         
;;;// x0, y0, z0: ponto inicial                                                               
;;;// rad = raio do circulo desenhado                                                         
;; 0.001099, 10, 28, 8/3, 0.0001, 0.0001, 0.0001, 350000, 0.04                                

(defun lorenz (#pre #a #b #e #n #c / h a b c x0 y0 z0 N rad)

                (setq
            	      a      #a
            	      b      #b
            	      c      6.0
      		      h      0.001099
            	      x0     1.0
            	      y0     1.0
            	      z0     1.0
            	      N      #n
            	      rad    0.001
		      i      1
     		      esc    (atof #e)
		      nomlay (strcat #pre (itoa #a) (itoa #b) "_" #e "_" (itoa #n)) 
                )

                (command "._layer" "_M" nomlay "_c" #c nomlay "")
                		 
                (while (< i N)  
 		               (eq_JLM01    x0  y0  z0  a  b  c  esc  h)
		  
;;;		               (eq_lorenz84 x0  y0  z0  a  b  c  esc  h)
		  
		               (setq
                                     x0   x1
                                     y0   y1
                                     z0   z1
			             pc   (list x0 y0 z0)
		               )
		  
		               (if (lor:limites  pc)
				                   (vla-addcircle *spac* (vlax-3d-point pc) rad)
                               )
      	                       (setq i (1+ i))
 	        )                
)


(defun c:l1 ()
                 (lor:ini)  
                 (setq
		       densidad_i 100
		       color_i    "9"
		       escala_i   "1.009900"
		       p1_i       10
		       p2_i       28
		 )
                 (repeat 10
                            (repeat 10
		                       (lorenz "U1_"
			  	   	       (setq p1_i        (+ p1_i  12))
				 	       (setq p2_i        (+ p2_i  10))
					       (setq escala_i    (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	               (setq densidad_i  (+ densidad_i   50))
			 	               (setq color_i     (lor_color color_i))
                                       )
	                    )
		            (setq densidad_i (+ densidad_i 250))
		 )

                 (setq densidad_i 100
		       color_i    "109"
		       escala_i   "1.000009"
		 )
  
                 (repeat 10
                            (repeat 10
		                       (lorenz "U2_"
			  		       (setq p1_i        (- p1_i  12))
					       (setq p2_i        (- p2_i  10))
				               (setq escala_i    (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	               (setq densidad_i  (+ densidad_i   50))
			 	               (setq color_i     (lor_color color_i))
                                       )
	                    )
		            (setq densidad_i (+ densidad_i 250))
		 )
                 (lor:fim)
)

(defun lor_color (#c)  (itoa (+ 1 (if (>= 254 (atoi #c)) (atoi #c) 0))))

;; Equações utilizadas                                                                                     

(defun eq_JLM01 (#x #y #z #a #b #c #e #g)
  
                     (setq
                            x1 (*  (sin #y) #e  (+ #x (*  #g   #a      (- #y #x))))
                            y1 (*  (sin #z) #e  (+ #y (*  #g  (* #x (- (- #b #z) #y)))))
                            z1 (*  (sin #x) #e  (+ #z (*  #g  (- (* #x #y) (* #c #z)))))
                     )
)

(defun eq_lorenz84 (#x #y #z #a #b #d #e #g)
  
                     (setq
		           x1  (* (+ #x #d) (+ (- (* #z #x)) (- (expt #y 2)) (- (expt #z 2)) (* #a #e)))
                           y1  (* (+ #y #d) (+ (-       #y)  (*    #x #y)  (- (* #b #x #z)) #g))
                           z1  (* (+ #z #d) (+ (-       #z)  (* #b #x #y)     (*    #x #z)    ))
                     )
)

		             