#!/usr/bin/gcl -f
;
; Conversion d'une date du calendrier hébraïque vers le calendrier grégorien
; Converting a date from the Hebrew calendar to the Gregorian calendar
;
; Copyright (C) 2019, Jean Forget
;
; Author: Jean Forget
; Maintainer: Jean Forget
; Keywords: Hebrew calendar, Gregorian calendar
;
; This program is free software; you can redistribute it and modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; version 3, or (at your option)
; any later version,
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software Foundation,
; Inc., <https://www.fsf.org/>.
;
; This program relies upon another program by E. M. Reingold and N. Dershowitz,
; "calendrica-3.0.cl" available at
; https://github.com/espinielli/pycalcal
;
; See the license terms of "calendrica-3.0.cl" within the source file.
;
; The new version, published with the 4th edition of "Calendrical Calculations", is available in the "resources" tab of
; https://www.cambridge.org/ch/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167#resources#e2jTvv2OqgtTRWik.97
;

(load "/home/jf/Documents/prog/lisp/calendrica-3.0.cl")

  (let ((year  (parse-integer (cadr   si::*command-args*) ) )
        (month (parse-integer (caddr  si::*command-args*) ) )
        (day1  (parse-integer (cadddr si::*command-args*) ) ))
    (let ((greg (cc3:gregorian-from-fixed  (cc3:fixed-from-hebrew (cc3:hebrew-date year month day1)))))
         (format t "~4D-~2D-~2D" (cc3:standard-year greg) (cc3:standard-month greg) (cc3:standard-day greg))
))


