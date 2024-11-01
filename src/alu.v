module alu (
    input  wire [7:0] op_a,      // Operand A
    input  wire [7:0] op_b,      // Operand B
    input  wire [1:0] alu_sel,   // ALU operation select
    output reg  [7:0] alu_out    // ALU result
);

    always @(*) begin
        case (alu_sel)
            2'b00: alu_out = op_a + op_b;       // Addition
            2'b01: alu_out = op_a - op_b;       // Subtraction
            2'b10: alu_out = op_a * op_b;       // Multiplication
            2'b11: alu_out = op_a / op_b;       // Division
            default: alu_out = 8'b0;
        endcase
    end

endmodule: alu
