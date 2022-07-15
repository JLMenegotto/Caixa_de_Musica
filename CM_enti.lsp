(defun Cx:MarcaNotas (#d #n #lay #v)

      (cond ((= #d "1")
             (Cx:error "enti_01")
             (mapcar '(lambda (n)
                            (if n
                                  (Cx:caixinha n
                                               #lay
                                               (+ 20 (atoi #v))
                                               (Cx:dim_caixa #v)
                                  )
                            )
                      )
                     #n
             )
            )
            (T (princ "."))
      )
)



(defun Cx:dim_caixa (#v) (* (1+ (atoi #v)) *raio_esfera*))

;;; Cria um círculo                                                                        

(defun Cx:circulo (#lay #pto #rad #col)
      (entmake
            (list (cons 0 "CIRCLE")
                  (cons 100 "AcDbEntity")
                  (cons 100 "AcDbCircle")
                  (cons 8 #lay)
                  (cons 10 #pto)
                  (cons 40 #rad)
                  (cons 62
                        (cond (#col)
                              (0)
                        )
                  )
            )
      )
)

;;; CODIGO 72                                                                              
;;;0 = Left                                                                                
;;;1 = Center                                                                              
;;;2 = Right                                                                               
;;;3 = Aligned                                                                             
;;;4 = Middle                                                                              
;;;5 = Fit                                                                                 
;;;Cria um texto                                                                           

(defun Cx:texto (#lay #pto #alt #tex #jus)
      (entmake
            (list (cons 0 "TEXT")
                  (cons 100 "AcDbEntity")
                  (cons 100 "AcDbText")
                  (cons 8 #lay)
                  (cons 10 #pto)
                  (cons 11 #pto)
                  (cons 40 #alt)
                  (cons 1 #tex)
                  (cons 7 (getvar "TEXTSTYLE"))
                  (cons 72 #jus)
            )
      )
)

;;; Cria sólido esférico                                                                   

(defun Cx:esfera (#pto #lay #rad)
      (Cx:eco_of)
      (command "._sphere" #pto #rad) (Cx:coloca_no_layer #lay)
      (Cx:eco_on)
)

;;; Cria sólido box                                                                        
(defun Cx:caixinha (#pto #lay #co #rad)
      (Cx:eco_of)
      (command "._box" "_ce" #pto "_c" (* 2 #rad)) (Cx:coloca_no_layer #lay)
      (command "._chprop" (entlast) "" "_co" #co "")
      (Cx:eco_on)
)

(defun Cx:linha (#lay #p1 #p2)
      (entmake
            (list (cons 0 "LINE")
                  (cons 100 "AcDbEntity")
                  (cons 100 "AcDbLine")
                  (cons 8 #lay)
                  (cons 10 #p1)
                  (cons 11 #p2)
            )
      )
)

(defun Cx:poly_3d (#lay #a #b #c)
      (entmake (list (cons 100 "AcDbEntity")
                     (cons 0 "POLYLINE")
                     (cons 8 #lay)
                     (cons 70 8)
               )
      )
      (entmake (list (cons 100 "AcDbEntity")
                     (cons 100 "AcDbVertex")
                     (cons 0 "VERTEX")
                     (cons 70 32)
                     (cons 10 #a)
               )
      )
      (entmake (list (cons 100 "AcDbEntity")
                     (cons 100 "AcDbVertex")
                     (cons 0 "VERTEX")
                     (cons 70 32)
                     (cons 10 #b)
               )
      )
      (entmake (list (cons 100 "AcDbEntity")
                     (cons 100 "AcDbVertex")
                     (cons 0 "VERTEX")
                     (cons 70 32)
                     (cons 10 #c)
               )
      )
      (entmake (list (cons 100 "AcDbEntity")
                     (cons 0 "SEQEND")
               )
      )
)

(defun Cx:eco_of () (setvar "cmdecho" 0))
(defun Cx:eco_on () (setvar "cmdecho" 1))

