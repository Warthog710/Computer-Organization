//Quinn Roemer
//Extra Credit Assignment
//CSC 137 - Computer Organization
//05.03.2020

//Control circuit for a single bit
module singleBitControl(a, b, o);
    input a, b;
    output [0:3] o;

    and(o[0], a, b);
    or(o[1], a, b);
    xor(o[2], a, b);
    not(o[3], a);
endmodule

//4x1 Mux
module mux4X1(i, s, o);
    input [0:3] i;
    input [1:0] s;
    output o;

    wire not_s0, not_s1;
    wire [0:3] andOut;

    not(not_s0, s[0]);
    not(not_s1, s[1]);

    and(andOut[3], s[1], s[0], i[3]);
    and(andOut[2], s[1], not_s0, i[2]);
    and(andOut[1], not_s1, s[0], i[1]);
    and(andOut[0], not_s1, not_s0, i[0]);

    or(o, andOut[0], andOut[1], andOut[2], andOut[3]);
endmodule

//Complete single bit logic circuit
module logicCircuitOneBit(a, b, s, o);
    input a, b;
    input [0:1] s;
    output o;

    wire [0:3] controlOut;

    singleBitControl myControl(a, b, controlOut);
    mux4X1 myMux(controlOut, s, o);
endmodule

//Expands the single bit control module to 8 bits and adds 4 more logic operations
module eightBitControl(a, b, o);
    input [0:7] a, b;
    output [0:7][0:7] o;

    //And
    and(o[0][0], a[0], b[0]);
    and(o[1][0], a[1], b[1]);
    and(o[2][0], a[2], b[2]);
    and(o[3][0], a[3], b[3]);
    and(o[4][0], a[4], b[4]);
    and(o[5][0], a[5], b[5]);
    and(o[6][0], a[6], b[6]);
    and(o[7][0], a[7], b[7]);

    //OR
    or(o[0][1], a[0], b[0]);
    or(o[1][1], a[1], b[1]);
    or(o[2][1], a[2], b[2]);
    or(o[3][1], a[3], b[3]);
    or(o[4][1], a[4], b[4]);
    or(o[5][1], a[5], b[5]);
    or(o[6][1], a[6], b[6]);
    or(o[7][1], a[7], b[7]);

    //XOR
    xor(o[0][2], a[0], b[0]);
    xor(o[1][2], a[1], b[1]);
    xor(o[2][2], a[2], b[2]);
    xor(o[3][2], a[3], b[3]);
    xor(o[4][2], a[4], b[4]);
    xor(o[5][2], a[5], b[5]);
    xor(o[6][2], a[6], b[6]);
    xor(o[7][2], a[7], b[7]);

    //Complement A
    not(o[0][3], a[0]);
    not(o[1][3], a[1]);
    not(o[2][3], a[2]);
    not(o[3][3], a[3]);
    not(o[4][3], a[4]);
    not(o[5][3], a[5]);
    not(o[6][3], a[6]);
    not(o[7][3], a[7]);

    //NOR
    nor(o[0][4], a[0], b[0]);
    nor(o[1][4], a[1], b[1]);
    nor(o[2][4], a[2], b[2]);
    nor(o[3][4], a[3], b[3]);
    nor(o[4][4], a[4], b[4]);
    nor(o[5][4], a[5], b[5]);
    nor(o[6][4], a[6], b[6]);
    nor(o[7][4], a[7], b[7]);

    //XNOR
    xnor(o[0][5], a[0], b[0]);
    xnor(o[1][5], a[1], b[1]);
    xnor(o[2][5], a[2], b[2]);
    xnor(o[3][5], a[3], b[3]);
    xnor(o[4][5], a[4], b[4]);
    xnor(o[5][5], a[5], b[5]);
    xnor(o[6][5], a[6], b[6]);
    xnor(o[7][5], a[7], b[7]);

    //Complement B
    not(o[0][6], b[0]);
    not(o[1][6], b[1]);
    not(o[2][6], b[2]);
    not(o[3][6], b[3]);
    not(o[4][6], b[4]);
    not(o[5][6], b[5]);
    not(o[6][6], b[6]);
    not(o[7][6], b[7]);

    //NAND
    nand(o[0][7], a[0], b[0]);
    nand(o[1][7], a[1], b[1]);
    nand(o[2][7], a[2], b[2]);
    nand(o[3][7], a[3], b[3]);
    nand(o[4][7], a[4], b[4]);
    nand(o[5][7], a[5], b[5]);
    nand(o[6][7], a[6], b[6]);
    nand(o[7][7], a[7], b[7]);
endmodule

//Signal decoder for 8x1 Mux
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

//8x1 Mux
module mux8X1(s, d, o);
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

//Complete 8bit logic circuit with extended functionality
module logicCircuitEightBits(a, b, s, o);
    input [0:7] a, b;
    input [0:2] s;
    output [0:7] o;

    wire [0:7][0:7] controlOut;

    eightBitControl myControl(a, b, controlOut);

    mux8X1 myMux0(s, controlOut[0], o[0]);
    mux8X1 myMux1(s, controlOut[1], o[1]);
    mux8X1 myMux2(s, controlOut[2], o[2]);
    mux8X1 myMux3(s, controlOut[3], o[3]);
    mux8X1 myMux4(s, controlOut[4], o[4]);
    mux8X1 myMux5(s, controlOut[5], o[5]);
    mux8X1 myMux6(s, controlOut[6], o[6]);
    mux8X1 myMux7(s, controlOut[7], o[7]);
endmodule

//Test module
module testMod;
    reg [0:7] a, b;
    reg [0:2] s;
    wire [0:7] o;

    integer count;
    
    logicCircuitEightBits myLogic(a, b, s, o);

    initial begin
        $display("Time  A.......  B.......  S..  O.......");
        $display("----  --------  --------  ---  --------");
        $monitor("%4d  %b  %b  %b  %b", $time, a, b, s, o);
    end

    initial begin
    a = 8'b11001010;
    b = 8'b01101001;

        for (count = 0; count < 8; count = count + 1)
        begin
            s = count;
            #1;
        end    
    end
endmodule