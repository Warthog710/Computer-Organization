// Quinn Roemer
// decoder1to2.v, 1-to-2 decoder, gate synthesis
// compile: ~changw/ivl/bin/iverilog decoder1to2.v
// run: ./a.out

module decoderMod(i2, i1, i0, o0, o1, o2, o3, o4, o5, o6, o7);
    input i2, i1, i0;
    output o0, o1, o2, o3, o4, o5, o6, o7;

    wire not_i2, not_i1, not_i0;

    not(not_i2, i2);
    not(not_i1, i1);
    not(not_i0, i0);

    and(o0, not_i2, not_i1, not_i0);
    and(o1, not_i2, not_i1, i0);
    and(o2, not_i2, i1, not_i0);
    and(o3, not_i2, i1, i0);
    and(o4, i2, not_i1, not_i0);
    and(o5, i2, not_i1, i0);
    and(o6, i2, i1, not_i0);
    and(o7, i2, i1, i0);
endmodule

module testMod;
    reg i2, i1, i0;
    wire o0, o1, o2, o3, o4, o5, o6, o7;

    decoderMod the_decoder(i2, i1, i0, o0, o1, o2, o3, o4, o5, o6, o7);

    initial begin
      $display("Time  i2  i1  i0   o0  o1  o2  o3  o4  o5  o6  o7");
      $display("----  ----------   ------------------------------");
      $monitor("   %0d   %b   %b   %b   %b   %b   %b   %b   %b   %b   %b   %b",$time, i2, i1, i0, o0, o1, o2, o3, o4, o5, o6, o7);
    end

    initial begin
      i2 = 0; i1 = 0; i0 = 0;
      #1;
      i2 = 0; i1 = 0; i0 = 1;
      #1;
      i2 = 0; i1 = 1; i0 = 0;
      #1;
      i2 = 0; i1 = 1; i0 = 1;
      #1;
      i2 = 1; i1 = 0; i0 = 0;
      #1;
      i2 = 1; i1 = 0; i0 = 1;
      #1;
      i2 = 1; i1 = 1; i0 = 0;
      #1;
      i2 = 1; i1 = 1; i0 = 1;
    end
endmodule