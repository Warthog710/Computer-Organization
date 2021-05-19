/*
Quinn Lawrence Roemer
SID: 301323594
March 4 2020
*/

module decoderMod(s, o);
    input [2:0] s;
    output [0:7] o;
    wire [2:0] inv_s;

    not(inv_s[2], s[2]);
    not(inv_s[1], s[1]);
    not(inv_s[0], s[0]);

    and(o[0], inv_s[2], inv_s[1], inv_s[0]);
    and(o[1], inv_s[2], inv_s[1], s[0]);
    and(o[2], inv_s[2], s[1], inv_s[0]);
    and(o[3], inv_s[2], s[1], s[0]);
    and(o[4], s[2], inv_s[1], inv_s[0]);
    and(o[5], s[2], inv_s[1], s[0]);
    and(o[6], s[2], s[1], inv_s[0]);
    and(o[7], s[2], s[1], s[0]);
endmodule

module muxMod(s, d, o);
    input[2:0] s;
    input[0:7] d;
    output o;

    wire[0:7] s_decoded, and_out;

    decoderMod my_decoder(s, s_decoded);

    and(and_out[0], d[0], s_decoded[0]);
    and(and_out[1], d[1], s_decoded[1]);
    and(and_out[2], d[2], s_decoded[2]);
    and(and_out[3], d[3], s_decoded[3]);
    and(and_out[4], d[4], s_decoded[4]);
    and(and_out[5], d[5], s_decoded[5]);
    and(and_out[6], d[6], s_decoded[6]);
    and(and_out[7], d[7], s_decoded[7]);

    or(o, and_out[0], and_out[1], and_out[2], and_out[3], and_out[4], and_out[5], and_out[6], and_out[7]);
endmodule


module testMod;
    reg[2:0] s;
    reg[0:7] d;
    wire o;

    integer select, index;

    muxMod myMux(s, d, o);

    initial begin
        $display("Time  s..  d.......  o");
        $display("----  ---  --------  -");
        $monitor("%4d  %b  %b  %b", $time, s, d, o);
    end

    initial begin
	    for(select = 0; select < 8; select = select + 1) 
        begin
    	    for(index = 0; index < 256; index = index + 1) 
            begin
                s = select;
                d = index;
                #1;
            end
    	end
    end
endmodule