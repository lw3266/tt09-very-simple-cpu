module simple_cpu (
    input  wire [7:0] ui_in,     // Dedicated inputs
    output wire [7:0] uo_out,    // Dedicated outputs
    input  wire [7:0] uio_in,    // IOs: Input path
    output wire [7:0] uio_out,   // IOs: Output path
    output wire [7:0] uio_oe,    // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,       // always 1 when the design is powered, so you can ignore it
    input  wire       clk,       // clock
    input  wire       rst_n      // reset_n - low to reset
);

    // Define registers
    reg [7:0] reg_a;   // Register A
    reg [7:0] reg_b;   // Register B
    reg [7:0] alu_out; // ALU output
    reg [1:0] alu_sel; // ALU operation selector

    // Instantiate ALU
    alu my_alu (
        .op_a(reg_a),
        .op_b(reg_b),
        .alu_sel(alu_sel),
        .alu_out(alu_out)
    );

    // CPU operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_a <= 8'b0;
            reg_b <= 8'b0;
            alu_sel <= 2'b0;
        end else begin
            reg_a <= ui_in;             // Load input to register A
            reg_b <= uio_in;            // Load IO input to register B
            alu_sel <= {ui_in[1:0]};    // Example: use lower 2 bits of input to select ALU operation
        end
    end

    // Output assignments
    assign uo_out = alu_out;            // Output the ALU result
    assign uio_out = reg_b;             // Output register B value
    assign uio_oe = 8'b11111111;        // Enable all IOs as outputs

endmodule: simple_cpu
