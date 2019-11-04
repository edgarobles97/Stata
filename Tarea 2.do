cd "C:\Users\edari\Desktop\Séptimo\Tarea 2\Tarea 2\data"


///Pregunta 2.///

use "comportamiento_wide.dta", clear
///Tidying data///
reshape long anti self pov, i(id) j(year)

describe
///MCO///
reg anti self pov

///Define variables Panel (ID, año)
xtset id year
xtdescribe

///Fixed Effects///
xtreg anti self pov, fe

///Random Effects///
xtreg anti self pov, re


///Modelo con varaibels Gender y Hispanic bajo Random Effects///
xtreg anti self pov gender hispanic, re

///Hausman Test///
xtreg anti self pov, fe
estimates store FE
xtreg anti self pov, re
estimates store RE


hausman FE RE



///Pregunta 3.///

use "individuos_empleo_wide.dta", clear
describe

///Tidying data///
reshape long choice wage educ expwc expbc expser manuf black enroll employ exper status, i(id) j(t)

///Define variables Panel (ID, tiempo)
xtset id t
xtdescribe

/// variación within, between de la variable black///
xtsum black

/// Equivakencia entrte MCO con dummy de individuo y un modelo FE///
reg wage exper i.id
xtreg wage exper, fe

///¿Hay variación de black bajo un modelo de efectos fijos?
xtreg wage exper black, fe


///Comporbar que MCO con las variables demeaned es equivalente al modelo de efectos fijos///
bysort id (t) : center wage exper black 


///Comprobar que MCO en primeras diferencias es equivalente al modelo de efectos fijos///





///Pregunta 4.///

use "tarea_examen.dta", clear
describe

/// Define variables panel (ID escuela y ID estudiante)
xtset escuela_id estudiante_id
xtdescribe


///Regresión estándar, errores no ajustados.///
reg examen tiempo

///Regresión con errores robustos///
reg examen tiempo, robust

///Regresión con variable indicadora de escuela///
reg examen tiempo i.escuela_id

///Regresión con errores agrupados por escuela///
reg examen tiempo, vce(cluster escuela_id)

///Regresión con errores ajustados por escuela y con variable dummy de escuela///
reg examen tiempo i.escuela_id, vce(cluster escuela_id)


///Pregunta 5.///

use "capital_trabajo.dta", clear
