module control_unit (
    input wire [31:0] instruction,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,

    output reg alu_src,
    output reg alu_a_pc,

    output reg branch,
    output reg jump,
    output reg jalr,
    output reg is_m,

    output reg [1:0] wb_sel,
    output reg [2:0] imm_sel,

    output reg valid_instruction
);

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    always @(*) begin
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;

        alu_src = 0;
        alu_a_pc = 0;

        branch = 0;
        jump = 0;
        jalr = 0;
        is_m = 0;

        wb_sel = 0;
        imm_sel = 0;
        valid_instruction = 0;
        
        case (opcode)

            7'b0110011: begin
                valid_instruction = 1;
                reg_write = 1;
                wb_sel = 2'd0;
            end 
            7'b0010011: begin
            valid_instruction = 1;
            reg_write = 1;
            alu_src = 1;
            wb_sel = 2'd0;
            imm_sel = 3'd0;
        end
            7'b0000011: begin
        valid_instruction = 1;
        reg_write = 1;
        mem_read = 1;
        alu_src = 1;
        wb_sel = 2'd1;
        imm_sel = 3'd0;
    end
        7'b0100011: begin
        valid_instruction = 1;
        mem_write = 1;
        alu_src = 1;
        imm_sel = 3'd1;
    end
        7'b1100011: begin
        valid_instruction = 1;
        branch = 1;
        imm_sel = 3'd2;
    end
        7'b1101111: begin
        valid_instruction = 1;
        reg_write = 1;
        jump = 1;
        wb_sel = 2'd2;
        imm_sel = 3'd4;
    end
        7'b1100111: begin
        valid_instruction = 1;
        reg_write = 1;
        jump = 1;
        jalr = 1;
        alu_src = 1;
        wb_sel = 2'd2;
        imm_sel = 3'd0;
    end
        7'b0110111: begin
        valid_instruction = 1;
        reg_write = 1;
        wb_sel = 2'd0;
        imm_sel = 3'd3;
    end
        7'b0010111: begin
        valid_instruction = 1;
        reg_write = 1;
        alu_src = 1;
        alu_a_pc = 1;
        wb_sel = 2'd0;
        imm_sel = 3'd3;
    end
        endcase
    end

endmodule
