;;CLIPS 6.31 used

;;;STEFANOS PANAGIOTIS GIANNAKOS 3568
;;;ΣΤΕΦΑΝΟΣ ΠΑΝΑΓΙΩΤΗΣ ΓΙΑΝΝΑΚΟΣ 3568

;;;The logic of the program is to incriminate the chemicals and the stores that contain 
;;;them based on the user's input. The user is asked to provide measurements for the chemicals and the program will 
;;incriminate the chemicals and the stores that contain them based on the user's input. The user is asked to provide measurements.
;;; It uses the ontology that was created on Protege.
;;; The main Idea is to find the chemicals that are dangerous and the stores that contain them by incriminating them based on the user's input 
;;;and decriminating them if the user's input does not match the chemicals' properties and the stores.
;;; Finally it will try to print the suspects.

(defclass chemical
	(is-a USER)
	(role concrete)
	(multislot colour
		(type SYMBOL)
		(allowed-values clear red white)
		(default clear)
		(create-accessor read-write))
	(multislot specific_gravity
		(type SYMBOL)
		(allowed-values equal_to_1 above_1 below_1)
		(default equal_to_1)
		(create-accessor read-write))
	(multislot radioactivity
		(type SYMBOL)
		(allowed-values no yes)
		(default no)
		(create-accessor read-write))
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(create-accessor read-write))
	(multislot solubility
		(type SYMBOL)
		(allowed-values soluble insoluble)
		(default soluble)
		(create-accessor read-write))
	(multislot smell
		(type SYMBOL)
		(allowed-values none vinegar choking)
		(default none)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values asphyxiation burns_skin explosive highly_toxic_PCBs)
		(create-accessor read-write))
	(multislot spectrometry
		(type SYMBOL)
		(allowed-values none sulphur carbon sodium metal)
		(default none)
		(create-accessor read-write)))

(defclass acid
	(is-a chemical)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 6)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 0)
		(create-accessor read-write)))

(defclass strong_acid
	(is-a acid)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 3)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values asphyxiation burns_skin explosive highly_toxic_PCBs)
		(default burns_skin)
		(create-accessor read-write)))

(defclass weak_acid
	(is-a acid)
	(role concrete)
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 3)
		(create-accessor read-write)))

(defclass base
	(is-a chemical)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 14)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 8)
		(create-accessor read-write)))

(defclass strong_base
	(is-a base)
	(role concrete)
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 11)
		(create-accessor read-write))
	(multislot hazards
		(type SYMBOL)
		(allowed-values asphyxiation burns_skin explosive highly_toxic_PCBs)
		(default burns_skin)
		(create-accessor read-write)))

(defclass weak_base
	(is-a base)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 11)
		(create-accessor read-write)))

(defclass oil
	(is-a chemical)
	(role concrete)
	(multislot pH-high
		(type INTEGER)
		(range 0 14)
		(default 8)
		(create-accessor read-write))
	(multislot pH-low
		(type INTEGER)
		(range 0 14)
		(default 6)
		(create-accessor read-write))
	(multislot solubility
		(type SYMBOL)
		(allowed-values soluble insoluble)
		(default insoluble)
		(create-accessor read-write))
	(multislot spectrometry
		(type SYMBOL)
		(allowed-values none sulphur carbon sodium metal)
		(default carbon)
		(create-accessor read-write)))

(defclass node
	(is-a USER)
	(role concrete)
	(multislot downstream
		(type INSTANCE)
		(allowed-classes node)
		(create-accessor read-write)))

(defclass store
	(is-a node)
	(role concrete)
	(multislot contents
		(type INSTANCE)
		(allowed-classes chemical)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write)))

(defclass manhole
	(is-a node)
	(role concrete))

;INSTANCES

(definstances chemical-facility-instances

([acetic_acid] of  weak_acid

	(smell vinegar))

([aluminium_hydroxide] of  weak_base

	(colour white)
	(specific_gravity above_1)
	(spectrometry metal))

([carbonic_acid] of  weak_acid

	(spectrometry carbon))

([chromogen_23] of  weak_base

	(colour red)
	(specific_gravity below_1))

([hydrochloric_acid] of  strong_acid

	(hazards asphyxiation burns_skin)
	(smell choking))

([manhole_1] of  manhole

	(downstream [manhole_9]))

([manhole_10] of  manhole

	(downstream [manhole_12]))

([manhole_11] of  manhole

	(downstream [manhole_13]))

([manhole_12] of  manhole

	(downstream [monitoring_station]))

([manhole_13] of  manhole

	(downstream [monitoring_station]))

([manhole_2] of  manhole

	(downstream [manhole_9]))

([manhole_3] of  manhole

	(downstream [manhole_9]))

([manhole_4] of  manhole

	(downstream [manhole_10]))

([manhole_5] of  manhole

	(downstream [manhole_10]))

([manhole_6] of  manhole

	(downstream [manhole_11]))

([manhole_7] of  manhole

	(downstream [manhole_11]))

([manhole_8] of  manhole

	(downstream [manhole_13]))

([manhole_9] of  manhole

	(downstream [manhole_12]))

([monitoring_station] of  node
)

([petrol] of  oil

	(hazards explosive)
	(specific_gravity below_1))

([rubidium_hydroxide] of  weak_base

	(radioactivity yes)
	(specific_gravity above_1)
	(spectrometry metal))

([sodium_hydroxide] of  strong_base

	(spectrometry sodium))

([store_1] of  store

	(contents
		[sulphuric_acid]
		[petrol])
	(downstream [manhole_1]))

([store_2] of  store

	(contents
		[hydrochloric_acid]
		[acetic_acid])
	(downstream [manhole_2]))

([store_3] of  store

	(contents
		[rubidium_hydroxide]
		[transformer_oil])
	(downstream [manhole_3]))

([store_4] of  store

	(contents
		[carbonic_acid]
		[acetic_acid]
		[petrol])
	(downstream [manhole_4]))

([store_5] of  store

	(contents
		[chromogen_23]
		[sulphuric_acid]
		[petrol])
	(downstream [manhole_5]))

([store_6] of  store

	(contents
		[aluminium_hydroxide]
		[transformer_oil]
		[carbonic_acid])
	(downstream [manhole_6]))

([store_7] of  store

	(contents
		[hydrochloric_acid]
		[sulphuric_acid])
	(downstream [manhole_7]))

([store_8] of  store

	(contents
		[acetic_acid]
		[carbonic_acid]
		[sodium_hydroxide])
	(downstream [manhole_8]))

([sulphuric_acid] of  strong_acid

	(spectrometry sulphur))

([transformer_oil] of  oil

	(hazards highly_toxic_PCBs))
)


;RULES START HERE

(defrule initial-question
	?x <- (initial-fact)
  =>
	(retract ?x)
	(set-strategy simplicity)
	(printout t "Gia poies metriseis tha dothoyn times? (pH solubility spectrometry colour smell specific_gravity radioactivity)")
	(bind $?answer (explode$ (readline)))
	(assert (measurements $?answer))

)

;based o the choise the user picked, the program will ask for the specific value of the measurement
(defrule follow-up-questions
    	?x<-(measurements $? ?answer $?)
=>
	(assert (goal-get-measurement ?answer ))
)


;the answers are being stored in the fact list

(defrule get-measuremenet-pH
     ?x       <- (goal-get-measurement pH)
=>
     (retract ?x)
     (printout t "Poio einai to pH ths molinsis? (0 - 14) ")
     (bind ?ph (explode$ (readline)))
     (assert (answer pH ?ph))
     (assert (step-to initializing))
)

(defrule get-measuremenet-sol
     ?x       <- (goal-get-measurement solubility)
=>
     (retract ?x)
     (printout t "Poia einai h dialytothta ths molinsis? (soluble, insoluble) ")
     (bind ?solubility (explode$ (readline)))
     (assert (answer solubility ?solubility))
     (assert (step-to initializing))
)

(defrule get-measuremenet-spectro
     ?x       <- (goal-get-measurement spectrometry)
=>
     (retract ?x)
     (printout t "Ti deixnei h fasmatoskopia gia th molinsh? (none, Sulphur, Carbon, Sodium, Metal)")
     (bind ?spec (explode$ (readline)))
     (assert (answer spectrometry ?spec))
     (assert (step-to initializing))
)

(defrule get-measuremenet-colour
     ?x       <- (goal-get-measurement colour)
=>
     (retract ?x)
     (printout t "Poio einai to xrwma ths molinshs? (red, white, none) ")
     (bind ?colour (explode$ (readline)))
     (assert (answer colour ?colour))
     (assert (step-to initializing))
)


(defrule get-measuremenet-smell
     ?x       <- (goal-get-measurement smell)
=>
     (retract ?x)
     (printout t "Ti myrwdia exei? (choking, vinegar, none) ")
     (bind ?smell (explode$ (readline)))
     (assert (answer smell ?smell))
     (assert (step-to initializing))
)


(defrule get-measuremenet-sp_gr
     ?x       <- (goal-get-measurement specific_gravity)
=>
     (retract ?x)
     (printout t "Poio einai to eidiko baros ths molinsis? (0.9 - 1.1) ")
     (bind ?sp_gr (explode$ (readline)))
     (assert (answer specific_gravity ?sp_gr))
     (assert (step-to initializing))
)

(defrule get-measuremenet-rad
     ?x       <- (goal-get-measurement radioactivity)
=>
     (retract ?x)
     (printout t "Einai radienergos h molinsh? (yes, no)")
     (bind ?rad(explode$ (readline)))
     (assert (answer radioactivity ?rad))
     (assert (step-to initializing))
)



; Starting the incrimination process of the chemicals

(defrule start-incrimination
    ?x<- (step-to initializing)
=>
   (retract ?x)
   (set-strategy complexity)
   (assert(goal incriminate-ph))

)

;;; If we find any suspect behaviour then we will incriminate the chemical compound and remove it from the facts list.
;;; After that any chemical compound that was not will be decriminated and removed from the facts list.
;;; After every suspision is checked, the program will move on to the next chemical comp.
;;; After it finishes it will move on to the stores.
;;; At the end it will print the chemical compounds and the stores that are suspected.

(defrule init-ph ;suspecting the ph and getting the app. values
     (goal incriminate-ph)
     (answer pH ?value)
     (object (is-a chemical)
             (name ?c)
             (pH ?value2)
             (suspect no))
     (test (eq ?value ?value2))
 =>
    (modify-instance ?c
            (suspect yes))
)

(defrule init-ph-next ;moving to the next supsect
    ?x1<-(goal incriminate-ph)
=>
    (retract ?x1)
    (assert (goal init-sus-sol))
)


;same process for every compound


(defrule init-solub
     (goal init-sus-sol)
     (answer solubility ?value)
     (object (is-a chemical)
             (name ?c)
             (solubility ?value2)
             (suspect no))
     (test(eq ?value ?value2))
 =>
     (modify-instance ?c
             (suspect yes))
)

(defrule init-solub-next
    ?x1<-(goal init-sus-sol)
 => 
    (retract ?x1)
    (assert (goal init-sus-spec))
)


(defrule init-spec
     (goal init-sus-spec)
     (answer spectrometry ?value)
     (object (is-a chemical)
             (name ?c)
             (spectroscopy ?value2)
             (suspect no))
             (test(eq ?value ?value2))
 => 

     (modify-instance ?c
             (suspect yes))
)

(defrule init-spec-next
    ?x1<-(goal init-sus-spec)
 => 
    (retract ?x1)
    (assert (goal init-sus-colour))
)

(defrule init-colour
     (goal init-sus-colour)
     (answer colour ?value)
     (object (is-a chemical)
             (name ?c)
             (colour ?value2)
             (suspect no))
     (test(eq ?value ?value2))
 =>
     (modify-instance ?c
             (suspect yes))
)

(defrule init-colour-next
    ?x1<-(goal init-sus-colour)
 => 
    (retract ?x1)
    (assert (goal init-sus-smell))
)

(defrule init-smell
     (goal init-sus-smell)
     (answer smell ?value)
     (object (is-a chemical)
             (name ?c)
             (smell ?value2)
             (suspect no))
     (test(eq ?value ?value2))
 =>
     (modify-instance ?c
             (suspect yes))
)

(defrule init-smell-next
    ?x1<-(goal init-sus-smell)
   =>
    (retract ?x1)
    (assert (goal init-sus-SG))
)


(defrule init-SG
     (goal init-sus-SG)
     (answer specific_gravity ?value)
     (object (is-a chemical)
             (name ?c) 
             (specific+gravity ?value2)
             (suspect no))
     (test(eq ?value ?value2))
 =>
     (modify-instance ?c
             (suspect yes))
)



(defrule init-SG-next
    ?x1<-(goal init-sus-SG)
   =>
    (retract ?x1)
    (assert (goal init-sus-rad))
)


(defrule init-rad
     (goal init-sus-rad)
     (answer radioactivity ?value)
     (object (is-a chemical)
             (name ?c)
             (radioactivity ?value2)
             (suspect no))
     (test(eq ?value ?value2))
 =>
     (modify-instance ?c
             (suspect yes))
)

(defrule init-rad-next
    ?x1<-(goal init-sus-rad)
   =>
    (retract ?x1)
    (assert (goal init-dec-pH))
)



(defrule init-decr-pH
     (goal init-dec-pH)
     (answer pH ?value)
     (object (is-a chemical)
             (name ?c)
             (pH ?value2)
             (suspect yes))
     (test(neq ?value ?value2))              
  
=>

     (modify-instance ?c
            (suspect no))
)


(defrule init-dec-pH-next
    ?x1<-(goal init-dec-pH)
   =>
    (retract ?x1)
    (assert (goal init-dec-sol))
)



(defrule init-decr-sol
     (goal init-dec-sol)
     (answer solubility ?value)
     (object (is-a chemical)
             (name ?c)
             (solubility ?value2)
             (suspect yes))
     (test(neq ?value ?value2))
=>

     (modify-instance ?c
             (suspect no))
)

(defrule init-dec-sol-next
    ?x1<-(goal init-dec-sol)
   =>
    (retract ?x1)
    (assert (goal init-dec-spec))
)

(defrule init-decr-spec
     (goal init-dec-spec)
     (answer spectometry ?value)
     (object (is-a chemical)
             (name ?c)
             (spectroscopy ?value2)
             (suspect yes))
     (test(neq ?value ?value2))
=>
     (modify-instance ?c
             (suspect no))
)

(defrule init-dec-spec-next
    ?x1<-(goal init-dec-spec)
   =>
    (retract ?x1)
    (assert (goal init-dec-col))
)

(defrule init-decr-col
     (goal init-dec-colour)
     (answer colour ?value)
     (object (is-a chemical)
             (name ?c)
             (colour ?value2)
             (suspect yes))
     (test(neq ?value ?value2))
=>
     (modify-instance ?c
             (suspect no))
)

(defrule init-dec-col-next
    ?x1<-(goal init-dec-col)
   =>
    (retract ?x1)
    (assert (goal init-dec-smell))
)

(defrule init-decr-smell
     (goal init-dec-smell)
     (answer smell ?value)
     (object (is-a chemical)
             (name ?c)
             (smell ?value2)
             (suspect yes))
     (test(neq ?value ?value2))
=>
     (modify-instance ?c
             (suspect no))
)

(defrule init-dec-smell-next
    ?x1<-(goal init-dec-smell)
   =>
    (retract ?x1)
    (assert (goal init-dec-SG))
)

(defrule init-decr-SG
     (goal init-dec-SG)
     (answer specific_gravity ?value)
     (object (is-a chemical)
             (name ?c)
             (specific+gravity ?value2)
             (suspect yes))
     (test(neq ?value ?value2))
=>
     (modify-instance ?c
             (suspect no))
)

(defrule init-dec-SG-next
    ?x1<-(goal init-dec-SG)
   =>
    (retract ?x1)
    (assert (goal init-dec-rad))
)

(defrule init-decr-rad
     (goal init-dec-rad)
     (answer radioactivity ?value)
     (object (is-a chemical)
             (name ?c)
             (radioactivity ?value2)
             (suspect yes))
     (test(neq ?value ?value2))
=>   
     (modify-instance ?c
             (suspect no))
)



(defrule init-dec-rad-next
    ?x1<-(goal init-dec-rad)
   =>
    (retract ?x1)
    (assert (move on))
)



;Similar incrimination process for the Stores

(defrule sus-store 
       (move on)
       (object (is-a chemical)
               (suspect yes)
               (name ?nam))
       (object (is-a Store)
               (name ?c)
               (substance $? ?nam $?)
               (suspect no))
       =>
       (modify-instance ?c 
               (suspect yes))
)



(defrule sus-store-next
    ?x1<-(move on)
 =>
    (retract ?x1)
    (assert (goal finish-sus))
)



(defrule finished-sus
      ?x1<-(goal finish-sus)
      (object (is-a store)
              (suspect yes)
              (name ?c))
      (object (is-a store)
              (suspect yes)
              (name ?c2&~?c))
=>
     (retract ?x1)
)


 
(defrule finish-print
     ?x1<-(goal finish-sus)
   =>
     (retract ?x1)
     (assert (goal print))
)


;Final Print of the Suspects (Store, chemical)

(defrule results
      (goal print)
      (object (is-a store)
              (name ?c)
              (substance $? ?s $?)              
              (suspect yes))
      (object (is-a chemical)
              (name ?s)
              (chname ?s1)
              (suspect yes)
             (explosive ?exp)
             (corrosive ?cor)
              
              )
=>
      (modify-instance ?s
              (suspect no))
      (printout t "H apothiki  " ?c "  exei molynsh apo to xhmiko " ?s1 crlf)
      (if(eq ?exp TRUE)
        then (printout t "Ekriktiko! " crlf ))
      (if(eq ?cor TRUE)
        then (printout t "Egkavmata! " crlf ))
            
)