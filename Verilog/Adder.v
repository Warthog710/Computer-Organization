//Quinn Roemer
//5bit Adder
//CSC 137, Programming Assignment #3
//04.07.2020

//A single full adder module
module fullAdder(cIn, x, y, sum, cOut);
    input x, y, cIn;
    output sum, cOut;

    wire xOut1, aOut1, aOut2;

    //Gate operations
    xor(xOut1, x, y);
    xor(sum, xOut1, cIn);
    and(aOut1, x, y);
    and(aOut2, cIn, xOut1);
    or(cOut, aOut1, aOut2);
endmodule

//Chains 5 fullAdder modules to produce a 5bit adder
module fiveBitAdder(x, y, cIn, sum, cOut);
    input [4:0] x, y;
    input cIn;
    output [0:4] sum;
    output cOut;

    wire cOut1, cOut2, cOut3, cOut4;

    //Process input
    fullAdder fullAdderOne(cIn, x[0], y[0], sum[4], cOut1);
    fullAdder fullAdderTwo(cOut1, x[1], y[1], sum[3], cOut2);
    fullAdder fullAdderThree(cOut2, x[2], y[2], sum[2], cOut3);
    fullAdder fullAdderFour(cOut3, x[3], y[3], sum[1], cOut4);
    fullAdder fullAdderFive(cOut4, x[4], y[4], sum[0], cOut);
endmodule

module testMod;
    parameter STDIN=32'h8000_0000;
    reg[7:0] str[1:3];
    reg[4:0] x, y;
    wire[0:4] sum;
    wire cOut;
    wire cIn=0;

    //Create five bit adder
    fiveBitAdder myAdder(x, y, cIn, sum, cOut);

    initial begin
        //Get X
        $display("Enter X: ");
        str[1]=$fgetc(STDIN);
        str[2]=$fgetc(STDIN);
        str[3]=$fgetc(STDIN);

        //Convert to value
        x = ((str[1] - 48) * 10) + (str[2] - 48);

        //Get Y
        $display("Enter Y: ");
        str[1]=$fgetc(STDIN);
        str[2]=$fgetc(STDIN);
        str[3]=$fgetc(STDIN);
        
        //Convert to value
        y = ((str[1] - 48) * 10) + (str[2] - 48);

        //Process input in adder
        #1; 

        //Display results
        $display("X = %d (%b) Y = %d (%b)", x, x, y, y);
        $display("Result = %d (%b) C5 = %b", sum, sum, cOut);       
    end    
endmodule
