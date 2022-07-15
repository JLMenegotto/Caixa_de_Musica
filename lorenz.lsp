;;;http://local.wasp.uwa.edu.au/~pbourke/fractals/lorenz/                                     
;;;// N = quantidade de iterações                                                             
;;;// h, a, b, c: parâmetros iniciais                                                         
;;;// x0, y0, z0: ponto inicial                                                               
;;;// rad = raio da esfera desenhada                                                          
;; 0.001099, 10, 28, 8/3, 0.0001, 0.0001, 0.0001, 350000, 0.04                                

(defun lorenz (#pre #a #b #e #n #c / h a b c x0 y0 z0 N rad)

               (ambienteX)
  
               (setvar "cmdecho" 0)
  
               (setq  h      0.001099
            	      a      #a
            	      b      #b
            	      c      (/ 8.0  3.0)  
            	      x0     1.0
            	      y0     1.0
            	      z0     1.0
            	      N      #n
		      pf     0
            	      rad    0.01
		      i      1
		      lxyz  '()
		      lxyz   (cons (list x0 y0 z0) lxyz)
     		      esc    (atof #e)
		      nomlay (strcat #pre (itoa #a) (itoa #b) "_" #e "_" (itoa #n)) 
                )

                (command "._layer" "_M" nomlay "_c" #c nomlay "")
			 
                (if (not limite1)
                    (setq limite1 (getpoint "\nMarque ponto extremo inferior esquerdo") 
                          limite2 (getpoint "\nMarque ponto extremo superior direito")
	            )
                )
			 
                (while (< i N)
		             (setq
			           x1   (* esc (+ x0 (* h  a (- y0 x0))))
                                   y1   (* esc (+ y0 (* h (* x0 (- (- b z0) y0)))))
		                   z1   (* esc (+ z0 (* h (- (* x0 y0) (* c z0)))))
                                   x0   x1
                                   y0   y1
                                   z0   z1
			           pc   (list x0 y0 z0)
		             )
		             (if (ponto_in  pc  limite1 limite2)
                                 (setq lxyz (cons pc lxyz))
                             )
      	                (setq i (1+ i))
 	        )
			 
                (mapcar 'Cx:ponto lxyz)
                (setvar "cmdecho" 1)
)

(defun Cx:pontoX  (#pto #rad #l1 #l2)
                                 (if (ponto_in  #pto  #l1 #l2)
                                     (vla-addpoint *spac*  (vlax-3d-point  #pto))
				     (setq pf (1+ pf))
                                 )
)

(defun Cx:ponto   (#pto)
                                      (command "._Point"  #pto)
)

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


(defun ponto_in (pt lim1 lim2)
                              (cond
			           ((and (<= (car   lim1) (car   pt) (car   lim2))
				         (<= (cadr  lim1) (cadr  pt) (cadr  lim2))
				         (<= (caddr lim1) (caddr pt) (caddr lim2))
                                    )                                              t)
			           (t                                            nil)
		              )
) 

(defun c:lor1 ()
                 (setq limite1  nil)
                 (command "._vpoint" "_r" 300  30)
                 (setq densidad_i 100
		       color_i    "9"
		       escala_i   "1.009900"
		       p1_i  10
		       p2_i  28
		 )
                 (repeat 5
                         (repeat 5
		                   (lorenz "U1_"
					    (setq p1_i     (+ 12 p1_i))
					    (setq p2_i     (+ 10 p2_i))
					    (setq escala_i (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	            densidad_i
			 	            (setq color_i  (itoa (+ 1 (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )
)


(defun c:lor6 ()
                 (setq limite1  nil)
                 (command "._vpoint" "_r" 300  30)
                 (setq densidad_i   100
		       color_i      "9"
		       escala_i     "1.009900"
		       p1_i         10
		       p2_i         28
		 )
  
                 (repeat 5
                         (repeat 5
		                   (lorenz "U1_"
					    (setq p1_i     (+ 12 p1_i))
					    (setq p2_i     (+ 10 p2_i))
					    (setq escala_i (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	            densidad_i
			 	            (setq color_i  (itoa (+ 1 (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )

                 (setq densidad_i 100
		       color_i    "109"
		       escala_i   "1.000009"
                       p1_i       10
	               p2_i       28
		 )
  
                 (repeat 5
                         (repeat 5
		                   (lorenz "U2_"
			                   p1_i  
		                           p2_i  
				           (setq escala_i (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	           densidad_i
			 	           (setq color_i  (itoa (+ 1 (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )
)

(defun c:lor7 ()
                 (setq limite1  nil)
                 (command "._vpoint" "_r" 300 30)
                 (setq densidad_i 100
		       color_i    "40"
		       escala_i   "1.009900"
		 )
                 (repeat 10
                         (repeat 10
		                   (lorenz "U1_"
					    10 28 (setq escala_i (rtos (+ (atof escala_i) 0.001025) 2 6))
			    	                  densidad_i
			 	                  (setq color_i  (itoa (+ 1 (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )

                 (setq densidad_i 100
		       color_i    "150"
		       escala_i   "1.000009"
		 )
  
                 (repeat 10
                         (repeat 10
		                   (lorenz "U2_"
				           10 28 (setq escala_i (rtos (- (atof escala_i) 0.001025) 2 6))
			    	                 densidad_i
			 	                 (setq color_i  (itoa (+ 1 (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )
)

(defun c:lor8 ()
                 (setq limite1  nil)
                 (command "._vpoint" "_r" 300 30)
  
                 (setq densidad_i 100
		       color_i    "9"
		       escala_i   "1.009900"
		       p1_i  10
		       p2_i  28
		 )
                 (repeat 10
                         (repeat 10
		                   (lorenz "U1_"
					    (setq p1_i       (+ p1_i  12))
					    (setq p2_i       (+ p2_i  10))
					    (setq escala_i   (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	            (setq densidad_i (+ densidad_i 50))
			 	            (setq color_i    (itoa (+ 1 (atoi color_i))))
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
					    (setq p1_i       (- p1_i  12))
					    (setq p2_i       (- p2_i  10))
				            (setq escala_i   (rtos (+ 0.000025 (atof escala_i)) 2 6))
			    	            (setq densidad_i (+ densidad_i 50))
			 	            (setq color_i    (itoa (1+ (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )
)

(defun c:lor9 ()
                 (setq limite1  nil)
                 (command "._vpoint" "_r" 300 30)
  
                 (setq densidad_i 500
		       color_i    "9"
		       escala_i   "1.000005"
		       p1_i  10
		       p2_i  28
		 )
                 (repeat 10
                         (repeat 10
		                   (lorenz "U1_"
					    (setq p1_i       (+ p1_i  12))
					    (setq p2_i       (+ p2_i  10))
					    (setq escala_i   (rtos (+ 0.000001 (atof escala_i)) 2 6))
			    	            (setq densidad_i (+ densidad_i 50))
			 	            (setq color_i    (itoa (+ 1 (atoi color_i))))
                                   )
	                 )
		         (setq densidad_i (+ densidad_i 250))
		 )
)

(defun c:lor10 ()
                 (setq limite1  nil)
                 (command "._vpoint" "_r" 300 30)
  
                 (setq densidad_i 250
		       color_i    "9"
		       escala_i   "1.000005"
		       p1_i  10
		       p2_i  28
		 )
                 (repeat 10
                         (repeat 500
		                   (lorenz "U1_"
					    (setq p1_i       (+ p1_i  12))
					    (setq p2_i       (+ p2_i  10))
					    (setq escala_i   (rtos (+ 0.000001 (atof escala_i)) 2 6))
			    	            (setq densidad_i (+ densidad_i 2))
			 	            (setq color_i    (lor_color color_i))
                                   )
	                 )
		         (setq densidad_i 250)
		         (setq color_i    "9")
		 )
)

(defun lor_color (#c)
                   (cond
		         ((> 255 (atoi #c))  (itoa (1+ (atoi #c))))
			 (t                  "9")
	           )
)

(defun c:foto (#n)
  
                         (c:rpref "DEST"          "FILE")
                         (c:rpref "STYPE"  "ARAY")
                         (c:rpref "TOGGLE" "SMOOTH" "ON")
                         (c:rpref "TOGGLE" "SHADOW" "ON")
  
                         (c:rfileopt "BMP"  640  480  1.0  "C8")
  
                         (c:render   (strcat "c:/foto_" (itoa #n))  "0,0"   "640,480")   
)