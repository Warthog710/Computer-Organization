//DQ4.v -- array of 4 DQ F/F
//Quinn Roemer
//04.29.2020

module SR(s, r, o);
    input s, r;
    output o;
    wire sOut, rOut;

    nor(sOut, o, s);
    nor(rOut, sOut, r);
    assign #1 o = rOut;
endmodule

module DQ(d, en, q);
    input d, en;
    output q;
    wire notD, and1, and2;

    not(notD, d);
    and(and1, d, en);
    and(and2, notD, en);
    SR mySR(and1, and2, q);
endmodule

module DQ4(d, en, q);
    input [0:3] d;
    input en;
    output [0:3] q;

    DQ myDQs [0:3] (d, en, q);
endmodule

module TestMod;
   reg [0:3] D;
   reg en;
   wire [0:3] Q;

   DQ4 myDQ4(D, en, Q);

   initial begin
      $monitor("%4d  %b  %b  %b", $time, D, en, Q);
      $display("Time  D...  en Q...");
      $display("----  ----  -  ----");
   end

   always begin
      #1; D = 4'b0000; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0001; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0010; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0011; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0100; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0101; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0110; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b0111; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1000; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1001; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1010; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1011; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1100; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1101; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1110; #1; en = 1; #1; en = 0; #1;
      #1; D = 4'b1111; #1; en = 1; #1; en = 0; #1;
   end
   
   initial #69 $finish;
endmodule