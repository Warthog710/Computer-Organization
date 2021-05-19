// Quinn Roemer
// decoder1to2.v, 1-to-2 decoder, gate synthesis
// compile: ~changw/ivl/bin/iverilog decoder1to2.v
// run: ./a.out

module encoderMod(i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2);
    input i0, i1, i2, i3, i4, i5, i6, i7;
    output o0, o1, o2;

    or(o0, i7, i5, i3, i1);
    or(o1, i7, i6, i3, i2);
    or(o2, i7, i6, i5, i4);
endmodule

module testMod;
    reg i0, i1, i2, i3, i4, i5, i6, i7;
    wire o0, o1, o2;

    encoderMod the_encoder(i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2);

    initial begin
      $display("Time  i0  i1  i2  i3  i4  i5  i6  i7   o2  o1  o0");
      $display("----  ------------------------------   ----------");
      $monitor("   %0d   %b   %b   %b   %b   %b   %b   %b   %b   %b   %b   %b",$time, i0, i1, i2, i3, i4, i5, i6, i7, o2, o1, o0);
    end

    initial begin
      i0 = 1; i1 = 0; i2 = 0; i3 = 0; i4 = 0; i5 = 0; i6 = 0; i7 = 0;
      #1;
      i0 = 0; i1 = 1; i2 = 0; i3 = 0; i4 = 0; i5 = 0; i6 = 0; i7 = 0;
      #1;
      i0 = 0; i1 = 0; i2 = 1; i3 = 0; i4 = 0; i5 = 0; i6 = 0; i7 = 0;
      #1;
      i0 = 0; i1 = 0; i2 = 0; i3 = 1; i4 = 0; i5 = 0; i6 = 0; i7 = 0;
      #1;
      i0 = 0; i1 = 0; i2 = 0; i3 = 0; i4 = 1; i5 = 0; i6 = 0; i7 = 0;
      #1;
      i0 = 0; i1 = 0; i2 = 0; i3 = 0; i4 = 0; i5 = 1; i6 = 0; i7 = 0;
      #1;
      i0 = 0; i1 = 0; i2 = 0; i3 = 0; i4 = 0; i5 = 0; i6 = 1; i7 = 0;
      #1;
      i0 = 0; i1 = 0; i2 = 0; i3 = 0; i4 = 0; i5 = 0; i6 = 0; i7 = 1;      
    end
endmodule