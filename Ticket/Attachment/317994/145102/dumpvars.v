/*
 * Copyright (c) 2001 Stephan Boettcher <stephan@nevis.columbia.edu>
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */
// $Id: dumpvars.v,v 1.1.2.1 2007/04/06 22:10:11 nodine Exp $
// $Log: dumpvars.v,v $
// Revision 1.1.2.1  2007/04/06 22:10:11  nodine
// Test suite for VerilogParser
//
// Revision 1.1  2001/07/08 02:56:25  sib4
// Test for PR#174
//
//
// Test if $dumpvars() accepts non-hierachical names

module dumptest;

   submod u1(0);
   submod u2(1);

   initial
     begin
        $dumpfile("dumptest.vcd");
        $dumpvars(0, dumptest.u1);
        $dumpvars(0, u2);
        $display("PASSED");
        $finish;
     end

endmodule

module submod (b);
   input b;
   reg a;
   initial a = b;
endmodule
